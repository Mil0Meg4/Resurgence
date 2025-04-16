--paints are just stickers with a different name code wise
ANVA.Paint = SMODS.Sticker:extend {
    prefix_config = { key = true },
    should_apply = false,
    config = {},
    rate = 0,
    in_shop = true,
    sets = {
        Default = true
    },
    in_pool = function(self,source)
		return true
	end,
    weight = 0,
    draw = function(self, card)
        card.children.center:draw_shader(self.shader or 'foil', nil, card.ARGS.send_to_shader)
        if card.children.front and not SMODS.has_no_rank(card) then
            card.children.front:draw_shader(self.shader or 'foil', nil, card.ARGS.send_to_shader)
        end
        --if card.edition then card.children.center:draw_shader("polychrome", nil, card.ARGS.send_to_shader) end
    end,

    apply = function(self, card, val)
        card.ability[self.key] = val and copy_table(self.config) or nil
        card.ability.paint = val and copy_table(self.config) or nil 
    end
}

--table with all the paints' keys, needed for distinguishing them from stickers
--when creating a new paint always add it here
ANVA.Paint_keys = {
    "blue",
    "red",
    "green",
    "yellow",
    "orange",
    "purple",
    "pink",
    "cyan",
    "brown",
}

SMODS.Shader {
    key = 'blue',
    path = 'blue.fs'
}
SMODS.Shader {
    key = 'red',
    path = 'red.fs'
}
SMODS.Shader {
    key = 'green',
    path = 'green.fs'
}
SMODS.Shader {
    key = 'yellow',
    path = 'yellow.fs'
}
SMODS.Shader {
    key = 'orange',
    path = 'orange.fs'
}
SMODS.Shader {
    key = 'pink',
    path = 'pink.fs'
}
SMODS.Shader {
    key = 'purple',
    path = 'purple.fs'
}
SMODS.Shader {
    key = 'cyan',
    path = 'cyan.fs'
}
SMODS.Shader {
    key = 'brown',
    path = 'brown.fs'
}

