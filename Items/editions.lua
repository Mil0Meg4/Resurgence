SMODS.Shader {
    key = 'divine',
    path = 'divine.fs'
}

SMODS.Edition{
    key = "divine",
    shader = 'divine',
    config = {
        level = 1
    },
    calculate = function(self,card,context)
        if context.post_joker then
            level_up_hand(card,G.GAME.last_hand_played)
            return nil,true
        end
    end
}

SMODS.Edition{
    key = "faust",
	order = 5,
	shader = false,
	weight = 7,
	extra_cost = 10,
    in_shop = true,
	config = { dollars = 6 },
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea  == G.play) or (context.end_of_round and context.cardarea == G.jokers) then
            return { p_dollars = self.config.dollars }end    
        end,
    calc_dollar_bonus = function(self, card)
        return 6
    end
}

