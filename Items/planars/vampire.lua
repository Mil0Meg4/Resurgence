SMODS.Joker({
	key = "poe",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 10,
	config = { extra = { mult = 4, timer = 0 } },
	pools = {planar = true, vampire = true},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local anv = card.ability.extra
		return {
			vars = { anv.mult, anv.timer },
		}
	end,
	calculate = function(self, card, context)
		local anv = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Hearts") and not context.blueprint then
				if anv.timer >= 2 then
					anv.mult = anv.mult * 2
					anv.timer = 1
				else
					anv.timer = anv.timer + 1
				end
				return {
					mult = card.ability.extra.mult,
				}
			else
				anv.timer = 0
				anv.mult = 4
			end
		end
		if context.after then
			anv.mult = 4
			anv.timer = 0
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Vampire Survivors", ANVA.C.VAMP, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
})

SMODS.Joker({
	key = "pugnala",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 3,
	config = { extra = { xmult = 3 } },
	pools = {planar = true, vampire = true},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	calculate = function(self, card, context)
		local anv = card.ability.extra
		if context.joker_main then
			local suits = ANVA.get_suits(G.play.cards)
			local other_suits = false
			for k, v in pairs(suits) do
				if k ~= "Clubs" and k ~= "Diamonds" and v > 0 then
					other_suits = true
				end
			end
			if not other_suits then
				return { xmult = anv.xmult }
			end
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Vampire Survivors", ANVA.C.VAMP, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
})

SMODS.Joker({
	key = "jandc",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 10,
	config = { extra = { chips = 50, con_slot = 8 } },
	pools = {planar = true, vampire = true},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local anv = card.ability.extra
		return {
			vars = { anv.chips, anv.con_slot },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local anv = card.ability.extra
			local stuff = 0
			local stuff_minus = 0
			stuff_minus = stuff - 4
			for i = 1, #G.consumeables.cards do
				stuff = stuff + 1
			end
			if stuff_minus > 0 then
				return {
					chips = -stuff_minus * anv.chips,
				}
			end
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		local anv = card.ability.extra
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + anv.con_slot
	end,

	remove_from_deck = function(self, card, from_debuff)
		local anv = card.ability.extra
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - anv.con_slot
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Vampire Survivors", ANVA.C.VAMP, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
})

SMODS.Joker({
	key = "sos",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 10,
	config = { extra = { multstack = 15, xmultstack = 1 } },
	pools = {planar = true, vampire = true},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local anv = card.ability.extra
		return {
			vars = { anv.multstack, anv.xmultstack,
			G.jokers and math.max(anv.multstack*(G.jokers.config.card_limit - #G.jokers.cards), 0) or 0,
			(G.jokers and math.max(anv.xmultstack*(G.jokers.config.card_limit - #G.jokers.cards), 0) or 0 ) + 1,
			}
		}
	end,
	calculate = function(self, card, context)
		local anv = card.ability.extra
		if context.joker_main then
			return {
				mult = math.max(anv.multstack*(G.jokers.config.card_limit - #G.jokers.cards), 0),
				xmult = math.max(anv.xmultstack*(G.jokers.config.card_limit - #G.jokers.cards), 0) + 1
			}
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Vampire Survivors", ANVA.C.VAMP, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
})

local gcp = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append, override_equilibrium_effect)
	if
		next(find_joker("j_anva_directer"))
		and not G.GAME.modifiers.cry_equilibrium
		and (_append == "sho" or _type == "Voucher" or _type == "Booster")
	then
		if
			_type ~= "Enhanced"
			and _type ~= "Edition"
			and _type ~= "Back"
			and _type ~= "Tag"
			and _type ~= "Seal"
			and _type ~= "Stake"
		then
			-- we're regenerating the pool every time because of banned keys but it's fine tbh
			P_CRY_ITEMS = {}
			local valid_pools = { "Joker", "Consumeables", "Voucher", "Booster" }
			for _, id in ipairs(valid_pools) do
				for k, v in pairs(G.P_CENTER_POOLS[id]) do
					if
						v.unlocked == true
						and not Cryptid.no(v, "doe", k)
						and not (G.GAME.banned_keys[v.key] or G.GAME.cry_banished_keys[v.key])
					then
						P_CRY_ITEMS[#P_CRY_ITEMS + 1] = v.key
					end
				end
			end
			if #P_CRY_ITEMS <= 0 then
				P_CRY_ITEMS[#P_CRY_ITEMS + 1] = "v_blank"
			end
			return P_CRY_ITEMS, "anva_directer" .. G.GAME.round_resets.ante
		end
	end
	return gcp(_type, _rarity, _legendary, _append)
end

SMODS.Joker({
	key = "directer",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	rarity = "anva_prim",
	cost = 121,
	pools = {planar = true, vampire = true},
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Vampire Survivors", ANVA.C.VAMP, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end
})