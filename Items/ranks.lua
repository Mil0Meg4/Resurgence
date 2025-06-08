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
        for k, v in pairs(G.playing_cards or {}) do
			if v.base.value == "rsgc_42" then return true end
		end
		return false
    end
}

table.insert(SMODS.Ranks['10'].next, 'rsgc_11')--add 11 after 10
table.insert(SMODS.Ranks['Ace'].prev, 'rsgc_0.9')--add 0.9 before Ace
table.insert(SMODS.Ranks['2'].prev, 'rsgc_1')--add 1 before 2
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
        return RSGC.macro_pool()
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
        return RSGC.macro_pool()
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
        return RSGC.macro_pool()
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
        return RSGC.macro_pool()
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
        return RSGC.macro_pool()
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
        return RSGC.macro_pool()
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
        return RSGC.macro_pool()
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
        return RSGC.macro_pool()
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
        return RSGC.macro_pool()
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

    rsgc_macro = true,
	in_pool = function(self, args)
        return RSGC.macro_pool()
    end
}

SMODS.Rank {

    key = '01',
    card_key = '01',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 13 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_0.2' },
	--prev = { 'rsgc_19' },

    nominal = 0.1,
    shorthand = '0.1',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '02',
    card_key = '02',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 14 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_0.3' },
	prev = { 'rsgc_0.1' },

    nominal = 0.2,
    shorthand = '0.2',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '03',
    card_key = '03',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 15 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_0.4' },
	prev = { 'rsgc_0.2' },

    nominal = 0.3,
    shorthand = '0.3',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '04',
    card_key = '04',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 16 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_0.5' },
	prev = { 'rsgc_0.3' },

    nominal = 0.4,
    shorthand = '0.4',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '05',
    card_key = '05',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 17 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_0.6' },
	prev = { 'rsgc_0.4' },

    nominal = 0.5,
    shorthand = '0.5',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '06',
    card_key = '06',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 18 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_0.7' },
	prev = { 'rsgc_0.5' },

    nominal = 0.6,
    shorthand = '0.6',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '07',
    card_key = '07',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 19 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_0.8' },
	prev = { 'rsgc_0.6' },

    nominal = 0.7,
    shorthand = '0.7',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '08',
    card_key = '08',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 20 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'rsgc_0.9' },
	prev = { 'rsgc_0.7' },

    nominal = 0.8,
    shorthand = '0.8',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '09',
    card_key = '09',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 21 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { 'Ace', 'rsgc_1' },
	prev = { 'rsgc_0.8' },

    nominal = 0.9,
    shorthand = '0.9',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
    end
}

SMODS.Rank {

    key = '1',
    card_key = '1',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 22 },

    suit_map={
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        rsgc_suitless = 4
    },

    next = { '2' },
	prev = { 'rsgc_0.9' },

    nominal = 1,
    shorthand = '1',
    hidden = true,

    rsgc_micro = true,
	in_pool = function(self, args)
        return RSGC.micro_pool()
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
    shorthand = '1e100',
    hidden = true,

    straight_edge = true,

    rsgc_macro = true,
	in_pool = function(self, args)
        return false
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

function RSGC.macro_pool()
    if G.GAME.macro_ranks then return true end
    for k, v in pairs(G.playing_cards or {}) do
        if RSGC.is_macro(v)
        and v.base.value ~= "rsgc_42"
        and v.base.value ~= "rsgc_69"
        and v.base.value ~= "rsgc_googol"
        then return true end
    end
    return false
end  

function RSGC.micro_pool()
    if G.GAME.micro_ranks then return true end
    for k, v in pairs(G.playing_cards or {}) do
        if RSGC.is_micro(v) then return true end
    end
    return false
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
