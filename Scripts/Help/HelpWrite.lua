
local ConvLua = require"lua52html"
local P = {}

local _KNOWNGLOBALS

local vers = {
	[6] = "[MM6]",
	[7] = "[MM7]",
	[8] = "[MM8]",
	[7+8] = "[MM7+]",
	[6+8] = "[MM6, MM8]",
	[6+7] = "[MM6, MM7]",
}

local SectByKind = {evt = "Evt Commands", event = "Events", file = "Functions", struct = "Structures", const = "Constants"}

local LinkConv = {}

for k, t in pairs(HelpStructs) do
	if t[1].Kind == "struct" and t[1].Name ~= k then
		LinkConv["^"..t[1].Name.."$"] = k
		LinkConv["^"..t[1].Name.."%."] = k.."."
	end
end

function P.ExpandRef(link)
	for k, v in pairs(LinkConv) do
		link = link:gsub(k, v)
	end
	return link
end

-----------------------------------------------------
-- print them all
-----------------------------------------------------

function P.PrintStructStart(name, desc, ver, kind)
	if ver then
		desc = "["..ver.."] "..(desc or "")
	end
	if name then
		print(unpack{"BEGIN", name, desc})
	end
end

function P.PrintStructEnd(name)
	print("END", name)
	print("")
end

function P.PrintLine(name, link, sig, desc, ver, default, val)
	local s = name..(sig or "")
	if link then
		s = s.." -> "..link
	end
	if default then
		desc = "{Default} "..(desc or "")
	end
	if ver then
		desc = ver.." "..(desc or "")
	end
	print(unpack{s, desc, val and "= "..val})
end

function P.PrintFunctionsStart(kind)
	print('|-- '..(kind == "method" and (P.TxtMethods or "Methods") or (P.TxtFunctions or "Functions"))..' --|')
end

function P.PrintSectionStart(sect)
	print("")
	print("SECTION", SectByKind[sect])
	print("")
end

function P.PrintFinish()
end

-----------------------------------------------------
-- generate HTML
-----------------------------------------------------

function P.HTML(TXT)

local FirstHeading = [[


<br>
<h2>%s</h2>
]]

local Heading = [[


<br>
<hr>
<h2>%s</h2>
]]

local StructStart = [[

<br>%s
<table class="def-table">
<tbody>
<tr>
<td colspan="2" class="def-caption">
%s
%s
&nbsp;%s<br>
</td>
</tr>
]]

local StructLineNoTr = [[
<td class="def-left">
%s
</td><td class="def-right">
%s
</td>
]]

local StructLine = "<tr>\n"..StructLineNoTr.."</tr>"

local FunctionsLine = [[
<tr>
<td colspan="2" class="def-functions"><br>
  &nbsp;%s
</td>
</tr>
]]

local StructEnd = [[
</tbody>
</table>
<br>
]]

local EvtStructStart = [[
<tr>
<td colspan="2" class="def-caption">
<br>%s
%s
%s
&nbsp;%s<br>
</td>
</tr>
]]

