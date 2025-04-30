SMODS.Shader {
    key = 'divine',
    path = 'divine.fs'
}
SMODS.Shader {
    key = 'faustian',
    path = 'faustian.fs'
}

SMODS.Edition{
    key = "divine",
    shader = 'divine',
    config = {
        level = 1
    },
    calculate = function(self,card,context)
        if (context.cardarea == G.jokers and context.post_joker) or (context.main_scoring and context.cardarea  == G.play) then
            level_up_hand(card,G.GAME.last_hand_played)
            return nil,true
        end
    end
}

SMODS.Edition{
    key = "faust",
	order = 5,
	shader = 'faustian',
	weight = 7,
	extra_cost = 10,
    in_shop = true,
	config = { dollars = 6 },
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea  == G.play) or (context.end_of_round and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            return { p_dollars = self.config.dollars }
        end    
    end
}

