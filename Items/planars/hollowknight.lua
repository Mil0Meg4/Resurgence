SMODS.Joker {
	key = 'sly',
	pools = {planar = true, hollow = true},
	rarity = 1,
	atlas = 'joke',
	blueprint_compat = true,
	eternal_compat = true,
    perishable_compat = false,
    config = {extra = {dollars = 2}},
	pos = { x = 3, y = 0},
	cost = 5,
	discovered = true,
	unbound = {evo = "nailsage"},
	calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.post_trigger and context.other_card.ability.set == "Joker") then
			local _card = context.other_card
			if not (_card.retrig and _card.retrig[(context.blueprint_card and context.blueprint_card.ID) or card.ID]) then
                if not _card.retrig then _card.retrig = {} end
				_card.retrig[(context.blueprint_card and context.blueprint_card.ID) or card.ID] = true
				G.E_MANAGER:add_event(Event({
					func = function()
						if _card then
							_card.retrig = nil
						end
						return true
					end,
				}))
			else
				return {dollars = card.ability.extra.dollars}
			end
		end
		if not context.blueprint and context.cardarea == G.jokers
		and (context.setting_blind or context.ending_shop or context.end_of_round) 
		and to_big(G.GAME.dollars + (G.GAME.dollar_buffer or 0)) >= to_big(150) then
			return ANVA.unbound(card)
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Hollow Knight", ANVA.C.HOLLOW, G.C.WHITE, 1)
	end,
}
SMODS.Joker {
	key = 'nailsage',
	pools = {planar = true, hollow = true},
	rarity = "anva_unb",
	atlas = 'joke',
	blueprint_compat = true,
	eternal_compat = true,
    perishable_compat = false,
    config = {extra = {dollars = 2,x_mult = 0.1,dollar_div = 4}},
	pos = { x = 3, y = 0},
	cost = 10,
	discovered = true,
	calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.post_trigger and context.other_card.ability.set == "Joker") then
			local _card = context.other_card
			if not (_card.retrig and _card.retrig[(context.blueprint_card and context.blueprint_card.ID) or card.ID]) then
                if not _card.retrig then _card.retrig = {} end
				_card.retrig[(context.blueprint_card and context.blueprint_card.ID) or card.ID] = true
				G.E_MANAGER:add_event(Event({
					func = function()
						if _card then
							_card.retrig = nil
						end
						return true
					end,
				}))
			else
				return {dollars = card.ability.extra.dollars}
			end
		end
		if context.joker_main then
			return{
				xmult = 1 + card.ability.extra.x_mult * to_number(math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollar_div)))
			}
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Hollow Knight", ANVA.C.HOLLOW, G.C.WHITE, 1)
	end,
}