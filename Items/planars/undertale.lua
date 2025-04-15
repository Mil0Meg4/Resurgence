SMODS.Rarity({
	key = "gast_err",
	badge_colour = G.C.CHIPS,
	pools = {
		["Joker"] = {
			rate = 0.00006, --added which pool its in so it can naturally spawn. mess arround with it
		},
	},
	default_weight = 0.00066,
})

SMODS.Joker({
	key = "frisk",
	atlas = "joke",
	pos = { x = 2, y = 0 },
	rarity = 1,
	cost = 3,
	config = { extra = { chips = 20 } },
	pools = {planar = true, undertale = true},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local anv = card.ability.extra
		return {
			vars = { anv.chips },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local anv = card.ability.extra
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
				chips = anv.chips * friends,
			}
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Undertale", ANVA.C.UNDER, G.C.WHITE, 1)
	end,
})

SMODS.Joker({
	key = "papyrus",
	atlas = "joke",
	pos = { x = 2, y = 1 },
	pools = {planar = true, undertale = true},
	rarity = 1,
	cost = 2,
	config = {},
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = { key = "anva_paint_blue", set = "Other", vars = {} }
	end,
	calculate = function(self, card, context)
		if context.before and #G.play.cards == 1 then
			ANVA.set_paint(G.play.cards[1], "blue")
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Undertale", ANVA.C.UNDER, G.C.WHITE, 1)
	end,
})

SMODS.Joker({
	key = "alphys",
	atlas = "joke",
	pos = { x = 2, y = 0 },
	pools = {planar = true, undertale = true},
	rarity = 4,
	cost = 20,
	config = {},
	unlocked = true,
	discovered = false,
	perishable_compat = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
	end,
	calculate = function(self, card, context)
		if context.end_of_round and G.GAME.blind.boss and not context.other_card then
			if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
				local new_card = create_card("Blueprint", G.jokers, nil, nil, nil, nil, "j_blueprint")
				new_card:add_to_deck()
				G.jokers:emplace(new_card)
			end
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Undertale", ANVA.C.UNDER, G.C.WHITE, 1)
	end,
})

SMODS.Joker {
	key = 'sans',
	rarity = 2,
	atlas = 'joke',
	config = { 
		extra = {chips = 5, chipsadd = 10} },
	pools = {planar = true, undertale = true},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = { x = 2, y = 0 },
	cost = 7,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		local anv = card.ability.extra
		return {
			vars = { anv.chips, anv.chipsadd },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and G.GAME.blind:get_type() ~= 'Boss' and not context.blueprint then
			local _tag = G.GAME.skip_tag
			if _tag and _tag.config then
				add_tag(_tag.config.ref_table)
				G.GAME.skip_tag = ''
			end
		end
		if context.skip_blind then
			local anv = card.ability.extra
			local monsters = -1
			for k,v in pairs(G.jokers.cards) do
				if v.config.center.pools.undertale then
					monsters = monsters + 1
				end
			end
			anv.chips = anv.chips+(anv.chipsadd*monsters) 
		end
		if context.joker_main then
			local anv = card.ability.extra
			return{
				chips = anv.chips
			}
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Undertale", ANVA.C.UNDER, G.C.WHITE, 1)
	end,
}

SMODS.Joker({
	key = "gaster",
	atlas = "joke",
	pos = { x = 2, y = 0 },
	pools = {planar = true, undertale = true},
	rarity = "anva_gast_err",
	cost = 66,
	immutable = true,
	config = {h_size = 6, scored_sixes = 66},
	effect = "Hand Size",
	unlocked = true,
	discovered = false,
	perishable_compat = false,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			if context.other_card:get_id() == 6 then
				local anv = card.ability
				anv.scored_sixes = anv.scored_sixes+1
				if anv.scored_sixes <= 0 then
					anv.scored_sixes = 66
					G.E_MANAGER:add_event(Event({
						func = (function()
							add_tag(Tag('tag_negative'))
							add_tag(Tag('tag_negative'))
							add_tag(Tag('tag_negative'))
							add_tag(Tag('tag_negative'))
							add_tag(Tag('tag_negative'))
							add_tag(Tag('tag_negative'))
							play_sound('generic1', 0.4 + math.random()*0.6, 0.35)
							play_sound('negative', 0.4 + math.random()*0.6, 0.45)
						   return true
					   end)
					}))
					end
				return{
					dollars = 6,
					chips = 66,
					mult = 6
				}
				
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
	local anv = card.ability.extra
	G.consumeables.config.card_limit = G.consumeables.config.card_limit + 6
	G.jokers.config.card_limit = G.jokers.config.card_limit + 6
	change_shop_size(6)
	end,
	remove_from_deck = function(self, card, from_debuff)
	local anv = card.ability.extra
	G.consumeables.config.card_limit = G.consumeables.config.card_limit - 6
	G.jokers.config.card_limit = G.jokers.config.card_limit - 6
	change_shop_size(-6)
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Undertale", ANVA.C.UNDER, G.C.WHITE, 1)
	end,
})

local orig_evaluate_poker_hand = evaluate_poker_hand
function evaluate_poker_hand(hand)
	local hand = orig_evaluate_poker_hand(hand)
	if next(find_joker("j_anva_mini_mice")) then
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

SMODS.Joker {
	key = 'mini_mice',
	config = { 
	  extra = {mult = 10} },
	pools = {planar = true, undertale = true},
	rarity = 1,
	atlas = 'joke',
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 2, y = 0 },
	cost = 2,
	discovered = true,
	calculate = function(self, card, context)
		if context.joker_main then 
			local anv = card.ability.extra
			return{
				mult = anv.mult
			}
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Undertale", ANVA.C.UNDER, G.C.WHITE, 1)
	end,
}
