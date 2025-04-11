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
        card.paint = val and copy_table(self.config) or nil 
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

ANVA.Paint {
    key = 'paint_blue',
    badge_colour = G.C.CHIPS,
    shader = 'blue',
    weight = 26,
    config = {chips = 40},
    loc_vars = function(self, info_queue, card)
        local anv = self.config or card.paint
        return { vars = { anv.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            return {
                chips = self.config.chips
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
        local anv = self.config or card.paint
        return { vars = { anv.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or (context.main_scoring and context.cardarea == G.play) then
            return {
                mult = self.config.mult
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
        local anv = self.config or card.paint
        return { vars = { anv.dis } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or (context.setting_blind and not card.getting_sliced and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            ease_discard(self.config.dis)
            return {
                message = localize('k_discards'),
                color = G.C.RED,
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
        local anv = self.config or card.paint
        return { vars = { anv.dollars } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea  == G.play) or (context.end_of_round and context.cardarea == G.jokers) then -- checks cards in main scoring phase and jokers in joker area
            return { dollars = self.config.dollars }
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
        local anv = self.config or card.paint
        return { vars = { anv.ret } }
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

--gives cards a random chance of being painted
local orig_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    print("ok")
    local _card = orig_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local paint = nil
    if (_type=='Base' or _type == 'Enhanced') then
        paint = poll_paint('paint'..(key_append or '')..G.GAME.round_resets.ante,2)
    end
    if (_type=='Joker') then
        paint = poll_paint('paint'..(key_append or '')..G.GAME.round_resets.ante)
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
