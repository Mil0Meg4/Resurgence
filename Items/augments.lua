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
    config = {max_highlighted = 2},
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return #G.jokers.highlighted > 0 and #G.jokers.highlighted <= self.config.max_highlighted
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            for i=1, #G.jokers.highlighted do
                ANVA.motherboardize(G.jokers.highlighted[i])
            end
        return true end }))
    end
})

function ANVA.motherboardize(joker)
    --[[ for k, v in pairs(joker.ability) do
        if type(v) == "table" then
            ANVA.motherboardize(v)
        elseif is_number(v) 
        and not (k == "perish_tally")
        and not (k == "id")
        and not (k == "colour")
        and not (k == "suit_nominal")
        and not (k == "base_nominal")
        and not (k == "face_nominal")
        and not (k == "qty")
        and not (k == "x_mult" and v == 1)
        and not (k == "x_chips" and v == 1)
        and not (k == "h_x_chips")
        and not (k == "selected_d6_face") then
            print(v)
            v = 19
            print(v)
        end
    end ]]
    print("doesn't work rn :(")
end


