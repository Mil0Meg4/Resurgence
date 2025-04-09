--tweaks are just stickers with a different name code wise
ANVA.Tweak = SMODS.Sticker:extend {
    prefix_config = { key = true },
    should_apply = false,
    config = {},
    rate = 0,
    sets = {
        Default = true
    },

    draw = function(self, card)
        local x_offset = (card.T.w / 71) * card.T.scale
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, x_offset)
    end,

    apply = function(self, card, val)
        card.ability[self.key] = val and copy_table(self.config) or nil
    end
}

--table with all the tweaks' keys, needed for distinguishing them from stickers
--when creating a new tweak always add it here
ANVA.Tweaks_keys = {
    "lever",
    "rubber",
}

ANVA.Tweak {
    key = 'rubber',
    atlas = 'wip',
    pos = { x = 0, y = 0 },
    badge_colour = G.C.CHIPS,
    calculate = function(self,card,context)
        if context.selling_self then--checks if the joker is being sold
			card.ability.extra.selling = true
		end
        if context.anva_destroyed and context.card == card and not card.ability.extra.selling then--checks if the jokers is destroyed but not sold
            --creates a copy of the joker
            local copy = copy_card(card, nil, nil, nil, nil)
            copy:start_materialize()
            copy:add_to_deck()
            G.jokers:emplace(copy)
            return nil,true
        end
    end
}
ANVA.Tweak {
    key = 'lever',
    atlas = 'wip',
    pos = { x = 0, y = 0 },
    badge_colour = G.C.CHIPS,
    config = {increase = 1.1, reset_rate = 0.5, threshold_rate = 2,},
    loc_vars = function(self, info_queue, card)
		local anv = self.config
		return {
			vars = { anv.increase, anv.threshold_rate, anv.reset_rate, },
		}
	end,
    calculate = function(self,card,context)
        if context.reroll_shop and not card.config.center.immutable then--checks if rerolling
            ANVA.mod_table_values(card.ability,card.ability.anva_lever,{mult = self.config.increase},nil,{anva_lever = true},true)--modifies all values
        end
        if context.end_of_round and G.GAME.blind.boss and not context.other_card and not card.config.center.immutable then
            --I'm not explaining all of this, just know that this resets the values after they surpass the threshold
            local function reset_values(table,thr)
                for k, v in pairs(table) do
                    if type(v) == "number" then
                        if thr and thr[k] and type(thr[k]) == "number" and v >= thr[k] * self.config.threshold_rate then
                            table[k] = thr[k] * self.config.reset_rate
                        end 
                    elseif type(v) == "table" and k and type(thr[k]) == "table" then
                        reset_values(v,thr[k])
                    end
                end
            end
            reset_values(card.ability,card.ability.anva_lever)
        end
    end,
    apply = function(self, card, val)--called when applying the tweak or sticker
        card.ability[self.key] = val--applies the sticker manually since `apply` overwrites the original function
        card.ability.anva_lever = copy_table(card.ability)--saves the values to know when to reset them
    end
}

SMODS.current_mod.custom_collection_tabs = function()
    return {
        UIBox_button({
        button = 'your_collection_anva_tweaks',
        id = 'your_collection_anva_tweaks',
        label = { localize('anva_tweak_ui') },
        minw = 5,
        minh = 1
        })
    }
end

-------------------------------------------------------------
----stuff for making tweaks have their own collection tab----
-------------------------------------------------------------
local function tweak_ui()
    local tweaks = {}

    for k, v in pairs(SMODS.Stickers) do
        if ANVA.is_tweak(k) then
        tweaks[k] = v
        end
    end

    return SMODS.card_collection_UIBox(tweaks, { 5, 5 }, {
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

G.FUNCS.your_collection_anva_tweaks = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
    definition = tweak_ui()
    }
end

local function wrap_without_tweaks(func)
    local removed = {}
    for k, v in pairs(SMODS.Stickers) do
        if ANVA.is_tweak(k) then
        removed[k] = v
        SMODS.Stickers[k] = nil
        end
    end

    local ret = func()

    for k, v in pairs(removed) do
        SMODS.Stickers[k] = v
    end

    return ret
end

local stickers_ui_ref = create_UIBox_your_collection_stickers
create_UIBox_your_collection_stickers = function()
    return wrap_without_tweaks(stickers_ui_ref)
end

local other_objects_ref = create_UIBox_Other_GameObjects
create_UIBox_Other_GameObjects = function()
    return wrap_without_tweaks(other_objects_ref)
end
