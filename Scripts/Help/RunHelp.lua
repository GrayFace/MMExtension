local _KNOWNGLOBALS_F = HelpStructs, help

if not help then
	function help()
		require'help'
		dofile(debug.FunctionFile(1))
		return HelpStructs
	end
	return help
end

-----------------------------------------------------
-- convert Lua
-----------------------------------------------------

local ConvLua = require"lua52html"

local function ConvertLua(code)
	-- print(code)
	local start = code:match("^\n*")
	local s = ""
	ConvLua.highlight(code, function(s1)
		s = s..s1
	end)
	local s = start..s:match("^\n*(.*)")
	return s:gsub("\n", "<br>")
end

-----------------------------------------------------
-- write them all
-----------------------------------------------------

local P = require 'HelpWrite'
local BasePath = DevPath..'Scripts/Help/'
local HelpPath = HelpPath or {}
HelpPath.MMExtScripts = HelpPath.MMExtScripts or DevPath..'../MMExt-Scripts/'
HelpPath[''] = '%'
local convPath = |s| s:gsub("%%([%w_]*)%%", HelpPath)

local template = io.load(BasePath..'MMExtRefTemplate.htm'):gsub("\r\n", "\n")
P.HTML{
	SectionText = template:split("<h2>.-</h2>"),
	SectionNames = {file = "General Functions"},
	SectionFields = {evt = "en|Parameters|ru|Параметры|", event = "en|Events|ru|События|", file = "en|Variables|ru|Переменные|", struct = "en|Fields|ru|Свойства|", const = "en|Values|ru|Значения|"},
	SectionNoFields = {evt = "en|Has no parameters.|ru|Нет параметров.|"},
	TxtFunctions = "en|Functions:|ru|Функции:|",
	TxtMethods = "en|Methods:|ru|Методы:|",
}

P.WriteSection("evt", true)
P.WriteSection("event", true)
P.WriteSection("file", true)
P.WriteSection("struct", nil, {"structs.GameStructure", "structs.GameParty", "structs.GameMap", "structs.GameMouse", "structs.GameScreen"})
P.WriteSection("const")

local s = io.load(BasePath..'MMExtRefStart.htm'):gsub("\r\n", "\n")
s = s:gsub(" %- ()", |n| s:find("<(/?)lua1?>", n) ~= "/" and " &ndash; ")
s = s:gsub("<lua>\n?(.-)\n?</lua>", |s| '<div class="pre-outer"><div class="pre">'..ConvertLua(s)..'</div></div>')
s = s:gsub("<lua1>\n?(.-)\n?</lua1>", |s| '<span class="def-code">'..ConvertLua(s)..'</span>')
local spoilerN = 0
s = s:gsub("<luaf>(.-)</luaf>", |s| do
	spoilerN = spoilerN + 1
	return '<div class="spoiler">'..
		'<input class="spoiler-checkbox" type="checkbox" id="spoiler'..spoilerN..'"/>'..
		'<div class="spoiler-scroll">'..
			'<div class="spoiler-space"></div>'..
			'<div class="pre-spoiler">'..ConvertLua(io.load(convPath(s)))..'</div></div>'..
		'<label class="spoiler-label" for="spoiler'..spoilerN..'"></label>'..
		'<span class="spoiler-fade"></span></div>'
end)
s = s:gsub("<pre>(.-)</pre>", '<div class="pre-outer"><div class="pre">%1</div></div>')
s = s:gsub("<'>(.-)</'>", '<b class="def-param">%1</b>')
s = s:gsub("<#>([^<:]*):?([^<:]*)</#>", |s1, s2| '<a href="#'..P.ExpandRef(s2 ~= "" and s2 or s1)..'">'..s1..'</a>')

s = P.PrintFinish(s)
-- io.SaveString([[c:\_Delphi\MMExtHelp\MMExtensionReference.htm]], s)
-- os.execute[[c:\_Delphi\MMExtHelp\ProcessHelp.exe c:\_Delphi\MMExtHelp\MMExtensionReference.htm]]

