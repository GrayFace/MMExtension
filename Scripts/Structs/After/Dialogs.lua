local abs, floor, ceil, round, max, min = math.abs, math.floor, math.ceil, math.round, math.max, math.min
local i4, i2, i1, u4, u2, u1, r4, pchar, call = mem.i4, mem.i2, mem.i1, mem.u4, mem.u2, mem.u1, mem.r4, mem.pchar, mem.call
local mmver = offsets.MMVersion
local is6 = mmver == 6 or nil
local is7 = mmver == 7 or nil
local is8 = mmver == 8 or nil
local is78 = mmver > 6 or nil

-- TODO: focus

local class, item, dummy, handlers = {}, {}, {}, {}
local ClassMeta, ItemMeta = {__index = class}, {__index = item}
local ActBtn, ActHint, ActUp = const.Actions.CustomDialogButton, const.Actions.CustomDialogHint, const.Actions.CustomDialogMouseUp
local DlgCount = 0
local ItemByPointer = setmetatable({}, {__mode = 'v'})
local GotDown, GotDbl, GotMove
local HoverItem, HoverFrame
local DownItem
local LastMousePos
local SelHover = false
-- local FocusedDialog
local InputItem, InputCaptureEsc
local ClickedItems, ClickTime = {}, nil
local IDCusDlg, IDBlockInteraction, IDBlock, BlockCount, CreatingOO = const.DlgID.CustomDialog, const.DlgID.BlockDialogs, const.DlgID.BlockDialogsNoDraw, 0, nil
local NoFoodGold, NeedRestore
local tmMultiLine = {box = true, center = true}


---- callbacks ----


local function EnableHandlers(on)
	for k, v in pairs(handlers) do
		events[on and 'add' or 'remove'](k, v)
	end
end

local function callback(name, o, ...)
	local f = o[name]
	if f then
		return f(o, ...)
	end
	local a = o.callbacks
	if a then
		a.cocalls(name, o, ...)
	end
end

function class:callback(name, f, first)
	self.callbacks = self.callbacks or events.new()
	self.callbacks[first and 'AddFirst' or 'add'](name, f)
end
item.callback = class.callback

function class:event(name, f, first)
	local a = tget(self, 'DeleteEvents')
	local i = #a + 1
	a[i] = f
	a[-i] = name
	events[first and 'AddFirst' or 'add'](name, f)
end


---- create/destroy dialog ----


local function Defaults(t)
	t.TmpIcons = t.TmpIcons ~= false
	t.Pause = t.Pause ~= false
	t.AutoEsc = is8 and t.AutoEsc == nil and t.Screen ~= 13 or t.AutoEsc
	t.Screen = t.Screen or t.Screen ~= false
	t.LastScreen = Game.CurrentScreen
	t.LastMimicScreen = Game.EscMessageLastScreen
	t.HandleEsc = t.HandleEsc ~= false
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
		t.BlockOO = dlg.Height == 480 and dlg.Width == 640
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
	t.PassThrough = new and t.PassThrough == nil and (dlg.Height ~= 480 or dlg.Width ~= 640) or t.PassThrough
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
		LastMousePos = nil
		EnableHandlers(true)
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
	-- FocusedDialog = t
	callback('OnActivate', t)
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

local function CleanupSpecialItems()
	HoverItem = ItemByPointer[mem.topointer(HoverItem, true)]
	DownItem = ItemByPointer[mem.topointer(DownItem, true)]
	if InputItem and not ItemByPointer[mem.topointer(InputItem, true)] then
		InputItem, InputCaptureEsc = nil
		Game.EndTextInput(3)
	end
	for i, a in ipairs(ClickedItems) do
		ClickedItems[i] = ItemByPointer[mem.topointer(ClickedItems[i], true)]
	end
end

local function DoUnbind(t, cleanup)
	if not t.Dlg then
		return
	end
	callback('OnUnbind', t, not cleanup)
	for _, o in ipairs(t.Items or dummy) do
		if o.Button then
			if cleanup then
				o.Button:Destroy()
			end
			o.Button = nil
			ItemByPointer[mem.topointer(o, true)] = nil
		end
	end
	if cleanup and is8 and t.AutoEsc then
		t.AutoEsc:Destroy()
		t.AutoEsc = nil
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
	for i, f in ipairs(t.DeleteEvents or dummy) do
		events.remove(t.DeleteEvents[-i], f)
	end
	CleanupSpecialItems()
	t.Dlg = nil
	DlgCount = DlgCount - 1
	if DlgCount == 0 then
		EnableHandlers(false)
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
		callback('OnDestroy', t)
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

