---@diagnostic disable: param-type-mismatch

--42
SMODS.Rank {

    key = '42',
    card_key = '42',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 0 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_42' },
	prev = { 'rsgc_42' },

    nominal = 42,
    shorthand = '42',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return false
    end
}

table.insert(SMODS.Ranks['10'].next, 'rsgc_11')--add 11 after 10
--11
SMODS.Rank {

    key = '11',
    card_key = '11',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 1 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    next = { 'rsgc_12' },
	prev = { '10' },

    nominal = 11,
    face_nominal = 0.5,
    shorthand = '11',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}
--12
SMODS.Rank {

    key = '12',
    card_key = '12',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 2 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    next = { 'rsgc_13' },
	prev = { 'rsgc_11' },

    nominal = 12,
    shorthand = '12',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

--13
SMODS.Rank {

    key = '13',
    card_key = '13',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 3 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    next = { 'rsgc_14' },
	prev = { 'rsgc_12' },

    nominal = 13,
    shorthand = '13',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

--14
SMODS.Rank {

    key = '14',
    card_key = '14',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 4 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    next = { 'rsgc_15' },
	prev = { 'rsgc_13' },

    nominal = 14,
    shorthand = '14',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

--15
SMODS.Rank {

    key = '15',
    card_key = '15',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 5 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    next = { 'rsgc_16' },
	prev = { 'rsgc_14' },

    nominal = 15,
    shorthand = '15',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

--16
SMODS.Rank {

    key = '16',
    card_key = '16',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 6 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_17' },
	prev = { 'rsgc_15' },

    nominal = 16,
    shorthand = '16',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

--17
SMODS.Rank {

    key = '17',
    card_key = '17',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 7 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_18' },
	prev = { 'rsgc_16' },

    nominal = 17,
    shorthand = '17',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

--18
SMODS.Rank {

    key = '18',
    card_key = '18',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 8 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    next = { 'rsgc_19' },
	prev = { 'rsgc_17' },

    nominal = 18,
    shorthand = '18',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

--19
SMODS.Rank {

    key = '19',
    card_key = '19',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 9 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    next = { 'rsgc_20' },
	prev = { 'rsgc_18' },

    nominal = 19,
    shorthand = '19',
    hidden = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

--20
SMODS.Rank {

    key = '20',
    card_key = '20',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 10 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    next = { '2' },
	prev = { 'rsgc_19' },

    nominal = 20,
    shorthand = '20',
    hidden = true,

    straight_edge = true,

	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

SMODS.Rank {

    key = 'googol',
    card_key = 'googol',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 12 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_googol' },
	prev = { 'rsgc_googol' },

    nominal = 1e100,
    shorthand = 'googol',
    hidden = true,

    straight_edge = true,

	in_pool = function(self, args)
        return G.GAME.macro_ranks
    end
}

---suitless and rankless
SMODS.Rank {

    key = 'rankless',
    card_key = 'RANKLESS',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 11 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },
    
    --next = { 'rsgc_rankless' },
	--prev = { 'rsgc_rankless' },

    nominal = 0,
    shorthand = '',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}
SMODS.Suit {

    key = 'suitless',
    card_key = 'SUITLESS',

    lc_atlas = 'suitless',
    --lc_ui_atlas = 'enha',
    lc_colour = G.C.GREY,

    hc_atlas = 'suitless',
    --hc_ui_atlas = 'enha',
    hc_colour = G.C.GREY,

    hidded = true,
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },

    in_pool = function(self, args)
        return false
    end
}
local orig_has_no_suit = SMODS.has_no_suit
function SMODS.has_no_suit(card)
    if card.base.suit == "rsgc_suitless" then
        local is_wild = false
        for k, _ in pairs(SMODS.get_enhancements(card)) do
            if k == 'm_wild' or G.P_CENTERS[k].any_suit then is_wild = true end
        end
        return not is_wild
    end
    return orig_has_no_suit(card)
end
local orig_has_no_rank = SMODS.has_no_rank
function SMODS.has_no_rank(card)
    if card.base.value == "rsgc_rankless" then
        return true
    end
    return orig_has_no_rank(card)
end

SMODS.PokerHand({
	key = "nothinghand",
	visible = false,
	chips = 0,
	mult = 0,
	l_chips = 1,
	l_mult = 1,
    order_offset = 6,
	example = {
		{ "rsgc_SUITLESS_rsgc_RANKLESS", true },
		{ "rsgc_SUITLESS_rsgc_RANKLESS", true },
		{ "rsgc_SUITLESS_rsgc_RANKLESS", true },
		{ "rsgc_SUITLESS_rsgc_RANKLESS", true },
		{ "rsgc_SUITLESS_rsgc_RANKLESS", true },
	},
	evaluate = function(parts, hand)
		local nothings = {}
		for i, card in ipairs(hand) do
			if card.base.value == "rsgc_rankless"
			then
				nothings[#nothings + 1] = card
            else
                return {}
            end
		end
		return #nothings > 0 and { nothings } or {}
	end,
})
SMODS.Planet {
    key = 'no_planet',
    atlas = 'specral',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    config = {
        hand_type = 'rsgc_nothinghand',
        softlock = true,
    },
    loc_vars = function(self, info_queue, center)
		return {
			vars = {
				G.GAME.hands["rsgc_nothinghand"].level,
                localize("rsgc_nothinghand"),
				G.GAME.hands["rsgc_nothinghand"].l_mult,
				G.GAME.hands["rsgc_nothinghand"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["rsgc_nothinghand"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.hands["rsgc_nothinghand"].level)):to_number()]
					),
				},
			},
		}
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_no_planet"), get_type_colour(self or card.config, card), nil, 1.2)
	end
}
