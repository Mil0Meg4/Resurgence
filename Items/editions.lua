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
    weight = 4,
	extra_cost = 4,
    in_shop = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.level}}
    end,
    calculate = function(self,card,context)
        if (context.cardarea == G.jokers and context.post_joker) or (context.main_scoring and context.cardarea  == G.play) then
            level_up_hand(card,G.GAME.last_hand_played,nil,self.config.level)
            return nil,true
        end
    end
}

SMODS.Edition{
    key = "faustian",
	shader = 'faustian',
	weight = 2,
	extra_cost = 10,
    in_shop = true,
	config = { dollars = 6 },
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.dollars}}
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea  == G.play) or (context.end_of_round and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            return { p_dollars = self.config.dollars }
        end    
    end
}

SMODS.Shader {
    key = 'trans',
    path = 'trans.fs'
}
SMODS.Sound {
    key = 'trans',
    path = 'trans.ogg'
}

SMODS.Edition {
    key = 'trans',
    shader = 'trans',
    sound = {
        sound = 'pridark_trans',
        per = 1,
        vol = 0.7
    },
    discovered = true,
    weight = 3,
    in_shop = true,
    extra_cost = 5,
	config = {
        e_mult = 1.12
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (card.edition or {}).e_mult or self.config.e_mult
            }
        }
    end,
	calculate = function(self, card, context)
		if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				emult = card.edition.e_mult
			}
		end
	end
}
