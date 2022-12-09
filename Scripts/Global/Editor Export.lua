--[[
To disable 90 degree rotation that makes Y axis the vertical one in .obj file,
put this code into a separate file in Scripts/General folder:
 Editor = Editor or {}
 Editor.NoExportRotation = true
Most 3D editors default to doing the rotation, so I do it by default as well.
Or you can write "Editor.NoExportRotation = true" in the Ctrl+F1 console.
Similarly, you can set Editor.ImportScale parameter. All coordinates will be
multiplied by it on import and divided on export.
]]--

Editor = Editor or {}
os.mkdir = os.mkdir or path.CreateDirectory  -- compatibility with old version
local _KNOWNGLOBALS = VFlipUnfixed, BitmapsHDScale
local mmver = Game.Version
local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local concat = table.concat

local mtlStr = {[false] = [[

newmtl %s
	map_Tr %s
	map_d %s
	map_Ka %s
	map_Kd %s]], [true] = [[
	
newmtl %s
	map_Ka %s
	map_Kd %s]]
}

local mtlStrI = {[false] = [[

newmtl %s
	d 0.3
	Tr 0.7
	map_d %s
	map_Ka %s
	map_Kd %s]], [true] = [[
	
newmtl %s
	d 0.3
	Tr 0.7
	map_Ka %s
	map_Kd %s]]
}


