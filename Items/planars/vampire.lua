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
			vars = { anv.multstack, anv.xmultstack },
		}
	end,
	calculate = function(self, card, context)
		local anv = card.ability.extra
		local maxboost = 5
		if context.joker_main then
			return {
				mult = math.max(anv.multstack*(G.jokers.config.card_limit - #G.jokers.cards), 0),
				xmult = math.max(anv.xmultstack*(G.jokers.config.card_limit - #G.jokers.cards), 1)
			}
			end
		end,
		set_badges = function(self, card, badges)
			badges[#badges - 1] = create_badge("Vampire Survivors", ANVA.C.VAMP, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
		end,
})