local DefStyle = P.DefStyle..[[
.pre-outer { margin:7px -1px; overflow-x: auto; }
.pre { margin:0;border:1px solid #a5a5a5;padding:5px 5px 5px; white-space:pre-wrap; font-family: monospace,monospace; font-size: 85%; display:inline-block; }
.spoiler { margin:7px -1px; overflow-x: auto; border:1px solid #a5a5a5; }
.pre-spoiler { margin:0;padding:5px 5px 5px; white-space:pre-wrap; font-family: monospace,monospace; font-size: 85%; }
.abs { position:absolute;top:0; }
.spoiler-checkbox { display: none; }
.spoiler-label { display: none; }
.spoiler-fade { display: none; }
.table { margin:6px 0; border: 1px solid #888; border-collapse:collapse; }
.width-500 { min-width:70%;width:500px; }
]]

local s, toc = require("HelpTOC").TOC(s)
s = s:gsub('(<a [^>]-) *>', '%1>'):gsub('(<td[^>]*>[^<]*<a +name=[^>]*)>', '%1 class="abs">'):gsub("<a name=", "<a id=")

local function Conv(s, ru)
	s = s:gsub("en|([^|]+)|", ru and "" or "%1")
	s = s:gsub("ru|([^|]+)|", ru and "%1" or "")
	-- s = s:gsub("||", "|")
	return s
end

-- Google Sites don't support <style> tag
-- local s1 = s--:gsub('(<tr)>', '%1 style="position:relative">')
-- DefStyle:gsub("%.([^ ]+) *{ *(.-);? *}", |class, style| do
-- 	s1 = s1:replace('td class="'..class..'"', 'td style="'..style..';position:relative"')
-- 	s1 = s1:replace(' class="'..class..'"', ' style="'..style..'"')
-- end)

-- io.SaveString([[c:\_Delphi\MMExtHelp\MMExtensionReferenceEn.htm]], Conv(s1))
-- io.SaveString([[c:\_Delphi\MMExtHelp\MMExtensionReferenceRu.htm]], Conv(s1, true))

-----------------------------------------------------
-- TOC
-----------------------------------------------------

s = s:gsub('<div><img src="https://www.google.com/chart[^>]*></div>', "")

s = io.load(BasePath..'MMExtHTML.htm'):gsub("\r\n", "\n"):gsub('<ALL></ALL>', || s)
s = s:gsub('<TOC></TOC>', || toc)

DefStyle = DefStyle:gsub('padding:([1-9])px ([1-9])px ([1-9])px([";])', |a,b,c,d| 'padding:'..a..'px '..(b+2)..'px '..(c+2)..'px'..d)
s = s:replace('<DefStyle></DefStyle>', '<style>\n'..DefStyle..'</style>')

-- local f = io.popen([[c:\_Delphi\MMExtHelp\ProcessHelp.exe -ver "]]..DevPath..[[ExeMods\MMExtension.dll"]])
-- local ver = f:read("*a")
-- f:close()
local function UTF16p(s)  -- for patterns
	return s:gsub("(.)", "%1%%z")
end
local function GetVer(fname)
	local function N(s)
		local a, b = s:byte(1, 2)
		return a + b*256
	end
	local s, v = io.load(fname), nil
	s:gsub(UTF16p("VS_VERSION_INFO")..".?.?..\xBD\4\xEF\xFE....(..)(..)(..)(..)",
		|v2, v1, v4, v3| v = N(v1).."."..N(v2).."."..N(v3).."."..N(v4)
	)
	v = v:gsub("%.0$", "") or v
	return v:gsub("%.0$", "") or v
end

s = s:gsub('<AppVer></AppVer>', || GetVer(DevPath..[[ExeMods\MMExtension.dll]]))

local s1 = s:gsub("</?ForSite>", ""):gsub("charset=windows%-1251", "charset=utf-8")
s = s:gsub("<ForSite>.-</ForSite>", "")

-- io.SaveString([[c:\_Delphi\MMExtHelp\MMExtension.htm]], Conv(s))
-- io.SaveString([[c:\_Delphi\MMExtHelp\MMExtensionRu.htm]], Conv(s, true))
io.SaveString(DevPath..'MMExtension.htm', Conv(s))
io.SaveString(DevPath..'MMExtensionRu.htm', Conv(s, true))
if HelpPath.Site then
	io.SaveString(HelpPath.Site..[[mm\ext\ref\index.html]], Conv(s1):convert(0, 'utf8'))
	io.SaveString(HelpPath.Site..[[ru\mm\ext\ref\index.html]], Conv(s1, true):convert(0, 'utf8'))
end

--[[  Borderless style:
	.def-left {
		border-left: none;
	}
	.def-right {
		border-right: none;
	}
	.def-table td:not(.def-left):not(.def-right) {
		border-left: none;
		border-right: none;
		border-top: none;
	}	
	/*table,*/ .def-table {
		/* border: 1px solid #eee !important; */
		/* border-radius: 3px !important; */
		border: none;
	}
/*	.pre {
		border-radius: 2.5px;
	}
 	table:not(.def-table) td:first-of-type {
		border-left: none;
	}
	table:not(.def-table) td:last-of-type {
		border-right: none;
	}
	table:not(.def-table) tr:first-of-type td {
		border-top: none;
	}
 */	
]]