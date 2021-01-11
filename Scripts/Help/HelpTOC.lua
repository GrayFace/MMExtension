local ss, links, places, nover

local function Iterate(pat, rep)
	places = {}
	ss:gsub('<a name="[^"]+" >.-<h[1-6][^>]*>()', |place| places[place] = true)
	ss = ss:gsub(pat, rep)
end

local function Conv(s, ru)
	s = s:gsub("`?en|([^|]+)|", ru and "" or "%1")
	s = s:gsub("`?ru|([^|]+)|", ru and "%1" or "")
	-- s = s:gsub("||", "|")
	return s
end

local function ToName(s)
	return s:gsub("<br/?>", " ")
end

local function ToLink(s)
	s = Conv(s):gsub("<[^>]*>", ""):gsub("[ \r\n]+", " "):gsub(" $", ""):gsub("^ ", "")
	s = nover and s:match("(.-) v[%d%.]+$") or s
	s = s:gsub("[\\]", ""):gsub(" ", "-")
	while links[s] do
		s = s.."-"
	end
	links[s] = true
	-- print(s)
	return '<a name="'..s..'" ></a>'
end

local function Rep(pre, place, name, post)
	return not places[place] and ToLink(name)..pre..ToName(name)..post
end

local H = '<h[1-6][^>]*>)()(.-)(</h[1-6]>)'

local function InsertTOC()
	links = {}
	ss:gsub('<a name="([^"]+)"', |link| links[link] = true)
	-- table header
	Iterate('(<table[^>]*>[^<]*<tbody[^>]*>[^<]*<tr[^>]*>[^<]*<td[^>]*>[^<]*'..H, Rep)
	-- other
	Iterate('('..H, Rep)
end


-- Make TOC
local toc, depth

local function W(s)
	toc[#toc+1] = s
end

local function CloseTOC(kind)
	local list
	for i = #depth, 1, -1 do
		if kind > depth[i] then
			break
		end
		if list then
			W"</ul>"
		end
		list = true
		if i > 1 then
			W"</li>"
		end
		depth[i] = nil
	end
	if not list then
		W"<ul>"
	end
end

local function CleanUp(name)
	return name:gsub("<a [^>]*>", ""):gsub("</a>", ""):gsub("<img [^>]*>", ""):gsub("</img>", "")
end

local function ToTOC(link, kind, name)
	CloseTOC(kind)
	depth[#depth + 1] = kind
	W"<li>"
	
	W(('<a href="#%s">%s</a>'):format(link, CleanUp(name)))
end

local function MakeTOC()
	toc = {}
	depth = {"0"}
	ss:gsub('<a name="([^"]+)" >.-<h([1-6])[^>]*>(.-)</h[1-6]>', ToTOC)
	CloseTOC("0")
	return table.concat(toc)
end

return {TOC = function(s, StripVer)
	ss = s
	nover = StripVer
	InsertTOC()
	return ss, MakeTOC()
end}