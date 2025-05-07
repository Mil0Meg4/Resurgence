SMODS.ConsumableType({
    key = "Augment",
    primary_colour = ANVA.C.AUGMENT,
    secondary_colour = ANVA.C.AUGMENT,
    collection_rows = {4, 3},
    shop_rate = 0,
    default = 'c_anva_aug_mother'
})

SMODS.UndiscoveredSprite({
    key = "Augment",
    atlas = "aug",
    pos = { x = 0, y = 0 },
    no_overlay = true
})

SMODS.Consumable({
    key = 'aug_mother',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 2, tweak = "mother"},
    loc_vars = function(self, info_queue)
        local anv = self.config
        info_queue[#info_queue + 1] = { key = "anva_"..anv.tweak, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return #G.jokers.highlighted > 0 and #G.jokers.highlighted <= self.config.max_highlighted
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_tweak(v, card.ability.tweak)--set the tweak
            end
        return true end }))
    end
})

SMODS.Consumable({
    key = 'aug_rubber',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, tweak = "rubber"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_"..anv.tweak, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return #G.jokers.highlighted > 0 and #G.jokers.highlighted <= self.config.max_highlighted
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.remove_stickers(v)
                ANVA.set_tweak(v, card.ability.tweak)--set the tweak
            end
        return true end }))
    end
})

SMODS.Consumable({
    key = 'aug_lever',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 2, tweak = "lever"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_"..anv.tweak, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return #G.jokers.highlighted > 0 and #G.jokers.highlighted <= self.config.max_highlighted
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_tweak(v, card.ability.tweak)--set the tweak
            end
        return true end }))
    end
})

SMODS.Consumable({
    key = 'aug_tinfoil',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
    end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return not G.GAME.tinfoil_count or (#G.jokers.highlighted > 0 and #G.jokers.highlighted <= self.config.max_highlighted)
	end,
    use = function(self, card, area, copier)
        if G.GAME.tinfoil_count then
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                v:set_edition("e_foil", true)
                G.GAME.tinfoil_count = false
            end
        else
            G.GAME.tinfoil_count = true
        end
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})

--Boosters
SMODS.Booster({
    key = 'small_aug_1',
    atlas = 'tinker',
    kind = "Augment",
    pos = { x = 0, y = 0 },
    config = {choose = 1, extra = 3},
    cost = 4,
    weight = 0.3,
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Augment", G.pack_cards, nil, nil, true,  true, nil, "augpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, ANVA.C.AUGMENT)
        ease_background_colour{new_colour = ANVA.C.AUGMENT, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_anva_aug_pack',
    draw_hand = false,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {ANVA.C.AUGMENT, lighten(ANVA.C.AUGMENT, 0.4), lighten(ANVA.C.AUGMENT, 0.2), darken(ANVA.C.AUGMENT, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})
SMODS.Booster({
    key = 'small_aug_2',
    atlas = 'tinker',
    kind = "Augment",
    pos = { x = 1, y = 0 },
    config = {choose = 1, extra = 3},
    cost = 4,
    weight = 0.3,
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Augment", G.pack_cards, nil, nil, true,  true, nil, "augpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, ANVA.C.AUGMENT)
        ease_background_colour{new_colour = ANVA.C.AUGMENT, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_anva_aug_pack',
    draw_hand = false,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {ANVA.C.AUGMENT, lighten(ANVA.C.AUGMENT, 0.4), lighten(ANVA.C.AUGMENT, 0.2), darken(ANVA.C.AUGMENT, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})
SMODS.Booster({
    key = 'mid_aug',
    atlas = 'tinker',
    kind = "Augment",
    pos = { x = 2, y = 0 },
    config = {choose = 1, extra = 5},
    cost = 6,
    weight = 0.3,
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Augment", G.pack_cards, nil, nil, true,  true, nil, "augpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, ANVA.C.AUGMENT)
        ease_background_colour{new_colour = ANVA.C.AUGMENT, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_anva_aug_pack',
    draw_hand = false,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {ANVA.C.AUGMENT, lighten(ANVA.C.AUGMENT, 0.4), lighten(ANVA.C.AUGMENT, 0.2), darken(ANVA.C.AUGMENT, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})
SMODS.Booster({
    key = 'big_aug',
    atlas = 'tinker',
    kind = "Augment",
    pos = { x = 3, y = 0 },
    config = {choose = 2, extra = 5},
    cost = 8,
    weight = 0.07,
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Augment", G.pack_cards, nil, nil, true,  true, nil, "augpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, ANVA.C.AUGMENT)
        ease_background_colour{new_colour = ANVA.C.AUGMENT, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_anva_aug_pack',
    draw_hand = false,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {ANVA.C.AUGMENT, lighten(ANVA.C.AUGMENT, 0.4), lighten(ANVA.C.AUGMENT, 0.2), darken(ANVA.C.AUGMENT, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})

----debug stuff----
SMODS.Consumable({
    key = 'aug_red',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "red"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})
SMODS.Consumable({
    key = 'aug_blue',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "blue"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})
SMODS.Consumable({
    key = 'aug_green',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "green"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})
SMODS.Consumable({
    key = 'aug_yellow',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "yellow"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})
SMODS.Consumable({
    key = 'aug_orange',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "orange"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})
SMODS.Consumable({
    key = 'aug_pink',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "pink"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})
SMODS.Consumable({
    key = 'aug_cyan',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "cyan"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})
SMODS.Consumable({
    key = 'aug_purple',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "purple"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})
SMODS.Consumable({
    key = 'aug_brown',
    set = 'Augment',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1, paint = "brown"},
    loc_vars = function(self, info_queue)
        local anv = self.config
		info_queue[#info_queue + 1] = { key = "anva_paint_"..anv.paint, set = "Other", vars = {} }
		return { vars = {anv.max_highlighted} }
	end,
    can_use = function(self, card)--determins when you can use the consumable
        --checks that at least one joker is selected but not more than the maximum allowed
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()--short delay before the effect
            play_sound('tarot1')--normal consumable shenanigans
            card:juice_up(0.3, 0.5)--normal consumable shenanigans
            for _, v in ipairs(G.jokers.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
            for _, v in ipairs(G.hand.highlighted) do--apply to all selected jokers
                ANVA.set_paint(v, card.ability.paint)--set the tweak
            end
        return true end }))
    end,
    in_pool = function(self, wawa, wawa2)
		return false --if this was false this joker wouldnt spawn naturally.
	end,
})