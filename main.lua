ANVA = {}
ANVA.C = {
    VAMPIRICA = HEX("880808"),
    AUGMENT = HEX("b59262"),
    DIVINE = HEX("ffffbb"),
    FAUST = HEX("b66444"),
    CURSED = HEX("4a0044"),
    PRIMORDIAL = HEX("000000"),
    UNBOUND = HEX("000000"),
    ARTIFACT = HEX("000000"),
    PINK = HEX("eda5b2"),
    CYAN = HEX("93cbcb"),
    BROWN = HEX("4e3f36"),
    BLACK = HEX("000000"),
}
ANVA.GRADIENTS = {
    UNDER = {G.C.RED,G.C.PURPLE},
    ULTRA = {ANVA.C.VAMPIRICA,G.C.BLACK},
    VAMP = {ANVA.C.VAMPIRICA,G.C.MONEY},
    HOLLOW = {HEX("6b8cad"),G.C.BLACK},
    PRIMORDIAL = {ANVA.C.VAMPIRICA,HEX("52134b")},
    UNBOUND = {HEX("bc5a25"),ANVA.C.VAMPIRICA},
    ARTIFACT = {HEX("40b5c4"),HEX("a8ced3")}

}
SMODS.load_file("Items/funcs.lua")()
SMODS.load_file("Items/ui.lua")()
SMODS.load_file("Items/editions.lua")()
SMODS.load_file("Items/augments.lua")()
SMODS.load_file("Items/tweaks.lua")()
SMODS.load_file("Items/enhancements.lua")()
SMODS.load_file("Items/jokers.lua")()
SMODS.load_file("Items/planars/ultrakill.lua")()
SMODS.load_file("Items/planars/undertale.lua")()
SMODS.load_file("Items/planars/vampire.lua")()
SMODS.load_file("Items/planars/hollowknight.lua")()
SMODS.load_file("Items/planars/hgttg.lua")()
SMODS.load_file("Items/paints.lua")()--paint must be after hgttg for ordering reasons

--joker ATLAS
SMODS.Atlas{
    key = "joke",
    path = "joker.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "enha",
    path = "enhancement.png",
    px = 71,
    py = 95
}
--augment ATLAS
SMODS.Atlas{
    key = "aug",
    path = "augment.png",
    px = 71,
    py = 95
}
--tinker pack ATLAS
SMODS.Atlas{
    key = "tinker",
    path = "boosters.png",
    px = 71,
    py = 95
}
--Ranks Atlas
SMODS.Atlas{
    key = "ranks_lc",
    path = "rank_lc.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "ranks_hc",
    path = "rank_hc.png",
    px = 71,
    py = 95
}
--Mod icon
SMODS.Atlas({
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34
})
local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        lc()
    end
    G.ARGS.LOC_COLOURS.anv_pink = ANVA.C.PINK
    G.ARGS.LOC_COLOURS.anv_cyan = ANVA.C.CYAN
    G.ARGS.LOC_COLOURS.anv_under = ANVA.C.UNDER
    G.ARGS.LOC_COLOURS.anv_aug= ANVA.C.AUGMENT
    G.ARGS.LOC_COLOURS.anv_black= ANVA.C.BLACK
    return lc(_c, _default)
end

local orig_update = Game.update
function Game:update(dt)
    orig_update(self,dt)
	local anim_timer = self.TIMERS.REAL * 1.5
	local p = 0.5 * (math.sin(anim_timer) + 1)
	for k, c in pairs(ANVA.GRADIENTS) do
		if not ANVA.C[k] then
			ANVA.C[k] = { 0, 0, 0, 0 }
		end
		for i = 1, 4 do
			ANVA.C[k][i] = c[1][i] * p + c[2][i] * (1 - p)
		end
	end

    --fate
    --[[ if G.GAME.fate_amount then
        G.GAME.probabilities.normal = G.GAME.probabilities.normal / G.GAME.fate_amount
        G.GAME.fate_amount = nil
    end
    if next(find_joker("j_anva_fate")) then
        local rand = 100e99^pseudorandom("g") + 100e9
        if pseudorandom("r") < 0.5 then
            G.GAME.probabilities.normal = G.GAME.probabilities.normal * rand
            G.GAME.fate_amount = rand
        else
            G.GAME.probabilities.normal = G.GAME.probabilities.normal * -rand
            G.GAME.fate_amount = -rand
        end
    end ]]
end
--new context that trigger whenever a card is destroyed or sold
local orig_start_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	--[[ if G and G.jokers and G.jokers.cards then
		SMODS.calculate_context({ anva_destroyed = true, card = self })
	end ]]
    if self.ability and self.ability.anva_rubber and not self.ability.selling then
        local copy = copy_card(self, nil, nil, nil, nil)
        copy:start_materialize()
        copy:add_to_deck()
        G.jokers:emplace(copy)
    end
	return orig_start_dissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

