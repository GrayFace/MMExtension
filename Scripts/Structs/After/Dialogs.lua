local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, r4, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.r4, mem.pchar, mem.call
local mmver = offsets.MMVersion
local is6 = mmver == 6 or nil
local is7 = mmver == 7 or nil
local is8 = mmver == 8 or nil
local is78 = mmver > 6 or nil

-- TODO: text draw options

local class, item, dummy, handlers = {}, {}, {}, {}
local ClassMeta, ItemMeta = {__index = class}, {__index = item}
local ActBtn, ActHint, ActUp = const.Actions.CustomDialogButton, const.Actions.CustomDialogHint, const.Actions.CustomDialogMouseUp
local DlgCount = 0
local ItemByPointer = setmetatable({}, {__mode = 'v'})
local GotDown, GotDbl, GotMove
local HoverItem, HoverFrame
local DownItem
local FocusedDialog
local ClickedItems, ClickTime = {}, nil
local IDCusDlg, IDBlockInteraction, IDBlock, BlockCount, CreatingOO = const.DlgID.CustomDialog, const.DlgID.BlockDialogs, const.DlgID.BlockDialogsNoDraw, 0, nil
local NoFoodGold, NeedRestore

local function callback(f, ...)
	if f then
		return f(...)
	end
end

local function EnableHandlers(t, on)
	for k, v in pairs(t) do
		events[on and 'add' or 'remove'](k, v)
	end
end

local function Defaults(t)
	t.TmpIcons = t.TmpIcons ~= false
	t.Pause = t.Pause ~= false
	t.AutoEsc = is8 and t.AutoEsc == nil and t.Screen ~= 13 or t.AutoEsc
	t.Screen = t.Screen or t.Screen ~= false
	t.LastScreen = Game.CurrentScreen
	t.LastMimicScreen = Game.EscMessageLastScreen
end

local function Apply1(self, t)
	t.TmpIcons = (not self.TmpIcons or nil) and t.TmpIcons
	if t.TmpIcons then
		Game.IconsLod:BeginTmp()
	end
	t.Pause = (not self.Pause or nil) and t.Pause
	if t.Pause then
		Game.Pause()
	end
	t.Pause2 = (not self.Pause or nil) and t.Pause2
	if t.Pause2 then
		Game.Pause2()
	end
end

local function Apply2(self, t, dlg, new)
	t.Screen = tonumber(t.Screen) or (t.Screen or t.MimicScreen) and 22 or nil
	if t.Screen then
		Game.CurrentScreen = t.Screen
	end
	t.MimicScreen = tonumber(t.MimicScreen) or t.Screen == 22 and self.Screen ~= 22 and (Game.MainMenuCode < 0 and 22 or t.LastScreen ~= 22 and t.LastScreen or t.LastMimicScreen or 12) or nil
	if t.MimicScreen then
		Game.EscMessageLastScreen = t.MimicScreen
	end
	if t.NoFoodGold == nil and self.NoFoodGold == nil and t.Screen == 22 and t.MimicScreen == 22 then
		t.NoFoodGold = true
	end
	if self.BlockOO then
		t.BlockOO = nil
	elseif t.BlockOO == nil and new and is8 then
		t.BlockOO = dlg.Height == 480
	end
	if is8 and t.BlockOO then
		CreatingOO = true
		t.BlockOO = Game.OODialogs:ShowDialog()
		CreatingOO = nil
	end
	t.AutoEsc = (not self.AutoEsc or nil) and t.AutoEsc
	if is8 and t.AutoEsc then
		t.AutoEsc = dlg:AddButton(0, 0, 0, 0, 0, 0, 113, 0, 27)
	end
	t.KeyboardNavigation = (not self.KeyboardNavigation or nil) and (t.KeyboardNavigation or t.KeyboardNavigation == nil and dlg.Width == 640 and dlg.Height == 480)
	if t.KeyboardNavigation then
		dlg:SetKeyboardNavigation(0, 0)
	end
end

local function InitDlg(dlg, new)
	local t = new or {}
	dlg.CustomDialog = t
	t.Dlg = dlg
	t.Items = {}
	t.PcxCache = PcxCache()
	t.PcxCacheD = is8 and PcxCache(true) or t.PcxCache
	setmetatable(t, ClassMeta)
	DlgCount = DlgCount + 1
	if DlgCount == 1 then
		EnableHandlers(handlers, true)
	end
	if not new then
		Apply1(dummy, t)
	end
	Apply2(dummy, t, dlg, new)
	return t
