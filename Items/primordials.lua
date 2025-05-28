SMODS.Rarity({
	key = "prim",
	badge_colour = RSGC.C.PRIMORDIAL,
	pools = {},
})
--[[ function RSGC.literally_me_fr(card,joker_key)
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound('tarot2', 1.1, 0.6)
            card:set_ability(G.P_CENTERS["j_rsgc_"..joker_key])
            return true
        end
    }))
    return {
        message = localize('k_rsgc_prim'),
        colour = RSGC.C.PRIMORDIAL,
        card = card
    }
end

RSGC.Joker({
	key = "sigma",
	atlas = "joke", --the atlas obv
	rarity = "rsgc_prim",
	cost = 15,
	unlocked = true,
	discovered = false,
	eternal_compat = false,
	perishable_compat = false,
	blueprint_compat = false, --If this is true, blueprint will say "Compatible"
	pos = {
		x = 0,
		y = 2, --the position in the atlas. x + 1 would be 71 pixels to the right (cause the atlas is set to 71px) and y + 1 would be 95 pixels down (cause the atlas is set to 95px)
	},
	soul_pos = {x = 0, y = 3},
	config = {
		extra = {},
	},
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.using_consumeable and context.consumeable.config.center.key == "c_hanged_man" then --checks if the used card is hanged man
				print("1")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_high_priestess" then
				print("2")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_emperor" then
				print("3")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_emperess" then
				print("4")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_devil" then
				print("5")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_moon" then
				print("5")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_world" then
				print("6")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_star" then
				return RSGC.literally_me_fr(card,"andromeda")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_sun" then
				print("8")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_lovers" then
				return RSGC.literally_me_fr(card,"sappho")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_tower" then
				return RSGC.literally_me_fr(card,"doom")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_death" then
				return RSGC.literally_me_fr(card,"tiataxet")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_judgement" then
				print("12")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_hermit" then
				return RSGC.literally_me_fr(card,"charon")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_temperance" then
				print("14")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_strength" then
				print("15")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_wheel_of_fortune" then
				print("16")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_justice" then
				print("17")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_heirophant" then
				print("18")
			elseif context.using_consumeable and context.consumeable.config.center.key == "c_magician" then
				print("19")
			elseif context.using_consumeable and context.consumeable.ability.set == "Tarot" then --this will activate if the all the above returns false
				print("Tarot Used")
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true --if this was false this joker wouldnt spawn naturally.
	end,
	set_badges = function(self, card, badges)
		badges[#badges - 1] = create_badge("Primer", G.C.ORANGE, G.C.WHITE, 1) --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end,
})
]]
RSGC.Joker({
	key = "charon",
	atlas = "joke",
	rarity = "rsgc_prim",
	cost = 50,
	unlocked = true,
	discovered = false,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 4,
	},
	soul_pos = {x = 0, y = 5},
	config = {
		extra = {
			max = 2000, --maximum value as variable
		},
	},
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.max },
		}
	end,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		if context.ending_shop then
			--ease_dollars(to_number(math.max(0, math.min(G.GAME.dollars * 5, rsgc.max)), true))---ease_dollars is used to manipulate the ammount of cash you have, to_number is for talisman compatiblity and math.max is used to set the max value for the added cash
			return {
				dollars = to_number(math.max(0, math.min(G.GAME.dollars * 4, rsgc.max))),
			}
		end
	end,
})
RSGC.Joker({
	key = "tiataxet",
	atlas = "joke",
	rarity = "rsgc_prim",
	cost = 50,
	unlocked = true,
	discovered = false,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	soul_pos = {x = 0, y = 0},
	calculate = function(self, card, context)
        local rank = {}
        local suit = {}
        local edit = {}
        local enha = {}
        local seal = {}
        local paint = {}
		if context.after then
			for i=1, #G.hand.cards do
                local c = G.hand.cards[i]
                rank[c.config.card.value] = (rank[c.config.card.value] or 0) + 1
                suit[c.base.suit] = (suit[c.base.suit] or 0) + 1
                if c.edition then edit[c.edition.key] = (edit[c.edition.key] or 0) + 1 end
                if c.config.center.key ~= "c_base" then enha[c.config.center.key] = (enha[c.config.center.key] or 0) +1 end
                if c.seal then seal[c.seal] = (seal[c.seal] or 0) + 1 end
                if RSGC.has_paint(c) then paint[RSGC.has_paint(c)] = (paint[RSGC.has_paint(c)] or 0) + 1 end
            end
            local last_number = 0
            local ra = nil
            for k,v in pairs(rank) do
                if v > last_number then
                    last_number = v
                    ra = k
                elseif v == last_number and v ~= 0 and pseudorandom("tia") < 0.5 then
                    ra = k
                end
            end
            last_number = 0
            local su = nil
            for k,v in pairs(suit) do
                if v > last_number then
                    last_number = v
                    su = k
                elseif v == last_number and v ~= 0 and pseudorandom("tia") < 0.5 then
                    su = k
                end
            end
            last_number = 0
            local e = nil
            for k,v in pairs(edit) do
                if v > last_number then
                    last_number = v
                    e = k
                elseif v == last_number and v ~= 0 and pseudorandom("tia") < 0.5 then
                    e = k
                end
            end
            last_number = 0
            local a = nil
            for k,v in pairs(enha) do
                if v > last_number then
                    last_number = v
                    a = k
                elseif v == last_number and v ~= 0 and pseudorandom("tia") < 0.5 then
                    a = k
                end
            end
            last_number = 0
            local s = nil
            for k,v in pairs(seal) do
                if v > last_number then
                    last_number = v
                    s = k
                elseif v == last_number and v ~= 0 and pseudorandom("tia") < 0.5 then
                    s = k
                end
            end
            last_number = 0
            local p = nil
            for k,v in pairs(paint) do
                if v > last_number then
                    last_number = v
                    p = k
                elseif v == last_number and v ~= 0 and pseudorandom("tia") < 0.5 then
                    p = k
                end
            end
			for i=1, #G.hand.cards do
				local c = G.hand.cards[i]
				local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function() c:flip();
					play_sound('card1', percent);
					c:juice_up(0.3, 0.3);
				return true end }))
			end
            for i=1, #G.hand.cards do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    local c = G.hand.cards[i]
                    SMODS.change_base(c,su,ra)
                    if e then c:set_edition(e) end
                    if a then c:set_ability(G.P_CENTERS[a]) end
                    if s then c:set_seal(s) end
                    if p then RSGC.set_paint(c,string.sub(p,12)) end
                return true end }))
            end
			for i=1, #G.hand.cards do
				local c = G.hand.cards[i]
				local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function() c:flip();
					play_sound('tarot2', percent, 0.6);c:
					juice_up(0.3, 0.3);
				return true end }))
			end
		end
	end,
})
RSGC.Joker({
	key = "andromeda",
	atlas = "joke",
	rarity = "rsgc_prim",
	cost = 50,
	unlocked = true,
	discovered = false,
	pos = {x = 4,y = 2},
	soul_pos = {x = 4,y = 3,top = {x = 4,y = 4,no_shadow = true}},
	config = {extra = {cost_increase = 25}},
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_star
		local rsgc = card.ability.extra
		return {vars = {rsgc.cost_increase}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.other_card:is_suit("Diamonds") and context.cardarea == G.play then
			local rsgc = card.ability.extra
			G.E_MANAGER:add_event(Event({
				func = function()
					if #G.consumeables.cards < G.consumeables.config.card_limit then
						play_sound('tarot2', 1.1, 0.6)
						local new_card = SMODS.add_card({
							key = "c_star",
							area = G.consumeables,
						})
					end
					for k, v in ipairs(G.consumeables.cards) do
                        if v.set_cost then 
                            v.ability.extra_value = (v.ability.extra_value or 0) + rsgc.cost_increase
                            v:set_cost()
                        end
                    end
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
		end
	end,
})
function RSGC.nonstone()
	local bb = #G.playing_cards
	if G.playing_cards then
		for _, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_stone") then
				bb = bb - 1
			end
		end
		return bb
	end
	return #G.playing_cards
end
RSGC.Joker({
	key = "doom",
	atlas = "joke",
	rarity = "rsgc_prim",
	cost = 10,
	unlocked = true,
	discovered = false,
	pos = {
		x = 0,
		y = 6,
	},
	soul_pos = {x = 0, y = 7},
	config = {
		extra = {
			chips = 125000,
			chips2 = 2500000
		},
	},
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.chips,rsgc.chips2 },
		}
	end,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		if context.joker_main then
			if RSGC.nonstone() > 0 then
				return{
					chips = rsgc.chips,
				}
			else
				return{
					chips = rsgc.chips2,
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card,"m_stone") then
				local cards = {}
				for i = 1, #G.playing_cards do
					if G.playing_cards[i].area ~= G.hand and G.playing_cards[i].area ~= G.play and G.playing_cards[i].ability.effect ~= "Stone Card" then
						cards[#cards + 1] = G.playing_cards[i]
					end
				end
				--print(#cards)
				G.E_MANAGER:add_event(Event({
					func = function()
						if #cards > 0 then
							local card2 = pseudorandom_element(cards, pseudoseed("doom"))
							if card2 then card2:start_dissolve({ HEX("57ecab") }, nil, 0.1) end
							card2 = nil
						end
						return true
					end,
				}))
			end
		end
	end,
})
