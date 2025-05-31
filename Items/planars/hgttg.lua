RSGC.Joker({
	key = "everything",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	pools = {planar = true, hgttg = true},
	rarity = 4,
	cost = 20,
	immutable = true,
	config = {extra = {mult = 21, x_mult = 1.2}},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.mult,rsgc.x_mult },
		}
	end,
	calculate = function(self, card, context)
		if context.scoring_42 or (context.cardarea == G.play and context.individual) then
            local _card = context.other_card
			if _card.base.value == "rsgc_42" then
                local rsgc = card.ability.extra
                return {
                    mult = rsgc.mult,
					xmult = rsgc.x_mult
                }
			end
		end
	end,
})

local orig_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local is_42 = false
    if next(find_joker("j_rsgc_everything")) and _type ~= "Booster" then
		if _type ~= "Base" and _type ~= "Enhanced" then
			forced_key = "c_base"
			_type = "Base"
		end
		is_42 = true
    end
    local card = orig_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if is_42 then SMODS.change_base(card,nil,"rsgc_42") end
    return card
end