local LinkDef = [[<a name="%s" ></a>]]
local LocalLinkDef = [[<a name="%s"></a>]]
local NameLink = [[<a href="%s">%s</a>]]
local VerFmt = [[<span class="def-ver">%s</span>]]
local VerDescFmt = VerFmt..'<span class="def-nbsp"> </span> %s'
local DefFmt = [[<b class="def-default">(Default)</b>]]
local FuncSig = [[<b class="def-largs">%s</b>%s<b class="def-rargs">%s</b>]]
local ConstVal = [[ <i class="def-const">= %s</i>]]
local EvtName = [[<h4 class="def-h4">%s</h4>]]
local FuncName = [[<h5 class="def-h5">%s</h5>]]
local FileWithPath = [[<span class="def-shadow">%s </span>%s]]
local TocMore = [[<h5 class="def-hidden">&#8230;</h5>]]

	TXT = TXT or {}
	local template = TXT.SectionText or {}
	local t = {template[2]}
	local sect, SFields, firstStruct
	local nsect = 2
	local structLinkName
	local structNoChildTOC
	
	local function add(s, ...)
		t[#t+1] = s:format(...)
	end
	
	local function ConvertLua(code, div)
		-- print(code)
		local start = code:match("^(\n*)")
		local s = ""
		ConvLua.highlight(code, function(s1)
			s = s..s1
		end)
		s = start..s:match("^\n*(.*)")
		s = s:gsub("\n", "<br>")
		-- print(s)
		if div then
			return '<div class="def-codeblock">'..s..'</div>'
		end
		return '<span class="def-code">'..s..'</span>'
	end
	local function ConvertCode(code, div)
		local s = code:gsub("\n", "<br>")
		s = s:gsub('\t', '<span class="lua5-tab">&#9;</span>')  -- tabs
		if div then
			return '<div class="def-codeblock">'..s..'</div>'
		end
		return '<span class="def-code">'..s..'</span>'
	end
	local function par(s)
		return s:gsub('"', "&quot;")  -- escape tag parameter
	end
	local function url(s)
		return par(s):gsub('[%z\001- %?&/]', |s| ('%%%x'):format(s:byte()))
	end

	local function Link(link, s)
		return NameLink:format('#'..url(P.ExpandRef(link)), s)
	end
	
	local function LinkEx(link, s)
		return NameLink:format(link, s)
	end	

	local function esc(s)
		s = s:gsub('\r', '')
		local lua = {}
		s = s:gsub('\n?![Ll][Uu][Aa]%[(=*)%[\n(.-)\n?%]%1%]\n?(\001?)', function(_, code, after)
			local i = #lua + 1
			lua[i] = ConvertLua(code, true)
			return "\001LUA["..i.."]"..(after == "" and "\n" or "")
		end)
		s = s:gsub('![Ll][Uu][Aa]%[(=*)%[(.-)%]%1%]', function(_, code)
			local i = #lua + 1
			lua[i] = ConvertLua(code)
			return "\001LUA["..i.."]"
		end)
		s = s:gsub('\n?![Cc][Oo][Dd][Ee]%[(=*)%[\n(.-)\n?%]%1%]\n?(\001?)', function(_, code, after)
			local i = #lua + 1
			lua[i] = ConvertCode(code, true)
			return "\001LUA["..i.."]"..(after == "" and "\n" or "")
		end)
		s = s:gsub('![Cc][Oo][Dd][Ee]%[(=*)%[(.-)%]%1%]', function(_, code)
			local i = #lua + 1
			lua[i] = ConvertCode(code)
			return "\001LUA["..i.."]"
		end)
		s = s:gsub('&', '&amp;')
		s = s:gsub('<', '&lt;')
		s = s:gsub('>', '&gt;')
		s = s:gsub("!Params%[(=*)%[(.)(.-)(.)%]%1%]", '<b class="def-largs-i">%2</b>%3<b class="def-rargs-i">%4</b>')
		s = s:gsub('!(%w+)%[(=*)%[(.-)%]%2%]', "<%1>%3</%1>")
		s = s:gsub('\t', '  ')
		s = s:gsub('([\n ])( +)', '%1<span class="def-nbsp">%2</span>')
		s = s:gsub('\n', '<br>')
		s = s:gsub(" %- ([^0-9])", " &ndash; %1")
		s = s:gsub("([0-9]) %- ([0-9])", "%1 &ndash; %2")
		s = s:gsub("'([%w_%.]+)'", '<b class="def-param">%1</b>')
		s = s:gsub("!'%[(=*)%[(.-)%]%1%]", '<b class="def-param">%2</b>')
		s = s:gsub("'/(.-)/'", '&nbsp;<i class="def-ib">%1</i>')
		s = s:gsub("!\\ (%a+)", '<span class="def-vspace">%1</span>')
		s = s:gsub("#(%a[%w_%.%* ]*):([^#]*)#", |s1, s2| Link(s2 ~= "" and s2 or s1, s1))
		s = s:gsub("(%a[%w_]*):(const%.%a[%w_%.]*)", |s1, s2| Link(s2, s1))
		s = s:gsub("(%a[%w_]*):(const)([^%.%w_])", |s1, s2, s3| Link(s2, s1)..s3)
		s = s:gsub("(%a[%w_]*):(const)$", |s1, s2| Link(s2, s1))
		s = s:gsub("(%a[%w_]*):(structs%.%a[%w_%.]*)", |s1, s2| Link(s2, s1))
		s = s:gsub("#%[(=*)%[(.-)%]%1%]([^#]*)#", |_, s1, s2| LinkEx(s1, s2 ~= "" and s2 or s1))
		for k, v in pairs(vers) do
			s = s:replace(v, VerFmt:format(v))
		end
		s = s:gsub("\001LUA%[(.-)%]", function(i)
			return lua[tonumber(i)]
		end)
		s = s:gsub("\001", "")  -- marker of no \r after !Lua[[...]] at the end
  	return s  -- escape text
	end
	
	local function ComposeDesc(desc, ver, default)
		local s = (default and DefFmt or "").." "..esc(desc or "")
		return (ver and VerDescFmt:format(ver,s) or s)
	end

	function P.PrintStructStart(name, desc, ver, linkName, kind, NoChildTOC)
		structLinkName = linkName
		structNoChildTOC = NoChildTOC
		linkName = linkName and LinkDef:format(url(linkName)) or ""
		if name then
			name = esc(name)
			local dir, fname = name:match("^(.-[\\/])([^\\/]*)$")
			if dir then
				name = FileWithPath:format(dir, fname)
			end
		end
		name = name and "<h3>"..name.."</h3>" or ""
		if NoChildTOC then
			name = name..TocMore
		end
		local s = ComposeDesc(desc and desc.."\001", ver)
		local fmt = (sect == "evt" and not firstStruct and EvtStructStart or StructStart)
		add(fmt, linkName, name, s ~= " " and s.."<br><br>" or s, SFields[kind] or SFields[true])
		firstStruct = nil
	end

	function P.PrintStructEnd(name)
		add(sect == "evt" and "" or StructEnd)
	end
	
	local function ConvFunc(fparams)
		return esc(fparams):gsub("([%w_]+): ?([%w_]+%.[%w_]+)", function(s, link)
			return Link(link, s)
		end)
	end

	function P.PrintLine(name, link, sig, desc, ver, default, val, pow2)
		local s = esc(name)
		if link then
			s = Link(link, s)
		end
		-- parse signature!
		local fparams = sig and sig:match("^%((.*)%)$")
		local tparams = (fparams and fparams:match("\n}") and fparams:match("^{\r?(.*)}$"))
		if tparams then
			if not tparams:match("\n  ") then
				tparams = tparams:gsub("\n([^}])", "\n  %1")
			end
			fparams = FuncSig:format("{", ConvFunc(tparams), "}")
		elseif fparams then
			fparams = FuncSig:format("(", ConvFunc(fparams), ")")
		end
		if sect == "event" then
			s = LinkDef:format(url("events."..name))..EvtName:format(s)
		elseif sect == "file" then
			if structNoChildTOC then
				s = LocalLinkDef:format(url(name))..s
			else
				s = FuncName:format(s)
			end
		elseif structLinkName then
			s = LocalLinkDef:format(url(structLinkName.."."..name))..s
		end
		s = s..(fparams or esc(sig or ""))
		if val then
			s = s..ConstVal:format(pow2 and ("0x%X"):format(val) or val)
		end
		add(StructLine, s, ComposeDesc(desc, ver, default))
	end

	function P.PrintFunctionsStart(kind)
		add(FunctionsLine, SFields[kind] or SFields[true])
	end

	local NameByKind = TXT.SectionNames or {}
	local FieldsByKind = TXT.SectionFields or {evt = "Parameters", event = "Events", file = "Variables", struct = "Fields", const = "Values"}
	local NoFieldsByKind = TXT.SectionNoFields or {evt = "Has no parameters."}
	
	function P.PrintSectionStart(kind)
		if sect == "evt" then
			add(StructEnd)
		end
		add(sect and Heading or FirstHeading, NameByKind[kind] or SectByKind[kind])
		firstStruct = true
		sect = kind
		
		SFields = {
			["function"] = TXT.TxtFunctions or "Functions:",
			method = TXT.TxtMethods or "Methods:",
			[true] = (FieldsByKind[kind] or kind)..":",
			[false] = NoFieldsByKind[kind],
		}
		for k, v in pairs(SFields) do
			SFields[k] = (kind ~= "evt" and '<i class="def-ib">'..v..'</i>' or '<i>'..v..'</i>')
		end
		nsect = nsect + 1
		t[#t+1] = template[nsect] or ""
	end

	function P.PrintFinish(TOC)
		if sect == "evt" then
			add(StructEnd)
		end
		sect = true
		-- make TOC if it's not specified...
		local s = (template[1] or "")..TOC..table.concat(t)
		t = {}
		return s
	end
end

-----------------------------------------------------
-- iterate HelpStructs
-----------------------------------------------------

local StructWritten = {}

local function GetVer(t, t1)
	local n = 0
	for i = 6, 8 do
		n = n + (t[i] and i or 0)
	end
	if not t1 or vers[n] ~= GetVer(t1) then
		return vers[n]
	end
end

local function IsPower2(struct)
	local power2 = {}
	local k = 1
	for i = 0, 31 do
		power2[k] = true
		k = 2*k
	end
	local MaxVal = 0
	for i = 2, #struct do
		local t = struct[i]
		if t.Val and not power2[t.Val] then
			return
		elseif t.Val and t.Val > MaxVal then
			MaxVal = t.Val
		end
	end
	return MaxVal > 256
end

local WriteFields
local function WriteField(t, prefix, func, pow2, struct)
	local sig = func and "("..(t.Sig or "")..")" or t.Sig
	sig = sig or t.ArrayCount and ("[]"):rep(t.ArrayCount or 0)
	local tp = t.Type
	local union = tp and tp:match("%..*%.")
	if union and not sig and not t[1] then  -- union
		StructWritten[tp] = true
		WriteFields(tp, prefix..t.Name..".", nil)
	else
		if union and t.Sig then  -- union manually turned into array
			StructWritten[tp] = true
			tp = (HelpStructs[tp][2] or {}).Type
		end
		-- if sig == "(Color, Unk = 1)" then
		-- 	local _NOGLOBALS_END
		-- 	print(t[1])
		-- end
		P.PrintLine(prefix..t.Name, tp, sig, t[1], GetVer(t, struct[1]), t.Default, t.Val, pow2)
	end
end

function WriteFields(StructName, prefix, func)
	local struct = HelpStructs[StructName]
	local pow2 = (struct[1].Kind == "const" and IsPower2(struct))
	for i = 2, #struct do
		local t = struct[i]
		if t.Kind == func then
			WriteField(t, prefix, func ~= nil, pow2, struct)
		end
	end
end

local function HasFields(t, kind)
	for i = 2, #t do
		if t[i].Kind == kind then
			return kind or true
		end
	end
end

function P.WriteStruct(name, kind, NoLink, SkipEmpty)
	if StructWritten[name] then
		return
	end
	StructWritten[name] = true
	local t = HelpStructs[name]
	local basic = not kind or nil
	
	local sec = {}
	sec[#sec+1] = HasFields(t, kind)
	sec[#sec+1] = basic and HasFields(t, "function")
	sec[#sec+1] = basic and HasFields(t, "method")
	if SkipEmpty and not sec[1] then
		return
	end
	local t = t[1]
	local desc = t[kind == "event" and "EventsInfo" or 1]
	P.PrintStructStart(t.Name, desc, GetVer(t), not NoLink and name or nil, sec[1] or false, t.NoChildTOC)
	for i, s in ipairs(sec) do
		if i ~= 1 then
			P.PrintFunctionsStart(s)
		end
		WriteFields(name, "", s ~= true and s or nil)
	end
	P.PrintStructEnd(t.Name)
end


local StructByKind = {event = "file"}
local FieldByKind = {event = "event"}
local EventWritten = {}

function P.WriteSection(kind, NoLink, WriteFirst)
	if kind == "event" then
		StructWritten, EventWritten = EventWritten, StructWritten
	end
	P.PrintSectionStart(kind)
	local struct = StructByKind[kind] or kind
	local field = FieldByKind[kind]
	for _, k in ipairs(WriteFirst or {}) do
		if HelpStructs[k][1].Kind == struct then
			P.WriteStruct(k, field, NoLink, struct == "file" and NoLink)
		end
	end
	for k, t in sortpairs(HelpStructs) do
		if t[1].Kind == struct then
			P.WriteStruct(k, field, NoLink, struct == "file" and NoLink)
		end
	end
	if kind == "event" then
		StructWritten, EventWritten = EventWritten, StructWritten
	end
end

P.DefStyle = [[
.def-table { margin:6px 0;border:1px solid #a5a5a5;border-collapse:collapse;width:100%; }
.def-caption { padding:4px 5px 5px; border:1px solid #a5a5a5; }
.def-left { width:350px;padding:4px 4px 3px; border:1px solid #a5a5a5;overflow-x:auto; }
.def-right { padding:4px 4px 3px; border:1px solid #a5a5a5;overflow-x:auto; }
.def-functions { padding:4px 5px 5px; border:1px solid #a5a5a5; }
.def-ver { color:rgb(153,0,0); }
.def-nbsp { white-space:pre-wrap; }
.def-const { position:relative;float:right;right:2px;display:inline-block; }
.def-h4 { display:inline; }
.def-h5 { display:inline; font-weight: inherit; font-size: inherit; }
.def-shadow { color:#a5a5a5; }
.def-codeblock { white-space:pre-wrap; font-family: monospace,monospace; font-size: 85%; margin: 0.7em 0 -0.8em 0.8em; }
.def-code { white-space:pre-wrap; font-family: monospace,monospace; font-size: 85%; }
.def-param { color:#079; }
.def-ib { font-weight: bold; }
.def-default { }
.def-hidden { display: none; }
.def-largs { margin: 0 0.25em 0 0.5em; }
.def-rargs { margin-left: 0.25em; }
.def-largs-i { margin: 0 0.2em 0 0.16em; }
.def-rargs-i { margin-left: 0.2em; }
.def-vspace { display: inline-block; margin-top: 0.7em; margin-bottom: 0.1em; }
.lua5-operator { font-weight: bold; color: #333; }
.lua5-note { font-weight: bold; color: #00D; }
.lua5-ctrl { font-weight: bold; color: Black; }
.lua5-std { color: Brown; }
.lua5-literal { font-weight: bold; color: #079; }
.lua5-str { color: #90A; }
.lua5-comment { color: #009000; }
.lua5-tab { display: inline-block; width: 2ch; }
]]

P.new = debug.getinfo(1, "f").func

return P