ANVA.Paint {
    key = 'paint_blue',
    badge_colour = G.C.CHIPS,
    shader = 'blue',
    weight = 26,
    config = {chips = 40},
    loc_vars = function(self, info_queue, card)
        local anv = card.ability.paint or self.config
        return { vars = { anv.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            return {
                chips = card.ability.paint.chips
            }
        end
    end
}
ANVA.Paint {
    key = 'paint_red',
    badge_colour = G.C.RED,
    shader = 'red',
    weight = 26,
    config = {mult = 8},
    loc_vars = function(self, info_queue, card)
        local anv = card.ability.paint or self.config
        return { vars = { anv.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            return {
                mult = card.ability.paint.mult
            }
        end
    end
}

ANVA.Paint {
    key = 'paint_green',
    badge_colour = G.C.GREEN,
    shader = 'green',
    weight = 24,
    config = {dis = 1},
    loc_vars = function(self, info_queue, card)
        local anv = card.ability.paint or self.config
        return { vars = { anv.dis } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.setting_blind and not card.getting_sliced and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            ease_discard(card.ability.paint.dis)
            return {
                message = localize('k_discards'),
                colour = G.C.RED,
            }
        end
    end
}
ANVA.Paint {
    key = 'paint_yellow',
    badge_colour = G.C.MONEY,
    shader = 'yellow',
    weight = 24,
    config = {dollars = 4},
    loc_vars = function(self, info_queue, card)
        local anv = card.ability.paint or self.config
        return { vars = { anv.dollars } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea  == G.play) or (context.end_of_round and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            return { dollars = card.ability.paint.dollars }
        end
    end
}
ANVA.Paint {
    key = 'paint_orange',
    badge_colour = G.C.FILTER,
    shader = 'orange',
    weight = 21,
    config = {ret = 1},
    loc_vars = function(self, info_queue, card)
        local anv = card.ability.paint or self.config
        return { vars = { anv.ret } }
    end,
    calculate = function(self, card, context)
        if context.other_card == card and ((context.repetition and context.cardarea == G.play)
        or (context.retrigger_joker_check and not context.retrigger_joker))
		then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.paint.ret,
			}
		end
    end
}
ANVA.Paint {
    key = 'paint_pink',
    badge_colour = ANVA.C.PINK,
    shader = 'pink',
    weight = 19,
    config = {chips_c = 25,chips_j = 35},
    loc_vars = function(self, info_queue, card)
        local anv = card.ability.paint or self.config
        local card_tally = 0
        local joker_tally = 0
        for k, v in pairs(G.playing_cards or {}) do
			if ANVA.has_paint(v,'pink') then card_tally = card_tally + 1 end
		end
        for k, v in pairs(G.jokers and G.jokers.cards or {}) do
			if ANVA.has_paint(v,'pink') then joker_tally = joker_tally + 1 end
		end
        return { vars = {anv.chips_c,anv.chips_j, anv.chips_c * card_tally + anv.chips_j * joker_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            local anv = card.ability.paint
            local card_tally = 0
            local joker_tally = 0
            for k, v in pairs(G.playing_cards) do
                if ANVA.has_paint(v,'pink') then card_tally = card_tally + 1 end
            end
            for k, v in pairs(G.jokers.cards) do
                if ANVA.has_paint(v,'pink') then joker_tally = joker_tally + 1 end
            end
            return {
                chips = anv.chips_c * card_tally + anv.chips_j * joker_tally
            }
        end
    end
} 
ANVA.Paint {
    key = 'paint_cyan',
    badge_colour = ANVA.C.CYAN,
    shader = 'cyan',
    weight = 18,
    config = {hand = 1},
    loc_vars = function(self, info_queue, card)
        local anv = card.ability.paint or self.config
        return { vars = { anv.hand } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.setting_blind and not card.getting_sliced and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            ease_hands_played(card.ability.paint.hand)
            return {
                message = localize('k_hands'),
                colour = G.C.CHIPS,
            }
        end
    end
}
ANVA.Paint {
    key = 'paint_purple',
    badge_colour = G.C.PURPLE,
    shader = 'purple',
    weight = 15,
    config = {mult = 5,hand_a = "High Card",hand_b = "Straight Flush"},
    loc_vars = function(self, info_queue, card)
        local anv = card.ability.paint or self.config
        local tally = G.GAME.hands[anv.hand_a].played + G.GAME.hands[anv.hand_b].played
        return { vars = { anv.mult,anv.mult * tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            local tally = G.GAME.hands[card.ability.paint.hand_a].played + G.GAME.hands[card.ability.paint.hand_b].played
            return {
                mult = card.ability.paint.mult * tally
            }
        end
    end
}
--[[ ANVA.Paint {
    key = 'paint_brown',
    badge_colour = ANVA.C.BROWN,
    shader = 'brown',
    weight = 7,
    config = {},
    loc_vars = function(self, info_queue, card)
        local anv = self.config or card.ability.paint
    end,
    calculate = function(self, card, context)
    end
} ]]

--gives cards a random chance of being painted, also handles pride flag
local orig_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local paints = nil
    local flag = false
    local pride_flag_paints = nil
    if G.jokers then
        for i = 1, #G.jokers.cards do
            pride_flag_paints = G.jokers.cards[i].config.center.pride_flag_paints or pride_flag_paints
        end
    end
    if area == G.pack_cards and pride_flag_paints then
        paints = not pride_flag_paints["any"] and pride_flag_paints or nil
        flag = true
    end
    local paint = nil
    local _card = orig_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if (_type=='Base' or _type == 'Enhanced') then
        paint = poll_paint('paint'..(key_append or '')..G.GAME.round_resets.ante,2,flag,paints)
    end
    if (_type=='Joker') then
        paint = poll_paint('paint'..(key_append or '')..G.GAME.round_resets.ante,nil,flag,paints)
    end
    if paint then ANVA.set_paint(_card,paint) end
    return _card
end
-------------------------------------------------------------
----stuff for making paints have their own collection tab----
-------------------------------------------------------------
local function paint_ui()
    local paints = {}

    for k, v in pairs(SMODS.Stickers) do
        if ANVA.is_paint(k) then
        paints[k] = v
        end
    end

    return SMODS.card_collection_UIBox(paints, { 5, 5 }, {
        snap_back = true,
        hide_single_page = true,
        collapse_single_page = true,
        center = 'c_base',
        h_mod = 1.18,
        back_func = 'your_collection_other_gameobjects',
        modify_card = function(card, center)
        card.ignore_pinned = true
        center:apply(card, true)
        end,
    })
end

G.FUNCS.your_collection_anva_paints = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
    definition = paint_ui()
    }
end
