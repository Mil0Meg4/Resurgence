ANVA = {}
ANVA.C = {}
ANVA.C.AUGMENT = HEX("b59262")
SMODS.load_file("Items/funcs.lua")()
SMODS.load_file("Items/jokers.lua")()
SMODS.load_file("Items/editions.lua")()
SMODS.load_file("Items/augments.lua")()


--PLACEHOLDER ATLAS

SMODS.Atlas{
    key = "wip",
    path = "placeholder.png",
    px = 71,
    py = 95
}
--

--Mod icon
SMODS.Atlas({
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34
})
--shamelessly stolen from cryptid
function ANVA.deep_copy(obj, seen)
	if type(obj) ~= "table" then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do
		res[ANVA.deep_copy(k, s)] = ANVA.deep_copy(v, s)
	end
	return res
end

