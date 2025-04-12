ANVA = {}
ANVA.C = {}
ANVA.C.AUGMENT = HEX("b59262")
SMODS.load_file("Items/funcs.lua")()
SMODS.load_file("Items/jokers.lua")()
SMODS.load_file("Items/editions.lua")()
SMODS.load_file("Items/augments.lua")()
SMODS.load_file("Items/tweaks.lua")()
SMODS.load_file("Items/paints.lua")()

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

function SMODS.current_mod.reset_game_globals(run_start)
	if run_start then
    end
end

-------------------------------------------------------------
----stuff for making tweaks and paints have their own collection tabs----
-------------------------------------------------------------
SMODS.current_mod.custom_collection_tabs = function()
    return {
        UIBox_button({
        button = 'your_collection_anva_tweaks',
        id = 'your_collection_anva_tweaks',
        label = { localize('anva_tweak_ui') },
        minw = 5,
        minh = 1
        }),
        UIBox_button({
        button = 'your_collection_anva_paints',
        id = 'your_collection_anva_paints',
        label = { localize('anva_paint_ui') },
        minw = 5,
        minh = 1
        })
    }
end

local function wrap_without_paints_and_tweaks(func)
    local removed = {}
    for k, v in pairs(SMODS.Stickers) do
        if ANVA.is_paint(k) or ANVA.is_tweak(k) then
        removed[k] = v
        SMODS.Stickers[k] = nil
        end
    end

    local ret = func()

    for k, v in pairs(removed) do
        SMODS.Stickers[k] = v
    end

    return ret
end

local stickers_ui_ref = create_UIBox_your_collection_stickers
create_UIBox_your_collection_stickers = function()
    return wrap_without_paints_and_tweaks(stickers_ui_ref)
end

local other_objects_ref = create_UIBox_Other_GameObjects
create_UIBox_Other_GameObjects = function()
    return wrap_without_paints_and_tweaks(other_objects_ref)
end
