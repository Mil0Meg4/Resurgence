SMODS.Enhancement {
    key = 'alpha',
    atlas = 'enha',
    pos = { x = 0, y = 0 },
    replace_base_card = true,
    config = {extra = {e_mult = 2}},
    loc_vars = function(self, info_queue, card)
		local anv = card and card.ability.extra or self.config.extra
		return {
			vars = {anv.e_mult},
		}
	end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                emult = card.ability.extra.e_mult
            }
        end
        if card.base.suit ~= "anva_al_om" or card.base.value ~= "anva_alpha_rank" then
            local _suit = SMODS.Suits["anva_al_om"]
            local _rank = SMODS.Ranks["anva_alpha_rank"]
            card:set_base(G.P_CARDS[('%s_%s'):format(_suit.card_key, _rank.card_key)])
        end
    end
}
SMODS.Enhancement {
    key = 'omega',
    atlas = 'enha',
    pos = { x = 1, y = 0 },
    replace_base_card = true,
    config = {extra = {e_chips = 2}},
    loc_vars = function(self, info_queue, card)
		local anv = card and card.ability.extra or self.config.extra
		return {
			vars = {anv.e_chips},
		}
	end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                echips = card.ability.extra.e_chips
            }
        end
        if card.base.suit ~= "anva_al_om" or card.base.value ~= "anva_omega_rank" then
            local _suit = SMODS.Suits["anva_al_om"]
            local _rank = SMODS.Ranks["anva_omega_rank"]
            card:set_base(G.P_CARDS[('%s_%s'):format(_suit.card_key, _rank.card_key)])
        end
    end
}