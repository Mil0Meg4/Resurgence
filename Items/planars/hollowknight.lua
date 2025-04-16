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
	calculate = function(self, card, context)
		if context.individual and (context.cardarea == G.play or context.cardarea == G.Jokers) then
			if not (context.other_card.retrig and context.other_card.retrig[(context.blueprint_card and context.blueprint_card.ID) or card.ID]) then
                local _card = context.other_card
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
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Hollow Knight", ANVA.C.HOLLOW, G.C.WHITE, 1)
	end,
}