end

function class:Change(t)
	Apply1(self, t)
	Apply2(self, t, self.Dlg)
	table.copy(t, self, true)
end

function CustomDialog(t)
	t = t or {}
	if not t['?ptr'] then
		Defaults(t)
		Apply1(dummy, t)
		local x, y, w, h = t.Left or t[1] or 0, t.Top or t[2] or 0, t.Width or t[3], t.Height or t[4]
		Game.NewDialog(x, y, w or 640 - x, h or 480 - y, t.DlgID or t[5] or IDCusDlg, t.Param or t[6], t.StrParam or t[7], InitDlg, t)
	else
		t = t.CustomDialog or InitDlg(t)
	end
	return t
end

local function RestoreDialog()
	local t = (Game:GetTopDialog() or dummy).CustomDialog
	if not t then
		return
	end
	if t.Screen then
		Game.CurrentScreen = t.Screen
	end
	if t.MimicScreen then
		Game.EscMessageLastScreen = t.MimicScreen
	end
	if Game.PauseCount > 0 and not Game.Paused then
		Game.DoPause()
	end
	if Game.PauseCount2 > 0 and not Game.Paused2 then
		Game.DoPause2()
	end
	FocusedDialog = t
	callback(t.OnActivate, t)
end

local function FindDialogAfter(dlg)
	local high, j = Game.Dialogs.High, nil
	for i = high, 0, -1 do
		local dlg = Game.Dialogs[i]
		if dlg == dlg then
			return i, j, high
		elseif dlg.CustomDialog then
			j = i
		end
	end
end

local function RestoreScreen(t)
	local i, j, high = FindDialogAfter(t.Dlg)
	if j then
		local a = Game.Dialogs[j].CustomDialog
		if j == i + 1 then
			a.LastScreen = t.LastScreen or a.LastScreen
		end
		if j == i + 1 or a.LastMimicScreen == (t.MimicScreen or t.LastMimicScreen) then
			a.MimicScreen = a.MimicScreen or a.LastMimicScreen
			a.LastMimicScreen = t.LastMimicScreen or a.LastMimicScreen
		end
	else
		if i == high or t.Screen == 22 and t.Screen == Game.Screen then
			Game.CurrentScreen = t.LastScreen
		end
		if i == high or t.MimicScreen and t.MimicScreen == Game.EscMessageLastScreen then
			Game.EscMessageLastScreen = t.LastMimicScreen
		end
	end
end

local function DoUnbind(t)
	if not t.Dlg then
		return
	end
	callback(t.OnUnbind, t, not cleanup)
	for _, o in ipairs(t.Items or dummy) do
		if o.Button then
			if cleanup then
				o.Button:Destroy()
			end
			o.Button = nil
			ItemByPointer[mem.topointer(o, true)] = nil
		end
	end
	t.PcxCache"Clear"
	if t.PcxCache ~= t.PcxCacheD then
		t.PcxCacheD"Clear"
	end
	RestoreScreen(t)
	t.Dlg.CustomDialog = nil
	if t.TmpIcons then
		Game.IconsLod:EndTmp()
	end
	if is8 and t.BlockOO then
		Game.OODialogs:CloseSpecific(t.BlockOO)
	end
	t.Dlg = nil
	DlgCount = DlgCount - 1
	if DlgCount == 0 then
		EnableHandlers(handlers, false)
	end
	if t.Pause then
		Game.Resume()
	end
	if t.Pause2 then
		Game.Resume2()
	end
	Game.NeedRedraw = true
end

class.Unbind = |t| DoUnbind(t, true)

function handlers.DestroyDialog(dlg, id)
	local t = dlg.CustomDialog
	if t then
		callback(t.OnDestroy, t)
		DoUnbind(t)
	end
	NeedRestore = DlgCount > 0
end


---- add items ----


local function LoadIcon(t, v, self)
	if not v[1]:match'%.[pP][cC][xX]$' then
		v.Loaded, v.Pcx = Game.IconsLod:LoadBitmap(v[1], t.EnglishD ~= false), nil
	elseif self then
		v.Loaded, v.Pcx = nil, self[t.EnglishD ~= false and "PcxCacheD" or "PcxCache"][v[1]]
	end
