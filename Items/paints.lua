--paints are just stickers with a different name code wise
ANVA.Paint = SMODS.Sticker:extend {
    prefix_config = { key = true },
    should_apply = false,
    config = {},
    rate = 0,
    sets = {
        Default = true
    },

    draw = function(self, card)
        card.children.center:draw_shader(self.shader or 'foil', nil, card.ARGS.send_to_shader)
    end,

    apply = function(self, card, val)
        card.ability[self.key] = val and copy_table(self.config) or nil
        card.paint = val and copy_table(self.config) or nil
    end
}

--table with all the paints' keys, needed for distinguishing them from stickers
--when creating a new paint always add it here
ANVA.Paint_keys = {
    "red",
    "blue",
}

SMODS.Shader {
    key = 'red',
    path = 'red.fs'
}
SMODS.Shader {
    key = 'blue',
    path = 'blue.fs'
}

ANVA.Paint {
    key = 'paint_red',
    badge_colour = G.C.RED,
    shader = 'red',
    config = {mult = 8},
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.mult } }
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                mult = self.config.mult
            }
        end
    end
}
ANVA.Paint {
    key = 'paint_blue',
    badge_colour = G.C.CHIPS,
    shader = 'blue',
    config = {chips = 40},
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.chips } }
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                chips = self.config.chips
            }
        end
    end
}
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