function Editor.ExportObj(file, models, withGround, CenterPoint)
	Editor.CheckLazyModels()
	local state = Editor.State
	local scale = 1/(state.ImportScale or Editor.ImportScale or 1)
	models = models or state.RoomObj
	if not models then
		models, withGround, CenterPoint = state.ModelByName, true, nil
	end
	if Editor.ExportMergeRooms and models == state.RoomObj then
		local all = {}
		for _, m in pairs(state.RoomObj) do
			for f in pairs(m.BaseFacets) do
				all[f] = true
			end
		end
		models = {["_All_Rooms_"] = {BaseFacets = all}}
	end
	local fileMTL = path.setext(file, ".mtl")
	local MapName = Editor.FileName or Editor.DefaultFileName
	local MapName = MapName and path.name(MapName) or Map.Name
	local mtl = "# Model MTL from %q map from MM%d."
	local obj = "# OBJ for %q map from MM%d.\r\nmtllib %s"
	if CenterPoint then
		mtl = "# MTL for %q map from MM%d."
		obj = "# Model OBJ from %q map from MM%d.\r\nmtllib %s"
	end
	local mtl = {mtl:format(MapName, Game.Version)}
	local obj = {obj:format(MapName, Game.Version, path.name(fileMTL))}
	
	-- vertex output
	local function VertexStr(x, y, z)
		if not (state.NoExportRotation or state.NoExportRotation == nil and Editor.NoExportRotation) then
			y, z = z, -y
		end
		return concat({"v", x*scale, y*scale, z*scale}, " ")
	end
	
	-- textures
	local texpath = {}
	local textures = {}
	local function WriteTexture(bmp, extra, invis)
		local bmp1 = bmp:lower()..(extra and ":g" or "")
		
		if not textures[bmp1] then
			bmp = bmp:match("[^:]*")
			textures[bmp1] = true
			local place = ".textures/"..(extra and "ground/" or "")
			local bmpPath = path.setext(path.name(file), place)..bmp
			local mypath = texpath[place]
			if not mypath then
				mypath = path.setext(file, place)
				texpath[place] = mypath
				os.mkdir(mypath)
			end
			-- mem.dll.kernel32.CopyFileA(AppPath.."Data\\Bitmaps\\"..bmp..".bmp", texpath..bmp..".bmp", false)
			local IsBmp = Editor.ExtractTexture(bmp, mypath..bmp, extra)
			bmpPath = bmpPath..(IsBmp and ".bmp" or ".png")
			local mtlStr = (invis and mtlStrI or mtlStr)
			mtl[#mtl + 1] = mtlStr[IsBmp]:format(bmp1, bmpPath, bmpPath, bmpPath, bmpPath)
		end
		obj[#obj + 1] = "usemtl "..bmp1
		-- obj[#obj + 1] = "s off"
	end	
	
	-- vertex textures
	local function Change(t, f, ind)
		local m
		for i, a in ipairs(t) do
			m = m and f(m, a[ind]) or a[ind]
		end
		if m and m ~= 0 then
			for i, a in ipairs(t) do
				a[ind] = a[ind] - m
			end
		end
	end	
	
	local function MakeVTs(f)
		local t = {}
		local bmp = Game.BitmapsLod.Bitmaps[Game.BitmapsLod:LoadBitmap(f.Bitmap)]
		local bw, bh = bmp.Width, bmp.Height
		if BitmapsHDScale then
			bw, bh = bw/2, bh/2
		end
		local fu, fv = f.BitmapU, f.BitmapV
		local ux, uy, uz, vx, vy, vz = Editor.GetUVDirections{
			NormalX = math.round(f.nx*0x10000),
			NormalY = math.round(f.ny*0x10000),
			NormalZ = math.round(f.nz*0x10000),
		}
		if f.ImportVertex then
			local vertX, vertY, vertZ = f.ImportVertex.X, f.ImportVertex.Y, f.ImportVertex.Z
			fu = fu or -(ux*vertX + uy*vertY + uz*vertZ) + f.ImportU*bw
			fv = fv or -(vx*vertX + vy*vertY + vz*vertZ) + f.ImportV*bh
		else
			fu = fu or 0
			fv = fv or 0
			-- handle shift
			if f.Door and not f.DoorStaticBmp then
				for _, v in ipairs(f.Vertexes) do
					if v.Shift then
						local vertX, vertY, vertZ = XYZ(v.Shift)
						fu = fu - (ux*vertX + uy*vertY + uz*vertZ)
						fv = fv - (vx*vertX + vy*vertY + vz*vertZ)
						break
					end
				end
			end
		end
		local vflip = (vy == -1 and VFlipUnfixed and not state.RoomObj)
		for i, v in ipairs(f.Vertexes) do
			local vertX, vertY, vertZ = v.X, v.Y, v.Z
			local u = (fu + ux*vertX + uy*vertY + uz*vertZ)/bw
			local v = (fv + vx*vertX + vy*vertY + vz*vertZ)/bh
			if vflip then
				t[i] = {"vt", u, v}
			else
				t[i] = {"vt", u, 1 - v}
			end
		end
		if f.AlignLeft then
			Change(t, min, 2)
		elseif f.AlignRight then
			Change(t, max, 2)
		end
		if f.AlignTop then
			Change(t, (vflip and min or max), 3)
		elseif f.AlignBottom then
			Change(t, (vflip and max or min), 3)
		end
		for i = 1, #t do
			t[i] = concat(t[i], " ")
		end
		return t
	end

	-- do the writing
	local DonePortals = {}
	local texture
	local vn = 0
	local vtn = 0
	
	-- ground
	if withGround then
		local hm, tiles = state.HeightMap, state.TileMap
		local sets = {}
		local LastTex
		-- group
		obj[#obj + 1] = ""
		obj[#obj + 1] = "g _Ground_"
		-- vertices
		for y = 0, 127 do
			for x = 0, 127 do
				local i = y*128 + x + 1
				obj[#obj + 1] = VertexStr((x - 64)*0x200, (64 - y)*0x200, hm:byte(i)*32)
				vn = vn + 1
			end
		end
		-- vt
		vtn = 4
		obj[#obj + 1] = "vt 0 1"
		obj[#obj + 1] = "vt 1 1"
		obj[#obj + 1] = "vt 0 0"
		obj[#obj + 1] = "vt 1 0"
		-- maybe create a box X, Y = -0x5800..0x5800, Z = 0..255.5*32
		-- do
			-- local vbase = vn
			-- for z = 0, 1 do
				-- for y = 0, 1 do
					-- for x = 0, 1 do
						-- obj[#obj + 1] = VertexStr((x - 0.5)*0xB000, (y - 0.5)*0xB000, z*255.5*32)
						-- vn = vn + 1
					-- end
				-- end
			-- end
		-- end
		-- facets
		for y = 0, 126 do
			for x = 0, 126 do
				local i = y*128 + x + 1
				local j = tiles:byte(i)
				local base = j
				if j >= 90 and j <= 233 then
					j = j - 90
					base = Map.Tilesets[j:div(36)].Offset
					j = j % 36 + base
				end
				local bmp = (Game.CurrentTileBin or Game.TileBin)[j].Name
				if bmp ~= texture then
					texture = bmp
					WriteTexture(texture, (Game.CurrentTileBin or Game.TileBin)[base].Name)
				end
				obj[#obj + 1] = concat({"f ", i, "/1 ", i + 129, "/4 ", i + 1, "/2"})
				obj[#obj + 1] = concat({"f ", i, "/1 ", i + 128, "/3 ", i + 129, "/4"})
			end
		end
	end
	
	-- rooms/models
	Editor.ShiftVertexes(true)
	texture = nil
	for name, r in pairs(models) do
		local VertexIds = {}
		local LocVer = {}
		if next(r.BaseFacets) then
			obj[#obj + 1] = "g "..name
		end
		obj[#obj + 1] = ""
		local LocVerInd = #obj
		for f in pairs(r.BaseFacets) do
			if not f.IsPortal or not DonePortals[f] then
				-- local bmp = (f.Bitmap or f.Invisible and "_Invisible_" or "pending")
				local bmp = f.Bitmap or "pending"
				if f.IsPortal then
					DonePortals[f] = true
					bmp = "_Portal_"
				-- elseif f.Invisible then
					-- bmp = "_Invisible_"
				-- elseif mmver > 6 and f.Invisible and (f.Id or 0) == 0 then
					-- facet with Id may be shown by an EVT command, but not the ones without it
					-- MM6 uses exact facet indeces, so this trick won't work
					-- bmp = "_Invisible_"
				elseif f.Invisible then
					bmp = bmp..":i"
				end
				
				if bmp ~= texture then
					texture = bmp
					WriteTexture(texture, nil, f.Invisible)
				end

				local vt = MakeVTs(f)
				local t = {"f"}
				for i, v in ipairs(f.Vertexes) do
					if not VertexIds[v] then
						vn = vn + 1
						VertexIds[v] = vn
						local dx, dy, dz = 0, 0, 0
						if CenterPoint then
							dx, dy, dz = XYZ(CenterPoint)
						end
						LocVer[#LocVer + 1] = VertexStr(v.X - dx, v.Y - dy, v.Z - dz)
					end
					if vt[i] then
						vtn = vtn + 1
						LocVer[#LocVer + 1] = vt[i]
						t[i + 1] = VertexIds[v].."/"..vtn
					else
						t[i + 1] = VertexIds[v]
					end
				end
				obj[#obj + 1] = concat(t, " ")
			end
		end
		obj[LocVerInd] = concat(LocVer, "\r\n")
	end
	Editor.ShiftVertexes(false)
	
	-- write
	io.SaveString(file, concat(obj, "\r\n"))
	io.SaveString(fileMTL, concat(mtl, "\n"))
end


function Editor.ExportModelTemplate(file, models, pos)
	Editor.ExportObj(file, models, false, pos)
end
