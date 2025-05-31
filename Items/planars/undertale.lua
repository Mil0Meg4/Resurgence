SMODS.Rarity({
	key = "gast_err",
	badge_colour = G.C.CHIPS,
	pools = {
	},
	default_weight = 0,
})

SMODS.Shader {
    key = 'gaster',
    path = 'gaster.fs'
}

local orig_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if not forced_key and soulable and not G.GAME.banned_keys["c_soul"] then
		if (_type == 'Planet' or _type == 'Spectral') and
		not (G.GAME.used_jokers['j_rsgc_gaster'] and not next(find_joker("Showman")))  then 
			if pseudorandom('gast_'.._type..G.GAME.round_resets.ante) > (1 - 0.003/5) then
				forced_key = 'j_rsgc_gaster'
			end
		end
	end
	return orig_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end

RSGC.Joker({
	key = "frisk",
	atlas = "joke",
	pos = { x = 2, y = 2 },
	rarity = 1,
	cost = 3,
	config = { extra = { chips = 30 } },
	pools = {planar = true, undertale = true},
	unlocked = true,
	discovered = true,
	perishable_compat = false,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		local friends = 0
		local rarities = {}
		for i = 1, G.jokers and #G.jokers.cards or 0 do
			if
				G.jokers.cards[i].ability.set == "Joker" and not rarities[G.jokers.cards[i].config.center.rarity]
			then
				friends = friends + 1
				rarities[G.jokers.cards[i].config.center.rarity] = true
			end
		end
		return {
			vars = { rsgc.chips,rsgc.chips*friends },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local rsgc = card.ability.extra
			local friends = 0
			local rarities = {}
			for i = 1, #G.jokers.cards do
				if
					G.jokers.cards[i].ability.set == "Joker" and not rarities[G.jokers.cards[i].config.center.rarity]
				then
					friends = friends + 1
					rarities[G.jokers.cards[i].config.center.rarity] = true
				end
			end
			return {
				chips = rsgc.chips * friends,
			}
		end
	end,
})

RSGC.Joker({
	key = "papyrus",
	atlas = "joke",
	pos = { x = 2, y = 1 },
	pools = {planar = true, undertale = true},
	rarity = 1,
	cost = 2,
	config = {},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = RSGC.paint_tooltip("blue")
	end,
	calculate = function(self, card, context)
		if context.before and #G.play.cards == 1 then
			RSGC.set_paint(G.play.cards[1], "blue")
			return {
				message = localize("k_blue"),
				colour = G.C.CHIPS
			}
		end
	end,
})

RSGC.Joker({
	key = "alphys",
	atlas = "joke",
	pos = { x = 2, y = 5 },
	soul_pos = { x = 2, y = 4 },
	pools = {planar = true, undertale = true},
	rarity = 4,
	cost = 20,
	config = {},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and context.blind.boss then
			RSGC.create_card("Joker", G.jokers, nil, nil, nil, nil, "j_blueprint",nil,nil,function()
				SMODS.calculate_effect {
					message = localize("k_blueprinted"),
					colour = G.C.CHIPS,
					card = card
				}
			end)
			return {}
		end
	end,
})

RSGC.Joker {
	key = 'sans',
	rarity = 2,
	atlas = 'joke',
	config = { 
		extra = {chips = 5, chipsadd = 10} },
	pools = {planar = true, undertale = true},
	pos = { x = 2, y = 0 },
	cost = 7,
	discovered = true,
	perishable_compat = false,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.chips, rsgc.chipsadd },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and G.GAME.blind:get_type() ~= 'Boss' then
			local _tag = G.GAME.skip_tag
			if _tag and _tag.config and _tag.config.ref_table then
				add_tag(_tag.config.ref_table)
				G.GAME.skip_tag = ''
				return {
					message = localize("k_sans_tag"),
					colour = G.C.FILTER
				}
			end
		end
		if context.skip_blind then
			local rsgc = card.ability.extra
			local monsters = 0
			for k,v in pairs(G.jokers.cards) do
				if v.config.center.pools.undertale then
					monsters = monsters + 1
				end
			end
			rsgc.chips = rsgc.chips+(rsgc.chipsadd*monsters) 
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.CHIPS
			}
		end
		if context.joker_main then
			local rsgc = card.ability.extra
			return{
				chips = rsgc.chips,
			}
		end
	end,
}

RSGC.Joker({
	key = "gaster",
	atlas = "joke",
	pos = { x = 2, y = 3 },
	pools = {planar = true, undertale = true},
	rarity = "rsgc_gast_err",
	cost = 66,
	immutable = true,
	config = {h_size = 6, scored_sixes = 0},
	effect = "Hand Size",
	unlocked = true,
	discovered = true,
	perishable_compat = false,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability
		return {
			vars = { rsgc.scored_sixes },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			if context.other_card:get_id() == 6 then
				local rsgc = card.ability
				rsgc.scored_sixes = rsgc.scored_sixes+1
				if rsgc.scored_sixes >= 66 then
					rsgc.scored_sixes = 0
					G.E_MANAGER:add_event(Event({
						func = (function()
							for i=1,6 do
								add_tag(Tag('tag_negative'))
							end
							play_sound('generic1', 0.4 + math.random()*0.6, 0.35)
							play_sound('negative', 0.4 + math.random()*0.6, 0.45)
						   return true
					   end)
					}))
				end
				return{
					dollars = 6,
					chips = 66,
					mult = 6,
					message = (rsgc.scored_sixes == 0) and localize('k_plus_negative') or (rsgc.scored_sixes..'/66'),
					focus = card,
					colour = (rsgc.scored_sixes == 0) and G.C.DARK_EDITION or G.C.FILTER,
					card = card
				}
				
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		local rsgc = card.ability.extra
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + 6
		G.jokers.config.card_limit = G.jokers.config.card_limit + 6
		change_shop_size(6)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local rsgc = card.ability.extra
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - 6
		G.jokers.config.card_limit = G.jokers.config.card_limit - 6
		change_shop_size(-6)
	end,
	draw = function(self, card, layer)
		card.children.center:draw_shader("rsgc_gaster", nil, card.ARGS.send_to_shader)
	end,
})

local orig_evaluate_poker_hand = evaluate_poker_hand
function evaluate_poker_hand(hand)
	local hand = orig_evaluate_poker_hand(hand)
	if next(find_joker("j_rsgc_mini_mice")) then
		for _, v in ipairs(G.handlist) do
			if hand[v][1] then
				hand["High Card"] = hand[v]
				break
			end
		end
		for _, v in ipairs(G.handlist) do
			if v ~= "High Card" then hand[v] = {} end
		end
	end
	return hand
end

RSGC.Joker {
	key = 'mini_mice',
	config = { 
	  extra = {mult = 10} },
	pools = {planar = true, undertale = true},
	rarity = 1,
	atlas = 'joke',
	pos = { x = 2, y = 8 },
	cost = 2,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then 
			local rsgc = card.ability.extra
			return{
				mult = rsgc.mult
			}
		end
	end,
}
