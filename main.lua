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