function SMODS.current_mod.reset_game_globals(run_start)
	if run_start then
        G.GAME.current_pride_flag = ANVA.poll_flag("game_start")
    end
end

SMODS.Sound({
	key = "augment_music",
	path = "augment.ogg",
	sync = true,
	select_music_track = function()
		return G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "Augment"
	end
})

SMODS.Sound({
	key = "prim_music",
	path = "primordial.ogg",
	sync = false,
	pitch = 1,
	select_music_track = function()
		return #ANVA.advanced_find_joker(nil,"anva_prim", nil, nil, true) ~= 0 and 15
	end
})
-------------------------------------------------------------------------
----stuff for making tweaks and paints have their own collection tabs----
-------------------------------------------------------------------------
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


------------------------------------------------------------
-----------------------Planar Sets--------------------------
------------------------------------------------------------
SMODS.ObjectType({
	key = "undertale",
	default = "j_anva_frisk",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.ObjectType({
	key = "ultrakill",
	default = "j_anva_filth",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.ObjectType({
	key = "planar",
	default = "j_anva_filth",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.ObjectType({
	key = "vampire",
	default = "j_anva_poe",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "hollow",
	default = "j_anva_sly",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

--------------------------------------------------------
-------------------Alpha and Omega----------------------
--------------------------------------------------------
SMODS.Rank {

    key = 'alpha_rank',
    card_key = 'ALPHA',

    --hc_atlas = 'aug',
    --lc_atlas = 'aug',
    pos = { x = 1 },

    next = { 'anva_omega_rank' },
	prev = { 'anva_omega_rank' },

    nominal = 0,
    shorthand = 'a',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}
SMODS.Rank {

    key = 'omega_rank',
    card_key = 'OMEGA',

    --hc_atlas = 'aug',
    --lc_atlas = 'aug',
    pos = { x = 1 },

    next = { 'anva_alpha_rank' },
	prev = { 'anva_alpha_rank' },

    nominal = 0,
    shorthand = 'o',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}
SMODS.Suit {

    key = 'greek',
    card_key = 'ALPHA_OMEGA',

    lc_atlas = 'enha',
    lc_ui_atlas = 'enha',
    lc_colour = ANVA.C.VAMPIRICA,

    hc_atlas = 'enha',
    hc_ui_atlas = 'enha',
    hc_colour = ANVA.C.VAMPIRICA,

    hidded = true,
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },

    in_pool = function(self, args)
        return false
    end
}

--42
SMODS.Rank {

    key = '42',
    card_key = '42',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 0 },

    next = { 'anva_42' },
	prev = { 'anva_42' },

    nominal = 42,
    shorthand = '42',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--11
SMODS.Rank {

    key = '11',
    card_key = '11',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 1 },

    next = { 'anva_12' },
	prev = { '10' },

    nominal = 11,
    shorthand = '11',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--12
SMODS.Rank {

    key = '12',
    card_key = '12',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 2 },

    next = { 'anva_13' },
	prev = { 'anva_11' },

    nominal = 12,
    shorthand = '12',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--13
SMODS.Rank {

    key = '13',
    card_key = '13',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 3 },

    next = { 'anva_14' },
	prev = { 'anva_12' },

    nominal = 13,
    shorthand = '13',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--14
SMODS.Rank {

    key = '14',
    card_key = '14',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 4 },

    next = { 'anva_15' },
	prev = { 'anva_13' },

    nominal = 14,
    shorthand = '14',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--15
SMODS.Rank {

    key = '15',
    card_key = '15',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 5 },

    next = { 'anva_16' },
	prev = { 'anva_14' },

    nominal = 15,
    shorthand = '15',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--16
SMODS.Rank {

    key = '16',
    card_key = '16',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 6 },

    next = { 'anva_17' },
	prev = { 'anva_15' },

    nominal = 16,
    shorthand = '16',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--17
SMODS.Rank {

    key = '17',
    card_key = '17',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 7 },

    next = { 'anva_18' },
	prev = { 'anva_16' },

    nominal = 17,
    shorthand = '17',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--18
SMODS.Rank {

    key = '18',
    card_key = '18',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 8 },

    next = { 'anva_19' },
	prev = { 'anva_17' },

    nominal = 18,
    shorthand = '18',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--19
SMODS.Rank {

    key = '19',
    card_key = '19',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 9 },

    next = { 'anva_20' },
	prev = { 'anva_18' },

    nominal = 19,
    shorthand = '19',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

--20
SMODS.Rank {

    key = '20',
    card_key = '20',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 10 },

    next = { '2' },
	prev = { 'anva_19' },

    nominal = 20,
    shorthand = '20',
    hidden = true,

    straight_edge = true,

	in_pool = function(self, args)
        return false
    end
}