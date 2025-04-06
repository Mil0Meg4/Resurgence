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
    --this is so broken, wtf are you doing revo? I'll fix it tomorrow
    --jk love u <3
    calculate = function(self,card,context)
        if context.post_joker then
            return{
                level_up = card.edition.level,
            }
        end
    end
}