end

local function LoadIcons(t, a, self)
	t.Icons = a
	if t.Icon then
		a.Normal = t.Icon
	end
	local best
	for k, v in pairs(a) do
		if type(v) ~= 'table' or v['?ptr'] then
			v = {v}
			a[k] = v
		end
		if type(v[1]) == "number" then
			v.Loaded, v[1] = v[1], nil
		else
			LoadIcon(t, v, self)
		end
		local o = v.Pcx or Game.IconsLod.Bitmaps[v.Loaded]
		v[1] = v[1] or o.Name
		v.Width = o.Width
		v.Height = o.Height
		if v.Rotate and is8 then
			v.Width, v.Height = v.Height, v.Width
		end
		best = best and best < k and best or k
	end
	if t.AutoSize ~= false and not (t.Width and t.Height) then
		for _, k in ipairs{'Size', 'Normal', 'Click', 'Pressed', 'Hover', best} do
			local v = a[k]
			if v then
				local m = v.Margin or dummy
				t.Width = t.Width or v.Width + (tonumber(m.Left) or 0) + (tonumber(m.Right) or 0)
				t.Height = t.Height or v.Height + (tonumber(m.Top) or 0) + (tonumber(m.Bottom) or 0)
				break
			end
		end
	end
end

local ReloadIcons = |t, self| for k, v in pairs(t.Icons) do
	if v[1] then
		LoadIcon(t, v, self)
	end
end

item.ReloadIcons = |t| ReloadIcons(t)

function class:ReloadIcons(AlsoPcx)
	if AlsoPcx then
		self.PcxCache"Reload"
		if self.PcxCache ~= self.PcxCacheD then
			self.PcxCacheD"Reload"
		end
	end
	for _, o in ipairs(self.Items) do
		ReloadIcons(o, self)
	end
end

local function UpdatePos(t, L, R, W, sz)
	local dx = t.CenterPosition and max(0, (t[W] or 0) - 1):div(2)
	if not t[R] then
		t[L] = t[L] and (t[L] - (dx or 0)) or 0
	elseif not t[L] then
		t[L] = sz - t[R] - (dx or t[W] or 0)
	elseif t[W] then
		t[L] = (t[L] + sz - t[R])/2 - (dx or t[W]/2)
	else
		t[W] = sz - t[R] - t[L]
	end
end

local function ButtonArgs(t, pt)
	local x, y, w, h = t.Left, t.Top, t.Width or 0, t.Height or 0
	if t.Shape == 2 then
		w = (w + 1):div(2)
		h = (h + 1):div(2)
		x = x + max(0, w - 1)
		y = y + max(0, h - 1)
	end
	local vis = t.Visible and not t.Disabled
	return x, y, w, h, vis and (t.Shape or 1) or 0, ActHint, ActBtn, pt, vis and t.Key or 0, t.Hint
end

local function CreateButton(self, t)
	local pt = mem.topointer(t, true)
	ItemByPointer[pt] = t
	local p, wrap = self.Dlg:AddButton(ButtonArgs(t, pt))
	t.Button = wrap(p)
	t.Button:MoveAfter(0)
end

function item.UpdateButton(t)
	local a, _ = t.Button, nil
	if a then
		a.Left, a.Top, a.Width, a.Height, a.Shape, _, _, _, a.Key, a.Hint = ButtonArgs(t)
		a.RightPixel = a.Left + a.Width - 1
		a.BottomPixel = a.Top + a.Height - 1
	end
end