local function FindButton(items, start, stop, step)
	for i = start or #items, stop or #items, step do
		local b = items[i].Button
		if b then
			return b
		end
	end
end

local function CreateButton(self, t)
	local pt = mem.topointer(t, true)
	ItemByPointer[pt] = t
	local p, wrap = self.Dlg:AddButton(ButtonArgs(t, pt))
	t.Button = wrap(p)
	local b2 = FindButton(self.Items, nil, 1, -1)
	if b2 then
		t.Button:MoveBefore(b2)
	elseif self.Dlg ~= Game.CurrentNPCDialog then  -- it relies on keyboard items starting with 2/1
		t.Button:MoveAfter(0)
	end
end

function item.UpdateButton(t)
	local a, _ = t.Button, nil
	if a then
		a.Left, a.Top, a.Width, a.Height, a.Shape, _, _, _, a.Key, a.Hint = ButtonArgs(t)
		a.RightPixel = a.Left + a.Width - 1
		a.BottomPixel = a.Top + a.Height - 1
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

local function UseMargin(self, t, m, w, vert)
	local L, R, W = 'Left', 'Right', 'Width'
	if vert then
		L, R, W = 'Top', 'Bottom', 'Height'
	end
	local ml = tonumber(m[L])
	local mr = tonumber(m[R])
	local bl = m[L] == true
	local br = m[R] == true
	local x = (t[L] or 0)
	local r = x + (t[W] or self[W] - x) - (mr or 0)
	x = x + (ml or 0)
	if not w then
		return x, r - x
	elseif ml and mr or bl and br then
		return (x + r - w):div(2), w
	elseif mr or bl then
		return r - w, w
	else
		return x, w
	end
end

local function UseMargins(self, t, m, w, h)
	local x, w = UseMargin(self, t, m, w)
	local y, h = UseMargin(self, t, m, h, true)
	return x, y, w, h
end

local GetFont = |self, t| t.Font or self.Font or Game.FontArrus

local function GetTextWidth(self, t)
	local fnt = GetFont(self, t)
	local text = (t == InputItem and Game.TextInput or t.Text)
	local w0, maxW = fnt:GetLineWidth(text), self.Dlg.Width
	local w = w0
	if tmMultiLine[t.TextMode] then  -- accomodate for a bug in WordWrap
		while w < maxW and fnt:GetLineWidth(fnt:WordWrap(text, {0, 0, w, 480}, 0, false, true)) < w0 do
			w = w + 1
		end
	end
	return w
end

local function GetTextHeight(self, t, w)
	local m, dlg = t.TextMargin or dummy, self.Dlg
	local x, w = UseMargin(self, t, m, w or m.Left == true and GetTextWidth(self, t))
	if tmMultiLine[t.TextMode] then
		x, dlg = 0, {0, 0, w, 480}
	end
	return GetFont(self, t):GetTextHeight(t.Text, dlg, x) + 1
end

item.GetTextWidth = |t| GetTextWidth(t.Parent, t)
item.GetTextHeight = |t, NoExtra| GetTextHeight(t.Parent, t) - (NoExtra and 1 or 0)

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
	if t.Text and not (t.Width or t.Left and t.Right) then
		local m = t.TextMargin or dummy
		t.Width = GetTextWidth(self, t) + (tonumber(m.Left) or 0) + (tonumber(m.Right) or 0)
	end
	UpdatePos(t, 'Left', 'Right', 'Width', self.Dlg.Width)
	if t.Text and not (t.Height or t.Top and t.Bottom) then
		local m = t.TextMargin or dummy
		t.Height = GetTextHeight(self, t) + (tonumber(m.Top) or 0) + (tonumber(m.Bottom) or 0)
	end
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
	if t.Focus == nil then
		t.Focus = t.FocusOnClick ~= nil or t.FocusOnHover ~= nil
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
	if idx < 0 then
		idx = #self.Items + 1 + idx
	end
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
	if t.Button then
		local b2 = FindButton(self.Items, idx + 1, nil, 1)
		if b2 then
			t.Button:MoveAfter(b2)
		else
			b2 = FindButton(self.Items, idx - 1, 1, -1)
			if b2 then
				t.Button:MoveBefore(b2)
			end
		end
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
		CleanupSpecialItems()
	end
	if self.FocusedItem == t then
		self.FocusedItem = nil
	end
end


---- item ----


