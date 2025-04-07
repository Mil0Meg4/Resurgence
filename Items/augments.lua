SMODS.ConsumableType({
    key = "augment",
    primary_colour = ANVA.C.AUGMENT,
    secondary_colour = ANVA.C.AUGMENT,
    collection_rows = {4, 3},
    shop_rate = 4,
    default = 'c_anva_motherboard'
})

SMODS.UndiscoveredSprite({
    key = "augment",
    atlas = "wip",
    pos = { x = 0, y = 0 },
    no_overlay = true
})

SMODS.Consumable({
    key = 'aug_mother',
    set = 'augment',
    atlas = 'wip',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 2, left_val = 1,right_val = 0},
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return #G.jokers.highlighted > 0 and #G.jokers.highlighted <= self.config.max_highlighted
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for i=1, #G.jokers.highlighted do--apply to all selected jokers
                local joker = G.jokers.highlighted[i]
                local pos_val = G.jokers.cards[1] == joker and self.config.left_val or self.config.right_val--checks if selected joker is leftmost
                --set all values to 1, the second argument is nil since we re not using any reference table
                --the last one too since we aare want to affect all values
                ANVA.mod_table_values(joker.ability,nil,{set = pos_val},nil)
            end
        return true end }))
    end
})