local function InitItem(self, t)
	t.Parent = self
	t.Visible = t.Visible ~= false
	t.Left, t.Top, t.Width, t.Height = t.Left or t[1], t.Top or t[2], t.Width or t[3], t.Height or t[4]
	t[1], t[2], t[3], t[4] = nil
	if t.Radius then
		t.Shape = 2
		t.Width = max(0, t.Radius*2 - 1)
		t.Height = max(0, (t.RadiusY or t.Radius)*2 - 1)
		t.CenterPosition = t.CenterPosition ~= false
	end
	if t.Name then
		local loc = self.Localize or dummy
		t.Text = loc["Text_"..t.Name] or t.Text
		t.Hint = loc["Hint_"..t.Name] or t.Hint
		t.Texts = loc["Texts_"..t.Name] or t.Texts
	end
	LoadIcons(t, t.Icons or {}, self)
	UpdatePos(t, 'Left', 'Right', 'Width', self.Dlg.Width)
	UpdatePos(t, 'Top', 'Bottom', 'Height', self.Dlg.Height)
	if t.Width and t.Height and t.Button == nil then
		t.Button = t.Action or t.HintAction or t.Hint or t.OnTriggerClick or t.OnClick or t.OnHint or t.OnDown or t.OnUp or t.Sound
	end
	if t.Button then
		CreateButton(self, t)
	end
	if t.TriggerOnUp == nil then
		t.TriggerOnUp = not not t.Icons.Down
	end
	if t.DelayClick == nil then
		t.DelayClick = t.Icons.Click ~= nil
	end
	if t.DelayKeyClick == nil then
		t.DelayKeyClick = t.DelayClick or t.Icons.Down ~= nil
	end
	setmetatable(t, ItemMeta)
end

