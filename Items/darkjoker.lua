SMODS.Atlas {
    key = 'pjokers',
    path = "pjokers.png",
    px = 71,
    py = 95
}
RSGC.equations = {
    {1,-3,2},
    {1,-4,3},
    {1,-5,4},
    {1,-6,5},
    {1,-7,6},
    {1,-8,7},
    {1,-9,8},
    {1,-10,9},
    {1,-11,10},
    {1,-5,6},
    {1,-6,8},
    {1,-7,10},
    {1,-8,12},
    {1,-9,14},
    {1,-10,16},
    {1,-11,18},
    {1,-12,20},
    {1,-7,12},
    {1,-8,15},
    {1,-9,18},
    {1,-10,21},
    {1,-11,24},
    {1,-12,27},
    {1,-13,30},
    {1,-9,20},
    {1,-10,24},
    {1,-11,28},
    {1,-12,32},
    {1,-13,36},
    {1,-14,40},
    {1,-11,30},
    {1,-12,35},
    {1,-13,40},
    {1,-14,45},
    {1,-15,50},
    {1,-13,42},
    {1,-14,48},
    {1,-15,54},
    {1,-16,60},
    {1,-15,56},
    {1,-16,63},
    {1,-17,70},
    {1,-17,72},
    {1,-18,80},
    {1,-19,90},
}

