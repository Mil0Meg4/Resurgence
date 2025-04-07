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