function class:Add(t, ...)
	if not t then
		return
	elseif type(t[1]) == "table" then
		return self:Add(unpack(t))
	else
		local a = self.Items
		a[#a+1] = t
		if t.Name ~= nil then
			self.Items[t.Name] = t
		end
		InitItem(self, t)
	end
	return t, self:Add(...)
end

function class:MoveItem(t, idx)
	local k = table.ifind(self.Items, t)
	if not k or k == idx then
		return
	elseif k < idx then
		idx = idx - 1
	elseif idx < 1 then
		idx = 1
	end
	table.remove(self.Items, k)
	idx = min(idx, #self.Items + 1)
	table.insert(self.Items, idx, t)
	local btn, upper = t.Button, nil
	if btn then
		for i = idx + 1, #self.Items, 1 do
			upper = self.Items[i].Button
			if upper then
				break
			end
		end
		btn:MoveAfter(upper)
	end
end

function class:RemoveItem(t)
	local k = table.ifind(self.Items, t)
	if not k then
		return
	end
	table.remove(self.Items, k)
	if t.Name ~= nil then
		self.Items[t.Name] = nil
	end
	if t.Button then
		if self.AutoEsc == t.Button then
			self.AutoEsc = nil
		end
		t.Button:Destroy()
		t.Button = nil
		ItemByPointer[mem.topointer(t, true)] = nil
	end
end


---- item ----


local function GetByStateMain(t, a)
	return t.Disabled and (a[t.StateDisabled] or a.Disabled) or not t.Disabled and (
		ClickedItems[t] and (a[t.StateClick] or a.Click) or
		(t == HoverItem and t == DownItem or (ClickedItems[t] or dummy).KeyPress) and (a[t.StateDown] or a.Down) or
		t == HoverItem and (a[t.StateHover] or a.Hover)
	)
end

local function GetByState(t, a, NoCallback)
	local main = GetByStateMain(t, a)
	return not NoCallback and callback(t.OnStateQuerry, a, main) or main or a[t.State] or a.Normal
end

local States = setmetatable({}, {__index = |t, k| k})

function item.GetState(t, q, NoCallback)
	return GetByState(t, q or States, NoCallback)
end


-- clicks --


local DefSound = |v| v == true and (is8 and 76 or 75) or v

function class:HandleAction(t, index)
	if self.PassThrough then
		return
	end
	local more = {Consume = index ~= 0 and t.Action == 113, PassThrough = false}
	callback(self.OnAction, t, more)
	if t.Action == 113 and not more.PassThrough and index ~= 0 then
		callback(self.OnCanClose, t, more)
		if not self.NoClose then
			if self.CloseSound then
				Game.PlaySound(DefSound(self.CloseSound), 0)
			end
			self.Dlg:Destroy()
		end
	end
	if not more.PassThrough then
		if more.Consume then
			t.Action = 0
		end
		return true
	end
end

local function DoOnClick(o, t)
	callback(o.OnClick, o, t)
	if (t.Action or 0) ~= 0 then
		Game.Actions.Add(t.Action, t.Param, t.Param2)
	end
end

local function HandleClick(o, key, dbl)
	if ClickedItems[1] or ClickedItems[o] then
		return
	end
	local t = {Action = o.Action or 0, Param = o.ActionParam or 0, Param2 = o.ActionParam2 or 0, KeyPress = key, DoubleClick = dbl, DelayClick = o[key and 'DelayKeyClick' or 'DelayClick'], Sound = o.Sound}
	callback(o.OnTriggerClick, o, t)
	if t.Cancel then
		return
	elseif t.Sound then
		Game.PlaySound(DefSound(t.Sound), 0)
	end
	t.Sound = nil
	ClickedItems[o] = t
	if t.DelayClick then
		ClickedItems[#ClickedItems + 1] = o
	else
		DoOnClick(o, t)
	end
end

function handlers.Action(t)
	local act = t.Action
	if act == ActBtn then
		t.Action = 0
		local o = ItemByPointer[t.Param]
		if not o then
			return
		end
		local key = not (GotDown or GotDbl)
		if not key then
			DownItem = o
			callback(o.OnMouseDown, o)
		end
		if key or not o.TriggerOnUp then
			HandleClick(o, key, not (key or GotDown))
		end
		act = t.Action
	elseif act == ActHint then
		t.Action = 0
		local o = ItemByPointer[t.Param]
		if not o then
			return
		end
		HoverItem, HoverFrame = o, Game.FrameCounter
		local hact = o.HintAction
		local q = {
			Action = hact or 0,
			Param = hact and (o.HintActionParam or o.ActionParam) or 0,
			Param2 = hact and (o.HintActionParam2 or o.ActionParam2) or 0
		}
		callback(o.OnHint, o, q)
		if o.Hint and (o.Parent or dummy).Dlg == Game.Dialogs[0] then
			Game.ShowStatusHint(o.Hint)
		end
		if (q.Action or 0) ~= 0 then
			Game.Actions.Add(q.Action, q.Param, q.Param2)
		end
	elseif act == ActUp then
		local o = DownItem
		t.Action, DownItem = 0, nil
		callback(o.OnMouseUp, o, t, o == HoverItem)
		if o == HoverItem and o.TriggerOnUp then
			HandleClick(o, false, false)
		end
	elseif act ~= 0 then
		local dialogs = Game.Dialogs
		for i = dialogs.High, 0, -1 do
			local dlg = dialogs[i]
			dlg = dlg.CustomDialog
			if not dlg or dlg:HandleAction(t, i) then
				break
			end
		end
	end
end

handlers.MenuAction = handlers.Action

function handlers.WindowMessage(t)
	local msg = t.Msg
	if msg >= 0x0200 and msg <= 0x0203 then
		if msg == 0x0200 then
			GotMove = true
		elseif msg == 0x0201 then
			GotDown = true
		elseif msg == 0x0203 then
			GotDbl = true
		elseif DownItem then
			Game.Actions.Add(ActUp, mem.topointer(DownItem, true), 0)
		end
	end
end

local CheckParent = |self, t| t and t.Parent == self and t, t

class.GetHoveredItem = |t| CheckParent(t, HoverItem)
class.GetMouseDownItem = |t| CheckParent(t, DownItem)
-- class.GetFocusedItem = |t| CheckParent(t, FocusedItem)


---- draw ----


local function UseMargin(self, t, m, w, L, R, W)
	local ml = tonumber(m[L])
	local mr = tonumber(m[R])
	local bl = m[L] == true
	local br = m[R] == true
	local x = (t[L] or 0)
	local r = x + (t[W] or self[W] - x) - (mr or 0)
	x = x + (ml or 0)
	if not w then
		return x, r
	elseif ml and mr or bl and br then
		return (x + r - w):div(2), w
	elseif mr or bl then
		return r - w, w
	else
		return x, w
	end
end

local function UseMargins(self, t, m, w, h)
	local x, w = UseMargin(self, t, m, w, 'Left', 'Right', 'Width')
	local y, h = UseMargin(self, t, m, h, 'Top', 'Bottom', 'Height')
	return x, y, w, h
end

function class:DrawItem(t)
	if not t.Visible then
		return
	end
	callback(t.OnBeforeDraw, t)
	if t.NoDraw then
		return
	end
	if t.BoxBorder and t.Width and t.Height then
		local x, y, w, h = UseMargins(self, t, t.BoxMargin or dummy, t.Width, t.Height)
		Screen:DrawMessageBoxBorder(x - self.Dlg.Left, y - self.Dlg.Top, w, h)
	end
	local pic = not t.NoIcon and GetByState(t, t.Icons)
	if pic then
		local x, y = UseMargins(self, t, pic.Margin or dummy, pic.Width, pic.Height)
		local style = pic.DrawStyle
		if style == nil then
			style = t.DrawStyle
		end
		if pic.Loaded then
			Screen:Draw(x, y, pic.Loaded, style, pic.Rotate)
		else
			Screen:DrawPcx(x, y, pic.Pcx)
		end
	end
	if (t.Text or "") ~= "" and not t.NoText then
		local fnt = t.Font or self.Font or Game.FontArrus
		local cl = GetByState(t, t.Colors or dummy) or t.Color
		local clSh = GetByState(t, t.ShadowColors or dummy) or t.ShadowColor
		-- only the most basic option for now:
		local x, y = UseMargins(self, t, t.TextMargin or dummy, t.Width, t.Height)
		fnt:Draw(t.Text, self.Dlg, x, y, cl, clSh)
	end
	callback(t.OnDraw, t)
end

function class:Draw()
	callback(self.OnBeforeDraw, self)
	if self.NoDraw or not self.Dlg then
		return
	end
	if is7 and self.NoFoodGold ~= nil then
		NoFoodGold = self.NoFoodGold
	end
	for _, t in ipairs(self.Items) do
		self:DrawItem(t)
	end
	callback(self.OnDraw, self)
end

local function UpdateHover()
	if Game.MainMenuCode >= 0 then
		HoverItem = nil
		local btn, dlg = Game.GetButtonFromPoint(Mouse.X, Mouse.Y)
		if btn and dlg.CustomDialog then
			HoverItem = ItemByPointer[btn.ActionParam]
		end
	elseif HoverItem then
		HoverItem = HoverFrame == Game.FrameCounter and HoverItem
	end
end

local function FindBlock(i)
	local p, p2 = Game.DialogIndexes['?ptr'], Game.DialogsArray['?ptr'] + structs.o.Dlg.DlgID - 0x54
	for i = i + 1, Game.Dialogs.High do
		if i4[p2 + i4[p + i*4]*0x54] == IDBlock then
			return i
		end
	end
end

function handlers.DrawDialog(t)
	local o = (t.Dialog or dummy).CustomDialog
	if o and (BlockCount == 0 or not FindBlock(t.Index)) then
		o:Draw()
	end
end

local function before()
	UpdateHover()
	NeedRestore = NeedRestore and RestoreDialog()
	local o = BlockCount == 0 and Game.Dialogs[0].CustomDialog
	if o and Game.MainMenuCode < 0 then
		o:Draw()
	end
end

local function after()
	if NoFoodGold ~= nil then
		Game.FoodGoldVisible, NoFoodGold = Game.MainMenuCode >= 0 or Game.ExitLevelCode == 9 or not NoFoodGold, nil
	end
	GotDown, GotDbl, GotMove = nil
	if not next(ClickedItems) or ClickTime and timeGetTime() >= ClickTime or Game.MainMenuCode < 0 then
		for i, o in ipairs(ClickedItems) do
			DoOnClick(o, ClickedItems[o])
		end
		ClickedItems, ClickTime = next(ClickedItems) and {} or ClickedItems, nil
	elseif not ClickTime then
		ClickTime = timeGetTime() + 32
	end
end

handlers.BeforeDrawDialogs = before
handlers.AfterDrawDialogs = after

function handlers.AfterDrawNoDialogs()
	before()
	after()
end


-- block dialogs below an OO dialog --


handlers.InternalAfterShowOODialog = is8 and |t| if not CreatingOO then
	local id, class = IDBlockInteraction, t.ClassPtr
	if class ~= 0x4EA0E0 then  -- not SelectTarget
		id, BlockCount = IDBlock, BlockCount + 1
	end
	for _, a in Game.Actions do
		if a.Action == ActBtn or a.Action == ActHint then
			a.Action = 0
		end
	end
	Game.NewDialog(0, 0, 640, 480, id, t.DialogPtr)
end

handlers.CloseOODialog = is8 and function(t)
	for _, a in Game.Dialogs do
		local id = a.DlgID
		if (id == IDBlock or id == IDBlockInteraction) and a.Param == t.DialogPtr then
			if id == IDBlock then
				BlockCount = BlockCount - 1
			end
			a:Destroy()
		end
	end
end
