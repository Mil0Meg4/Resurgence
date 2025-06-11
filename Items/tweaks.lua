--tweaks are just stickers with a different name code wise
RSGC.Tweak = SMODS.Sticker:extend {
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
RSGC.Tweaks_keys = {
    "mother",
    "lever",
    "rubber",
    "gilded",
}

RSGC.Tweak {
    key = 'rubber',
    atlas = 'aug',
    pos = { x = 1, y = 0 },
    badge_colour = G.C.CHIPS,
    calculate = function(self,card,context)
        if context.selling_self then--checks if the joker is being sold
			card.ability.selling = true
		end
    end
}
RSGC.Tweak {
    key = 'mother',
    atlas = 'aug',
    pos = { x = 1, y = 0 },
    badge_colour = G.C.CHIPS,
    config = {valuesetto = 1,},
    loc_vars = function(self, info_queue, card)
		local rsgc = self.config
		return {
			vars = { rsgc.valuesetto, },
		}
	end,
    calculate = function(self,card,context)
        if context.ending_shop and not card.config.center.immutable then
            RSGC.mod_table_values(card.ability,nil,{set = self.config.valuesetto},nil,{rsgc_mother = true},false)--modifies all values
        end
    end
}
RSGC.Tweak {
    key = 'lever',
    atlas = 'aug',
    pos = { x = 1, y = 0 },
    badge_colour = G.C.CHIPS,
    config = {rate = 1, increase = 0.1, threshold = 2},
    loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.rsgc_lever or self.config
		return {
			vars = {rsgc.rate, rsgc.increase, rsgc.threshold},
		}
	end,
    calculate = function(self,card,context)
        if context.after and not card.config.center.immutable then--checks if rerolling
            local rsgc = card.ability.rsgc_lever
            RSGC.mod_table_values(card.ability,nil,{mult = 1/rsgc.rate},nil)
            rsgc.rate = rsgc.rate + rsgc.increase
            RSGC.mod_table_values(card.ability,nil,{mult = rsgc.rate},nil)
            return {
                message = localize('k_upgrade_ex'),
                focus = card,
                card = card
            }
        end
        if context.end_of_round and G.GAME.blind.boss and not context.other_card and not card.config.center.immutable then
            local rsgc = card.ability.rsgc_lever
            if rsgc.rate >= rsgc.threshold then
                RSGC.mod_table_values(card.ability,nil,{mult = 1/rsgc.rate},nil)
                rsgc.rate = 1
                return {
                    message = localize('k_reset'),
                    focus = card,
                    card = card
                }
            end
        end
    end,
}
RSGC.Tweak {
    key = 'gilded',
    atlas = 'aug',
    pos = { x = 1, y = 0 },
    badge_colour = G.C.CHIPS,
    config = {dollars = 3},
    loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.rsgc_lever or self.config
		return {
			vars = {rsgc.dollars},
		}
	end,
}

local orig_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context)
    local ret = orig_calculate_joker(self,context)
    if ret and self.ability.rsgc_gilded then
        ret.gilded = self.ability.rsgc_gilded.dollars
    end
    return ret
end

local orig_calculate_individual_effect = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if not effect.gilded then return orig_calculate_individual_effect(effect, scored_card, key, amount, from_edition) end
    if (key == "mult"
    or key == "chips"
    or key == "mult_mod"
    or key == "chip_mod")
    and amount ~= 0 and (mult or hand_chips)
    then
        key = "dollars"
        amount = effect.gilded
    end
    if key == "message"
    and (effect.mult_mod
    or effect.chip_mod)
    then
        return false
    end
    return orig_calculate_individual_effect(effect, scored_card, key, amount, from_edition)
end

-------------------------------------------------------------
----stuff for making tweaks have their own collection tab----
-------------------------------------------------------------
local function tweak_ui()
    local tweaks = {}

    for k, v in pairs(SMODS.Stickers) do
        if RSGC.is_tweak(k) then
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

G.FUNCS.your_collection_rsgc_tweaks = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
    definition = tweak_ui()
    }
end

