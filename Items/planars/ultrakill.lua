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
	cost = 3,
	discovered = true,
	calculate = function(self, card, context)
		if context.joker_main then 
			local anv = card.ability.extra
			return{
				mult = anv.mult,
				chips = anv.chips
			}
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Ultrakill", ANVA.C.ULTRA, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
}

SMODS.Joker({
	key = "gaba",
	atlas = "joke",
	rarity = "anva_unb",
	cost = 10,
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
		local anv = card.ability.extra --to avoid typing card.ability.extra each time. Not needed but very handy
		return {
			vars = { anv.xxmult, anv.xxmultg }, --for example in here anv = card.ability.extra. Also this is needed to display the values in the desc of the card
		}
	end,
	calculate = function(self, card, context)
		local anv = card.ability.extra
		if context.joker_main then --checks the usual triggering time for jokers.
			return {
				emult = anv.xxmult, --returns ^anv.xxmult
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
				and G.jokers.cards[rr - 1].edition.anva_divine
			then --In order, checks if there is a joker on the left (rr = our position and -1 being one left), checks if the joker on the left has an edition and checks if its divine
				G.jokers.cards[rr - 1]:set_edition() --removes the edition
				anv.xxmult = anv.xxmult + anv.xxmultg --upgrades xxmult by adding xxmultg
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Ultrakill", ANVA.C.ULTRA, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
})