RSGC.Joker({
	key = "bfm_l",
	atlas = "pjokers",
	pos = { x = 0, y = 11 },
	rarity = 1,
	cost = 5,
	config = {extra = { mult = 99,}},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		if not card.fake_card then info_queue[#info_queue + 1] = G.P_CENTERS.j_pridark_bfm_r end
		local ext = card.ability.extra
		return {
			vars = { ext.mult},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local ext = card.ability.extra
			local active = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card and G.jokers.cards[i+1] then 
					active = G.jokers.cards[i+1].config.center.key == "j_pridark_bfm_r"
				end
			end
			if active then
				return {
					mult = ext.mult,
					card = card
				}
			end
		end
	end,
})

RSGC.Joker({
	key = "bfm_r",
	atlas = "pjokers",
	pos = { x = 0, y = 12 },
	rarity = 1,
	cost = 5,
	config = {extra = { chips = 99,}},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		if not card.fake_card then info_queue[#info_queue + 1] = G.P_CENTERS.j_pridark_bfm_l end
		local ext = card.ability.extra
		return {
			vars = { ext.chips},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local ext = card.ability.extra
			local active = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card and G.jokers.cards[i-1] then 
					active = G.jokers.cards[i-1].config.center.key == "j_pridark_bfm_l"
				end
			end
			if active then
				return {
					chips = ext.chips,
					card = card
				}
			end
		end
	end,
})

RSGC.Joker({
	key = "surprise_test",
	atlas = "pjokers",
	pos = {x=0,y=0},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    immutable = true,
    config = {extra = {x_mult = 3,eq_index = 1,results = {0,0}}},
    loc_vars = function(self, info_queue, center)
        local abc = {RSGC.equations[center.ability.extra.eq_index][1],
        RSGC.equations[center.ability.extra.eq_index][2],
        RSGC.equations[center.ability.extra.eq_index][3]
    }
        local polynomial = string.format("%s %s%s %s %s%s %s %s",
            abc[1] >= 0 and "" or "-",
            abc[1] ~= 1 and tostring(math.abs(abc[1])) or "",
            "X^2",
            abc[2] >= 0 and "+" or "-",
            abc[2] ~= 1 and tostring(math.abs(abc[2])) or "",
            "X",
            abc[3] >= 0 and "+" or "-",
            abc[3] ~= 1 and tostring(math.abs(abc[3])) or ""
            )
		return {
            vars = {
                center.ability.extra.x_mult,
                polynomial
            }
        }
	end,
    add_to_deck = function(self, card, from_debuff)
		card.ability.extra.eq_index = pseudorandom("algebra", 1, #RSGC.equations)
        card.ability.extra.results = solveFromIndex(card.ability.extra.eq_index)
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and (context.end_of_round and not context.blueprint) then
            local old_value = card.ability.extra.eq_index
            while card.ability.extra.eq_index == old_value do
			    card.ability.extra.eq_index = pseudorandom("algebra", 1, #RSGC.equations)
            end
            card.ability.extra.results = solveFromIndex(card.ability.extra.eq_index)
			return {
				message = localize('k_reset')
			}
		end
        if context.cardarea == G.play and context.individual then
            local trigger = false
            for _, rank in pairs(card.ability.extra.results) do
                local _rank = tostring(rank)
                if _rank == "1" then _rank = "Ace" end
                if _rank == context.other_card.config.card.value then
                    trigger = true
                end
            end
			if trigger then
				return {
					xmult = card.ability.extra.x_mult,
					card = card
				}
			end
        end
    end
})

local eps = 1e-9

local function isZero(d)
	return (d > -eps and d < eps)
end

function solveQuadric(c0, c1, c2)
	local s0, s1

	local p, q, D

	p = c1 / (2 * c0)
	q = c2 / c0

	D = p * p - q

	if isZero(D) then
		s0 = -p
		return {s0}
	elseif (D < 0) then
		return {}
	else -- if (D > 0)
		local sqrt_D = math.sqrt(D)

		s0 = sqrt_D - p
		s1 = -sqrt_D - p
		return {s0,s1}
	end
end

function solveFromIndex(index)
    local c0 = RSGC.equations[index][1]
    local c1 = RSGC.equations[index][2]
    local c2 = RSGC.equations[index][3]
    return solveQuadric(c0, c1, c2)
end

RSGC.Joker({
	key = "karl",
	atlas = "pjokers",
	pos = {x=0,y=1},
    soul_pos = {x=0,y=2},
	rarity = 4,
	cost = 20,
	unlocked = false,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
})

local orig_get_current_pool = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append, override_equilibrium_effect)
	if next(find_joker('j_rsgc_karl')) and not G.GAME.modifiers.cry_equilibrium then
		if _type == "Joker" then
			PDARK_JOKERS = {}
            for k, v in pairs(G.P_CENTER_POOLS.Joker) do
                if v.unlocked == true and not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman"))) then
                    PDARK_JOKERS[#PDARK_JOKERS + 1] = v.key
                end
            end
			if #PDARK_JOKERS <= 0 then
				PDARK_JOKERS[#PDARK_JOKERS + 1] = "j_joker"
			end
			return PDARK_JOKERS, "karl" .. G.GAME.round_resets.ante
		end
	end
	return orig_get_current_pool(_type, _rarity, _legendary, _append)
end

local orig_get_rarity_badge = SMODS.Rarity.get_rarity_badge
function SMODS.Rarity:get_rarity_badge(rarity)
    if next(find_joker('j_rsgc_karl')) then return localize("k_comrade") end
    return orig_get_rarity_badge(self, rarity)
end

local orig_get_type_colour = get_type_colour
function get_type_colour(_c, card)
    return next(find_joker('j_rsgc_karl')) and _c.set == 'Joker' and G.C.RED or orig_get_type_colour(_c, card)
end

function RSGC.awaken(card)
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound('tarot2', 1.1, 0.6)
            card:set_ability(G.P_CENTERS[card.ability.awakened])
            return true
        end
    }))
    return {
        message = localize('k_awaken'),
        colour = RSGC.PRISMATIC,
        card = card
    }
end

RSGC.Joker({
	key = "time_loop",
	atlas = "pjokers",
	pos = {x=0,y=3},
    soul_pos = {x=0,y=4},
	rarity = "rsgc_prim",
	cost = 40,
	unlocked = false,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    config = {extra = {ante = -1}},
    loc_vars = function(self, info_queue, center)
		return {
            vars = {center.ability.extra.ante}
        }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and not context.other_card then
            ease_ante(card.ability.extra.ante)
            return {
                message = localize('k_loop'),
                colour = G.C.CHIPS
            }
        end
    end
})


RSGC.Joker({
	key = "opticus",
	atlas = "pjokers",
	pos = {x=0,y=5},
    soul_pos = {x=0,y=6},
	rarity = "rsgc_prim",
	cost = 40,
	unlocked = false,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    config = {extra = {gain = 0.1}},
    loc_vars = function(self, info_queue, center)
		return {
            vars = {center.ability.extra.gain}
        }
	end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            local suits = {}
            for k, _ in pairs(SMODS.Suits) do
                suits[k] = 0
            end
            local card_suit = context.other_card.base.suit
            for k, v in pairs(G.playing_cards or {}) do
                for suit, count in pairs(suits) do
                    if suit ~= card_suit and v:is_suit(suit) then
                        v.ability.perma_x_mult = v.ability.perma_x_mult or 0
                        v.ability.perma_x_mult = v.ability.perma_x_mult + card.ability.extra.gain
                        break
                    end
                end
            end
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
                card = card
            }
        end
    end
})
