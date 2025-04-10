ANVA = {}
ANVA.C = {}
ANVA.C.AUGMENT = HEX("b59262")
SMODS.load_file("Items/funcs.lua")()
SMODS.load_file("Items/jokers.lua")()
SMODS.load_file("Items/editions.lua")()
SMODS.load_file("Items/augments.lua")()
SMODS.load_file("Items/tweaks.lua")()

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

--new context that trigger whenever a card is destroyed or sold
local oldfunc = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	if G and G.jokers and G.jokers.cards then
		SMODS.calculate_context({ anva_destroyed = true, card = self })
	end
	return oldfunc(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end