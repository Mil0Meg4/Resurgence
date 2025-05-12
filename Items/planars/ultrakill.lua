SMODS.Joker {
	key = 'filth',
	config = { 
	  extra = {chips = 10, mult = 2} },
	pools = {planar = true, ultrakill = true},
	rarity = 1,
	atlas = 'joke',
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 0, y = 1 },
	cost = 1,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra --to avoid typing card.ability.extra each time. Not needed but very handy
		return {
			vars = { rsgc.chips, rsgc.mult }, --for example in here rsgc = card.ability.extra. Also this is needed to display the values in the desc of the card
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then 
			local rsgc = card.ability.extra
			return{
				mult = rsgc.mult,
				chips = rsgc.chips
			}
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Ultrakill", RSGC.C.ULTRA, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
}

SMODS.Joker({
	key = "gaba",
	atlas = "joke",
	rarity = "rsgc_unb",
	cost = 16,
	unlocked = true,
	discovered = false,
	perishable_compat = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 1,
	},
	config = {
		extra = {
			xxmult = 1.25, --mult value to return
			xxmultg = 0.75, --to increase
		},
	},
	pools = {planar = true, ultrakill = true},
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra --to avoid typing card.ability.extra each time. Not needed but very handy
		return {
			vars = { rsgc.xxmult, rsgc.xxmultg }, --for example in here rsgc = card.ability.extra. Also this is needed to display the values in the desc of the card
		}
	end,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		if context.joker_main then --checks the usual triggering time for jokers.
			return {
				emult = rsgc.xxmult, --returns ^rsgc.xxmult
			}
		end
		if context.ending_shop and not context.blueprint then --Checks for when the shop ends and if its going to be triggered by blueprint or not
			local rr = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then --for checking the position of other jokers
					rr = i
					break
				end
			end
			if
				G.jokers.cards[rr - 1] ~= nil
				and G.jokers.cards[rr - 1].edition
				and G.jokers.cards[rr - 1].edition.rsgc_divine
			then --In order, checks if there is a joker on the left (rr = our position and -1 being one left), checks if the joker on the left has an edition and checks if its divine
				G.jokers.cards[rr - 1]:set_edition() --removes the edition
				rsgc.xxmult = rsgc.xxmult + rsgc.xxmultg --upgrades xxmult by adding xxmultg
				return {
					message = localize("k_upgrade_ex"),
					colour = G.C.RED
				}
			end
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Ultrakill", RSGC.C.ULTRA, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
})
SMODS.Joker({
	key = "gabriel",
	atlas = "joke",
	pos = { x = 0, y = 1 },
	rarity = 4,
	cost = 8,
	config = {
		extra = {
			xmult = 1.5
		},
	},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pools = {planar = true, ultrakill = true},
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.xmult },
		}
	end,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		if context.other_joker then
			if context.other_joker.edition then
				if context.other_joker.edition.rsgc_divine then
			return {
				xmult = rsgc.xmult,
				card = card
			}
		end
	end
		end
		if context.ending_shop and not context.blueprint then
			local rr = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					rr = i
					break
				end
			end
			if G.jokers.cards[rr - 1] ~= nil then
				G.jokers.cards[rr - 1]:set_edition({ rsgc_divine = true }, true)
			end
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Ultrakill", RSGC.C.ULTRA, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
})
SMODS.Joker {
	key = 'v1',
	config = { 
	extra = {xred = 2, xredgain = 1, steelcardscorereq = 3, steelcardscored = 0} },
	pools = {planar = true, ultrakill = true},
	rarity = 4,
	atlas = 'joke',
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 0, y = 1 },
	cost = 20,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra --to avoid typing card.ability.extra each time. Not needed but very handy
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		return {
			vars = { rsgc.xred, rsgc.xredgain, rsgc.steelcardscorereq,rsgc.steelcardscored }, --for example in here rsgc = card.ability.extra. Also this is needed to display the values in the desc of the card
		}
	end,
	
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			if SMODS.has_enhancement(context.other_card,'m_steel') then
				local rsgc = card.ability.extra
				rsgc.steelcardscored = rsgc.steelcardscored + 1
				if rsgc.steelcardscored >= rsgc.steelcardscorereq then
					rsgc.steelcardscored = 0
					RSGC.update_add_to_deck(card, function(card)
					local rsgc = card.ability.extra
					rsgc.xred = rsgc.xred + rsgc.xredgain
					return end)
				end
				return{
					message = (rsgc.steelcardscored == 0) and localize('k_upgrade_ex') or (rsgc.steelcardscored..'/'..rsgc.steelcardscorereq),
					colour = G.C.FILTER,
					card = card
				}
			end
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		for k, v in pairs(SMODS.Stickers) do
			if k == "rsgc_paint_red" then
				RSGC.mod_table_values(v.config,nil,{mult = card.ability.extra.xred})
			end
		end
	end,

	remove_from_deck = function(self, card, from_debuff)
		for k, v in pairs(SMODS.Stickers) do
			if k == "rsgc_paint_red" then
				RSGC.mod_table_values(v.config,nil,{mult = 1/card.ability.extra.xred})
			end
		end
	end,

	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Ultrakill", RSGC.C.ULTRA, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
}
