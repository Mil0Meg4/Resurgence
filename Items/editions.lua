SMODS.Edition{
    key = "divine",
    shader = false,
    calculate = function(self,card,context)
        if context.post_joker then
            return{
                level_up = 1,
            }
    end
end
}