local function GetByStateMain(t, a)
	if t.Disabled then
		return a[t.StateDisabled] or a.Disabled
	end
	return ClickedItems[t] and (a[t.StateClick] or a.Click)
		or t == InputItem and (a[t.StateInput] or a.Input)
		or (t == HoverItem and t == DownItem or (ClickedItems[t] or dummy).KeyPress) and (a[t.StateDown] or a.Down)
		or (t == HoverItem and t.Focus and (SelHover or t == t.Parent.FocusedItem)) and (a[t.StateSelected] or a.Selected)
		or t == HoverItem and (a[t.StateHover] or a.Hover)
		or t.Focus and t == t.Parent.FocusedItem and (-- t == t:GetFocusedItem() and (
			not SelHover and (a[t.StateSelected] or a.Selected)
			or a[t.StateFocused] or a.Focused
		)
end

local function GetByState(t, a, NoCallback)
	if not a then
		return
	end
	local main = GetByStateMain(t, a)
	return not NoCallback and callback('OnQuerryState', t, a, main) or main or a[t.State] or a.Normal
end

local States = setmetatable({}, {__index = |t, k| k})

function item.GetState(t, NoCallback)
	return GetByState(t, States, NoCallback)
end

item.QuerryState = GetByState


-- clicks --


local DefSound = |v| v == true and (is8 and 76 or 75) or v

function class:HandleAction(t)
	if self.PassThrough then
		return
	end
	local more = {Handle = t.Action == 113 and self.HandleEsc, PassThrough = t.PassThrough}
	more.Consume = more.Handle
	callback('OnAction', self, t, more)
	if t.Action == 113 and more.Handle then
		callback('OnCanClose', self, t, more)
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

local function InputCancelled()
	local t = InputItem
	if t then
		InputItem, InputCaptureEsc = nil
		callback('OnCancelInput', t.Parent, t)
	end
end

local function CancelInput()
	if Game.TextInputMode ~= 0 then
		Game.EndTextInput(3)
	end
	InputCancelled()
end

local function InputAccepted()
	local t, q = InputItem, {Text = Game.TextInput}
	q.ItemText = q.Text
	InputItem, InputCaptureEsc = nil
	callback('OnAcceptInput', t.Parent, t, q)
	t.Text = q.ItemText or t.Text
end

local function DoOnClick(o, t)
	callback('OnClick', o, t)
	if (t.Action or 0) ~= 0 then
		Game.Actions.Add(t.Action, t.Param, t.Param2)
	end
end

function class:SetFocusedItem(t)
	local cur = self.FocusedItem
	if t ~= cur then
		self.FocusedItem = t
		callback('OnFocusItem', self, t, cur)
	end
end

local function HandleClick(o, key, dbl, foc)
	if ClickedItems[1] or ClickedItems[o] then
		return
	end
	local t = {Action = o.Action or 0, Param = o.ActionParam or 0, Param2 = o.ActionParam2 or 0, KeyPress = key, DoubleClick = dbl, ByFocusControl = foc, DelayClick = o[key and 'DelayKeyClick' or 'DelayClick'], Sound = o.Sound, FocusOnClick = o.FocusOnClick, Focused = o == o.Parent.FocusedItem}
	callback('OnTriggerClick', o, t)
	if t.Cancel then
		return
	elseif t.Sound then
		Game.PlaySound(DefSound(t.Sound), 0)
	end
	if t.FocusOnClick then
		o.Parent:SetFocusedItem(o)
	end
	t.Sound = nil
	ClickedItems[o] = t
	if t.DelayClick then
		ClickedItems[#ClickedItems + 1] = o
	else
		DoOnClick(o, t)
	end
end

item.Click = |o, key| HandleClick(o, key == nil or key, false, false)

local function HandleHover(o, menu)
	local hact = o.HintAction
	if o.Focus and GotMove then
		SelHover = true
	end
	local q = {
		Action = hact or 0,
		Param = hact and (o.HintActionParam or o.ActionParam) or 0,
		Param2 = hact and (o.HintActionParam2 or o.ActionParam2) or 0,
		FocusOnHover = o.FocusOnHover and SelHover,
	}
	callback('OnHint', o, q)
	if o.Hint and not menu and (o.Parent or dummy).Dlg == Game.Dialogs[0] then
		Game.ShowStatusHint(o.Hint)
	end
	if q.FocusOnHover then
		o.Parent:SetFocusedItem(o)
	end
	if (q.Action or 0) ~= 0 then
		Game.Actions.Add(q.Action, q.Param, q.Param2)
	end
end

function handlers.Action(t)
	local act = t.Action
	if act == ActBtn then
		local o = ItemByPointer[t.Param]
		if not o then
			return
		end
		local key = not (GotDown or GotDbl)
		if not key then
			DownItem = o
			callback('OnMouseDown', o)
		end
		if key or not o.TriggerOnUp then
			HandleClick(o, key, not (key or GotDown))
		end
	elseif act == ActHint then
		local o = ItemByPointer[t.Param]
		if not o then
			return
		end
		HoverItem, HoverFrame = o, Game.FrameCounter
		HandleHover(o)
	elseif act == ActUp then
		local o = DownItem
		DownItem = nil
		callback('OnMouseUp', o, o == HoverItem)
		if o == HoverItem and o.TriggerOnUp then
			HandleClick(o, false, false)
		end
	elseif act ~= 0 then
		if InputCaptureEsc and act == 113 then
			t.Action = 0
			return CancelInput()
		end
		local dialogs = Game.Dialogs
		for i = dialogs.High, 0, -1 do
			local dlg = dialogs[i]
			dlg = dlg.CustomDialog
			if not dlg or dlg:HandleAction(t) then
				break
			end
		end
	end
end

handlers.MenuAction = handlers.Action

function handlers.WindowMessage(t)
	local msg = t.Msg
	if msg >= 0x0200 and msg <= 0x0209 then  -- mouse move and clicks
		local pos = t.LParam
		if msg ~= 0x0200 or pos ~= LastMousePos then  -- 0x0200 = mouse move
			GotMove = true
		end
		LastMousePos = pos
		if msg == 0x0201 then
			GotDown = true
		elseif msg == 0x0203 then
			GotDbl = true
		elseif msg == 0x0202 and DownItem then
			Game.Actions.Add(ActUp, mem.topointer(DownItem, true), 0)
		end
	end
end

local CheckParent = |self, t| t and t.Parent == self and t, t

class.GetHoveredItem = |t| CheckParent(t, HoverItem)
class.GetMouseDownItem = |t| CheckParent(t, DownItem)
class.GetInputItem = |t| CheckParent(t, InputItem)
-- class.GetFocusedItem = |t| CheckParent((FocusedDialog or dummy).FocusedItem)


---- draw ----


local function TileDraw(pic, style, x, y, w, h)
	local dw, dh = max(1, pic.Width or 0), max(1, pic.Height or 0)
	for y = y, y + h - 1, dh do
		for x = x, x + w - 1, dw do
			if pic.Loaded then
				Screen:Draw(x, y, pic.Loaded, style, pic.Rotate)
			elseif pic.Pcx then
				Screen:DrawPcx(x, y, pic.Pcx)
			end
		end
	end
end

local function UseClipRect(m, dlg)
	if not m then
		return Screen:SetClipRect()
	end
	local L, R = dlg.Left + (tonumber(m.Left) or 0), dlg.RightPixel + 1 - (tonumber(m.Right) or 0)
	local T, B = dlg.Top + (tonumber(m.Top) or 0), dlg.BottomPixel + 1 - (tonumber(m.Bottom) or 0)
	Screen:SetClipRect(max(L, 0), max(T, 0), min(R, 640), min(B, 480))
end

local function TrimInput(fnt, w)
	local n
	while fnt:GetLineWidth(Game.TextInputBytes) > w do
		n = (n or Game.TextInputLength) - 1
		if n < 0 then
			n = 0
			break
		end
		Game.TextInputBytes[n] = 0
	end
	Game.TextInputLength = n
end

function class:DoDrawItem(t)
	if t.BoxBorder and t.Width and t.Height then
		local x, y, w, h = UseMargins(self, t, t.BoxMargin or dummy, t.Width, t.Height)
		Screen:DrawMessageBoxBorder(x - self.Dlg.Left, y - self.Dlg.Top, w, h)
	end
	local pic = not t.NoIcon and GetByState(t, t.Icons)
	if pic then
		local tile = (pic.Tile == nil and t.Tile or pic.Tile) and (pic.Width or 0) > 0 and (pic.Height or 0) > 0
		local x, y, w, h = UseMargins(self, t, pic.Margin or dummy, not tile and pic.Width, not tile and pic.Height)
		local style = pic.DrawStyle
		if style == nil then
			style = t.DrawStyle
		end
		TileDraw(pic, style, x, y, tile and w or 1, tile and h or 1)
	end
	if (t == InputItem or (t.Text or "") ~= "") and not t.NoText then
		local m = t.TextMargin or dummy
		local mode, mode2 = t.TextMode, t.TextVMode
		local tw = m.Left == true and GetTextWidth(self, t)
		local th = (m.Top == true or mode2 == "center") and GetTextHeight(self, t, tw)
		local x, y, w, h = UseMargins(self, t, t.TextMargin or dummy, tw, th)
		if mode2 == "center" then
			y, h = y + (h - th):div(2), th
		end
		local aw, ah = w, h
		local wlim = self.Dlg.Width - x
		if not mode then
			aw = wlim
		end
		if mode2 == "limit" then
			ah = self.Dlg.Height - y
		end
		
		local offset = GetByState(t, t.Offsets) or dummy
		x = x + (offset[1] or 0) + self.Dlg.Left
		y = y + (offset[2] or 0) + self.Dlg.Top
		
		local fnt = GetFont(self, t)
		local cl = GetByState(t, t.Colors) or t.Color
		local clSh = GetByState(t, t.ShadowColors) or t.ShadowColor
		if t == InputItem and mode == "limit" then
			TrimInput(fnt, aw)
		end
		local text = t == InputItem and Game.TextInput or t.Text
		local cursor = t == InputItem and timeGetTime()%1000 > 500 and (t.Cursor or self.Cursor or '_')
		local clCur = (t.Colors or dummy).Cursor
		local clCurSh = (t.ShadowColors or dummy).Cursor
		if cursor and (not mode or mode == "box" or mode == "limit") then
			local pos = (tw or GetTextWidth(self, t)) + (t.CursorIndent or self.CursorIndent or 0)
			pos = min(pos, wlim - fnt:GetLineWidth(cursor))
			fnt:Draw(cursor, {x - 1, y, wlim + 1, ah}, pos + 1, 0, clCur or cl, clCurSh or clSh)
		end
		if not mode or mode == "box" then
			fnt:Draw(text, {x - 1, y, min(aw + 2, wlim + 1), ah}, 1, 0, cl, clSh, (mode2 == "box" or mode2 == "limit") and y + ah)
		elseif mode == "limit" then
			fnt:DrawLimited(text, {x - 1, y, min(aw + 2, wlim + 1), ah}, aw + 1, 1, 0, cl)
		elseif mode == "center" then
			if cursor then
				text = text..'\t'..(clCur and StrColor(clCur) or '')..cursor
			end
			-- TODO: support V limit?
			fnt:DrawCentered(text, {x, y, aw, ah}, 0, 0, cl, clSh)
		end
	end
end

function class:DrawItem(t)
	if not t.Visible then
		return
	end
	callback('OnBeforeDraw', t)
	if t.NoDraw then
		return
	end
	local clip = t.ClipMargin
	if clip then
		UseClipRect(clip, self.Dlg)
	end
	self:DoDrawItem(t)
	callback('OnDraw', t)
	if clip then
		UseClipRect(self.ClipMargin, self.Dlg)
	end
end

function class:Draw()
	callback('OnBeforeDraw', self)
	if self.NoDraw or not self.Dlg then
		return
	end
	if is7 and self.NoFoodGold ~= nil then
		NoFoodGold = self.NoFoodGold
	end
	local clip = self.ClipMargin
	if clip then
		UseClipRect(clip, self.Dlg)
	end
	for _, t in ipairs(self.Items) do
		self:DrawItem(t)
	end
	callback('OnDraw', self)
	UseClipRect()
end

local function UpdateHover()
	if Game.MainMenuCode >= 0 then
		HoverItem = nil
		local btn, dlg = Game.GetButtonFromPoint(Mouse.X, Mouse.Y)
		if btn and dlg.CustomDialog then
			HoverItem = ItemByPointer[btn.ActionParam]
			if HoverItem then
				HandleHover(HoverItem, true)
			end
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
	if InputItem then
		local state = InputItem.Parent.Dlg.TextInputState
		if state == 2 then
			InputAccepted()
		elseif state ~= 1 then
			InputCancelled()
		end
	end
	local o = BlockCount == 0 and Game.Dialogs[0].CustomDialog
	if o and Game.MainMenuCode < 0 then
		o:Draw()
	end
end

local function after()
	if not next(ClickedItems) or ClickTime and timeGetTime() >= ClickTime or Game.MainMenuCode < 0 then
		for i, o in ipairs(ClickedItems) do
			DoOnClick(o, ClickedItems[o])
		end
		ClickedItems, ClickTime = next(ClickedItems) and {} or ClickedItems, nil
	elseif not ClickTime then
		ClickTime = timeGetTime() + 32
	end
	if NoFoodGold ~= nil and Game.MainMenuCode < 0 and Game.ExitLevelCode ~= 9 then
		Game.FoodGoldVisible = not NoFoodGold
	end
	NoFoodGold, GotDown, GotDbl, GotMove = nil
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


-- focus control --


local function FindClosestHigher(items, array, get, cur, fromIt)
	local v0 = fromIt and cur and cur.Focus and get(items, cur, cur) or -1/0
	local t, vbest = nil, 1/0
	for i, a in ipairs(array or items) do
		local v = a.Focus and a.Visible and not a.Disabled and get(items, a, cur, not array and i) or v0
		if v > v0 and v <= vbest then
			if v < vbest then
				t, vbest = {}, v
			end
			t[#t + 1] = a
		end
	end
	return t
end

local Inverter = |get| function(...)
	local v = get(...)
	return v and -v
end
local GetFocusIndex = |items, a, cur, i| tonumber(a.Focus) or i or table.ifind(items, a)
local GetFocusSameColumn = |items, a, cur, i| (not cur or (a.Column or 0) == (cur.Column or 0)) and GetFocusIndex(items, a, cur, i)
local GetColumnIndex = |items, a| a.Column or 0
local GetCenterDist = |items, a, cur, i| a ~= cur and (not cur and 0 or abs(a.Top + (a.Height or 0)/2 - cur.Top - (cur.Height or 0)/2))
local GetDistOutside = |items, a, cur, i| if a ~= cur then
	if not cur then
		return 0
	end
	local c = cur.Top + (cur.Height or 0)/2
	return max(0, max(a.Top - c, c - a.Top - (a.Height or 0)))
end

local AddFocusKey = |self, name, key, filter, wrap| self:Add{Name = name, Key = key, Button = true, OnClick = function()
	SelHover = false
	local cur = self.FocusedItem
	local t = nil
	for _, f in ipairs{filter, GetDistOutside, GetCenterDist} do
		t = FindClosestHigher(self.Items, t, f, cur, true) or wrap and FindClosestHigher(self.Items, t, f, cur)
		if not t or not t[2] then
			break
		end
	end
	if t and t[1] then
		self:SetFocusedItem(t[1])
	end
end}

function class:AddFocusControl(enter, columns, wrap, wrap_c, wrap_to_c)
	if columns == nil then
		for _, a in ipairs(self.Items) do
			if a.Focus and a.Column then
				columns = true
				break
			end
		end
	end
	wrap = wrap ~= false
	wrap_to_c = wrap_to_c ~= false
	wrap_c = wrap_c == nil and wrap or wrap_c
	enter = enter ~= false and self:Add{Name = '_FocusControl_Enter', Key = const.Keys.RETURN, Button = true, OnClick = function()
		SelHover = false
		local o = self.FocusedItem
		if o and o.Visible and not o.Disabled then
			HandleClick(o, true, false, true)
		end
	end} or nil
	local fdown = wrap_to_c and GetFocusIndex or GetFocusSameColumn
	local up = AddFocusKey(self, '_FocusControl_Up', const.Keys.UP, Inverter(fdown), wrap)
	local down = AddFocusKey(self, '_FocusControl_Down', const.Keys.DOWN, fdown, wrap)
	local left = columns and AddFocusKey(self, '_FocusControl_Left', const.Keys.LEFT, Inverter(GetColumnIndex), wrap_c)
	local right = columns and AddFocusKey(self, '_FocusControl_Right', const.Keys.RIGHT, GetColumnIndex, wrap_c)
	return enter, up, down, left, right
end


-- text input --


function item.StartInput(t, captureEsc, lim, numeric, text, acceptInput)
	if acceptInput and InputItem then
		InputItem.Parent:AcceptInput()
	end
	CancelInput()
	InputItem, InputCaptureEsc = t, captureEsc
	Game.StartTextInput(lim, numeric, t.Parent.Dlg)
	text = text or t.Text or ""
	Game.TextInput = text
	Game.TextInputLength = #text
	callback('OnStartInput', t.Parent, t)
end

function class:AcceptInput()
	if InputItem and InputItem.Parent == self then
		if Game.TextInputMode ~= 0 then
			Game.EndTextInput(2)
		end
		InputAccepted()
	end
end

function class:CancelInput()
	if InputItem and InputItem.Parent == self then
		CancelInput()
	end
end
