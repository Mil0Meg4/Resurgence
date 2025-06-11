SMODS.Enhancement {
    key = 'alpha',
    atlas = 'enha',
    pos = { x = 0, y = 0 },
    replace_base_card = true,
    config = {extra = {e_mult = 2}},
    loc_vars = function(self, info_queue, card)
		local rsgc = card and card.ability.extra or self.config.extra
		return {
			vars = {rsgc.e_mult},
		}
	end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                emult = card.ability.extra.e_mult
            }
        end
    end,
    weight = 0,
    get_weight = function(self, weight, object_type)
        return 0
    end,
}
SMODS.Enhancement {
    key = 'omega',
    atlas = 'enha',
    pos = { x = 1, y = 0 },
    replace_base_card = true,
    config = {extra = {e_chips = 1.7}},
    loc_vars = function(self, info_queue, card)
		local rsgc = card and card.ability.extra or self.config.extra
		return {
			vars = {rsgc.e_chips},
		}
	end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                echips = card.ability.extra.e_chips
            }
        end
    end,
    weight = 0,
    get_weight = function(self, weight, object_type)
        return 0
    end,
}

local orig_is_suit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if SMODS.has_enhancement(self,"m_rsgc_omega") or SMODS.has_enhancement(self,"m_rsgc_alpha") then
        if suit == "rsgc_greek" then return true end
        return false
    end
    return orig_is_suit(self,suit, bypass_debuff, flush_calc)
end
local orig_get_id = Card.get_id
function Card:get_id()
    if (SMODS.has_no_rank(self) and not self.vampired) or self.base.value == "rsgc_rankless" then
        return -math.random(100, 1000000)
    end
    if SMODS.has_enhancement(self,"m_rsgc_omega") then
        return SMODS.Ranks["rsgc_omega_rank"].id
    elseif SMODS.has_enhancement(self,"m_rsgc_alpha") then
        return SMODS.Ranks["rsgc_alpha_rank"].id
    end
    return orig_get_id(self)
end