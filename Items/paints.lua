--paints are just stickers with a different name code wise
RSGC.Paint = SMODS.Sticker:extend {
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
        self.config = val and copy_table(self.config) or nil 
    end
}

--table with all the paints' keys, needed for distinguishing them from stickers
--when creating a new paint always add it here
RSGC.Paint_keys = {
    "blue",
    "red",
    "green",
    "yellow",
    "orange",
    "purple",
    "pink",
    "cyan",
    "brown",
    "white",
    "black"
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
SMODS.Shader {
    key = 'white',
    path = 'white.fs'
}
SMODS.Shader {
    key = 'black',
    path = 'black.fs'
}

RSGC.Paint {
    key = 'paint_blue',
    badge_colour = G.C.CHIPS,
    shader = 'blue',
    weight = 26,
    config = {chips = 40},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        return { vars = { rsgc.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            return {
                chips = self.config.chips
            }
        end
    end
}
RSGC.Paint {
    key = 'paint_red',
    badge_colour = G.C.RED,
    shader = 'red',
    weight = 26,
    config = {mult = 8},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config or self.config
        return { vars = { rsgc.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            return {
                mult = self.config.mult
            }
        end
    end
}

RSGC.Paint {
    key = 'paint_green',
    badge_colour = G.C.GREEN,
    shader = 'green',
    weight = 24,
    config = {dis = 1},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        return { vars = { rsgc.dis } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.setting_blind and not card.getting_sliced and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            ease_discard(self.config.dis)
            return {
                message = localize('k_discards'),
                colour = G.C.RED,
            }
        end
    end
}
RSGC.Paint {
    key = 'paint_yellow',
    badge_colour = G.C.MONEY,
    shader = 'yellow',
    weight = 24,
    config = {dollars = 4},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        return { vars = { rsgc.dollars } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea  == G.play) or (context.end_of_round and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            return { dollars = self.config.dollars }
        end
    end
}
RSGC.Paint {
    key = 'paint_orange',
    badge_colour = G.C.FILTER,
    shader = 'orange',
    weight = 21,
    config = {ret = 1},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        return { vars = { rsgc.ret } }
    end,
    calculate = function(self, card, context)
        if context.other_card == card and ((context.repetition and context.cardarea == G.play)
        or (context.retrigger_joker_check and not context.retrigger_joker))
		then
			return {
				message = localize('k_again_ex'),
				repetitions = self.config.ret,
			}
		end
    end
}
RSGC.Paint {
    key = 'paint_pink',
    badge_colour = RSGC.C.PINK,
    shader = 'pink',
    weight = 19,
    config = {chips = 25,},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        local card_tally = 0
        for k, v in pairs(G.playing_cards or {}) do
			if RSGC.has_paint(v,'pink') then card_tally = card_tally + 1 end
		end
        for k, v in pairs(G.jokers and G.jokers.cards or {}) do
			if RSGC.has_paint(v,'pink') then card_tally = card_tally + 1 end
		end
        return { vars = {rsgc.chips, rsgc.chips * card_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            local rsgc = self.config
            local card_tally = 0
            for k, v in pairs(G.playing_cards or {}) do
                if RSGC.has_paint(v,'pink') then card_tally = card_tally + 1 end
            end
            for k, v in pairs(G.jokers and G.jokers.cards or {}) do
                if RSGC.has_paint(v,'pink') then card_tally = card_tally + 1 end
            end
            return {
                chips = rsgc.chips * card_tally
            }
        end
    end
} 
RSGC.Paint {
    key = 'paint_cyan',
    badge_colour = RSGC.C.CYAN,
    shader = 'cyan',
    weight = 18,
    config = {hand = 1},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        return { vars = { rsgc.hand } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.setting_blind and not card.getting_sliced and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            ease_hands_played(self.config.hand)
            return {
                message = localize('k_hands'),
                colour = G.C.CHIPS,
            }
        end
    end
}
RSGC.Paint {
    key = 'paint_purple',
    badge_colour = G.C.PURPLE,
    shader = 'purple',
    weight = 15,
    config = {mult = 5,hand_a = "High Card",hand_b = "Straight Flush"},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        local tally = G.GAME.hands[rsgc.hand_a].played + G.GAME.hands[rsgc.hand_b].played
        return { vars = { rsgc.mult,rsgc.mult * tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            local tally = G.GAME.hands[self.config.hand_a].played + G.GAME.hands[self.config.hand_b].played
            return {
                mult = self.config.mult * tally
            }
        end
    end
}
RSGC.Paint {
    key = 'paint_brown',
    badge_colour = RSGC.C.BROWN,
    shader = 'brown',
    weight = 7,
    calculate = function(self, card, context)
        local _card = nil
        local area = card.area == G.play and G.play.cards or card.area == G.hand and G.hand.cards or card.area == G.jokers and G.jokers.cards or nil
        if area then
            for i = 1, #area do
                if area[i] == card then _card = area[i+1] end
            end
        end
        if _card and RSGC.has_paint(_card) and _card ~= card then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
			context.blueprint_card = context.blueprint_card or card
            if context.blueprint > #area + 1 then return end
            local key = ""
            for k, _ in pairs(_card and _card.ability or {}) do
                if RSGC.is_paint(k) then
                    key = k
                end
            end
            local other_paint_ret = _card:calculate_sticker(context,key)
            local eff_card = context.blueprint_card or card
			context.blueprint = nil
			context.blueprint_card = nil
			if other_paint_ret == true then
				return other_paint_ret
			end
			if other_paint_ret then
				if not other_paint_ret then
					other_paint_ret = {}
				end
				other_paint_ret.card = eff_card
				other_paint_ret.colour = RSGC.C.BROWN
				other_paint_ret.no_callback = true
				return other_paint_ret
			end
        end
    end
}
RSGC.Paint {
    key = 'paint_white',
    badge_colour = G.C.WHITE,
    badge_text_colour = G.C.GREY,
    shader = 'white',
    weight = 9,
    config = {chips_1 = 15,chips_2 = 15},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        local tally = 0
        for k, v in pairs(G.playing_cards or {}) do
			if RSGC.has_paint(v) then tally = tally + 1 end
		end
        --[[ for k, v in pairs(G.jokers and G.jokers.cards or {}) do
			if RSGC.has_paint(v) then joker_tally = joker_tally + 1 end
		end ]]
        return { vars = {rsgc.chips_1,rsgc.chips_2,rsgc.chips_1 + rsgc.chips_2 * tally} }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            local rsgc = self.config
            local tally = 0
            for k, v in pairs(G.playing_cards or {}) do
                if RSGC.has_paint(v) then tally = tally + 1 end
            end
            --[[ for k, v in pairs(G.jokers and G.jokers.cards or {}) do
                if RSGC.has_paint(v) then joker_tally = joker_tally + 1 end
            end ]]
            return {
                chips = rsgc.chips_1 + rsgc.chips_2 * tally
            }
        end
    end
} 
RSGC.Paint {
    key = 'paint_black',
    badge_colour = G.C.BLACK,
    shader = 'black',
    weight = 9,
    config = {x_mult_1 = 2,x_mult_2 = 0.5},
    loc_vars = function(self, info_queue, card)
        local rsgc = self.config
        local tally = 0
        for k, v in pairs(G.jokers and G.jokers.cards or {}) do
			if RSGC.has_paint(v) then tally = tally + 1 end
		end
        return { vars = {rsgc.x_mult_1,rsgc.x_mult_2,rsgc.x_mult_1 + rsgc.x_mult_2 * tally} }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            local rsgc = self.config
            local tally = 0
            for k, v in pairs(G.jokers and G.jokers.cards or {}) do
                if RSGC.has_paint(v) then tally = tally + 1 end
            end
            return {
                xmult = rsgc.x_mult_1 + rsgc.x_mult_2 * tally
            }
        end
    end
} 
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
    local type = _card.ability.set
    if (type=='Base' or type == 'Enhanced') then
        paint = poll_paint('paint'..(key_append or '')..G.GAME.round_resets.ante,2,flag,paints)
    end
    if (type=='Joker') then
        paint = poll_paint('paint'..(key_append or '')..G.GAME.round_resets.ante,nil,flag,paints)
    end
    if paint then RSGC.set_paint(_card,paint) end
    return _card
end
-------------------------------------------------------------
----stuff for making paints have their own collection tab----
-------------------------------------------------------------
local function paint_ui()
    local paints = {}

    for k, v in pairs(SMODS.Stickers) do
        if RSGC.is_paint(k) then
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

G.FUNCS.your_collection_rsgc_paints = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
    definition = paint_ui()
    }
end
