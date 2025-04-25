SMODS.Joker({
	key = "everything",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	pools = {planar = true, undertale = true},
	rarity = 4,
	cost = 20,
	immutable = true,
	config = {extra = {mult = 21, x_mult = 1.2}},
	unlocked = true,
	discovered = false,
	perishable_compat = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local anv = card.ability.extra
		return {
			vars = { anv.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.scoring_42 or (context.cardarea == G.play and context.individual) then
            local _card = context.other_card
			if _card.base.value == "anva_42" then
                local anv = card.ability.extra
                return {
                    mult = anv.mult,
					xmult = anv.x_mult
                }
			end
		end
	end,
})

local orig_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if next(find_joker("j_anva_everything")) and _type ~= "Base" and _type ~= "Enhanced" and _type ~= "Booster" then
        forced_key = "c_base"
        _type = "Base"
    end
    local card = orig_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    SMODS.change_base(card,nil,"anva_42")
    return card
end