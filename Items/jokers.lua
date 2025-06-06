function RSGC.Joker(table)
	if table.dependency or table.dependency == nil then
		if table.pools then
			if table.pools.undertale then
				table.set_badges = function(self, card, badges)
					badges[#badges - 1] = create_badge("Undertale", RSGC.C.UNDER, G.C.WHITE, 1)
				end
			end
			if table.pools.hollow then
				table.set_badges = function(self, card, badges)
					badges[#badges - 1] = create_badge("Hollow Knight", RSGC.C.HOLLOW, G.C.WHITE, 1)
				end
			end
			if table.pools.ultrakill then
				table.set_badges = function(self, card, badges)
					badges[#badges - 1] = create_badge("Ultrakill", RSGC.C.ULTRA, G.C.WHITE, 1)
				end
			end
			if table.pools.vampire then
				table.set_badges = function(self, card, badges)
					badges[#badges - 1] = create_badge("Vampire Survivors", RSGC.C.VAMP, G.C.WHITE, 1)
				end
			end
		end
		SMODS.Joker(table)
	end
end

SMODS.Rarity({
	key = "unb",
	badge_colour = RSGC.C.UNBOUND,
	pools = {},
})
SMODS.Rarity({
	key = "super_rare",
	badge_colour = G.C.FILTER,
	default_weight = 0.003,
	pools = { ["Joker"] = true },
})

SMODS.Shader {
    key = 'tree',
    path = 'tree.fs'
}
function RSGC.unbound(card,func)
	G.E_MANAGER:add_event(Event({
		func = function()
			if card.ability.unbound and card.ability.unbound.evo then
				play_sound('tarot2', 1.1, 0.6)
				card:set_ability(G.P_CENTERS["j_rsgc_"..card.ability.unbound.evo])
			else print("No Unbound Field") end
			if func then func(card) end
			return true
		end
	}))
	return {
		message = localize('k_rsgc_unb'),
		focus = card,
		colour = RSGC.C.UNBOUND,
		card = card
	}
end

G.P_CENTERS.j_joker.unbound = {evo = "jimbo"}
RSGC.Joker({
	key = "jimbo",
	atlas = 'joke',
	pos = { x = 0, y = 1 },
	soul_pos = { x = 0, y = 9 },
	rarity = "rsgc_unb",
	cost = 3,
	config = { extra = {mult = 5}},
	unlocked = false,
	discovered = false,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.mult},
		}
	end,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		if context.joker_main then
			return {
				mult = rsgc.mult,
			}
		end
	end
})

--[[ RSGC.Joker({
	key = "long",
	atlas = 'long',
	pos = { x = 0, y = 0 },
	display_size = { w = 71*0.8, h = 757*0.8},
	rarity = 1,
	cost = 10,
	config = { extra = {mult = 5}},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	set_ability = function(self, card, initial,delay_sprites)
		local do_play_sound = true
		G.E_MANAGER:add_event(Event({func = function()
			if not RSGC.is_in_collection(card) then
				RSGC.longlong = true
				RSGC.long_started = G.TIMERS.REAL
				play_sound("rsgc_long")
			end
			return true
		end}))
	end,
}) ]]

function create_UIBox_your_collection_jokers()
  local deck_tables = {}

  G.your_collection = {}
  for j = 1, 3 do
    G.your_collection[j] = CardArea(
      G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
      5*G.CARD_W,
      0.95*G.CARD_H, 
      {card_limit = 5, type = 'title', highlight_limit = 0, collection = true})
    table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.O, config={object = G.your_collection[j]}}
    }}
    )
  end

  local joker_options = {}
  for i = 1, math.ceil(#G.P_CENTER_POOLS.Joker/(5*#G.your_collection)) do
    table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#G.P_CENTER_POOLS.Joker/(5*#G.your_collection))))
  end

  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTER_POOLS["Joker"][i+(j-1)*5]
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
      card.sticker = get_joker_win_sticker(center)
      G.your_collection[j]:emplace(card)
    end
  end

  INIT_COLLECTION_CARD_ALERTS()
  
  local t =  create_UIBox_generic_options({ back_func = 'your_collection', contents = {
        {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
        {n=G.UIT.R, config={align = "cm"}, nodes={
          create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_joker_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        }}
    }})
  return t
end

local orig_draw_shader = Sprite.draw_shader
function Sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
	if self.atlas.name == "rsgc_long" then tilt_shadow = (tilt_shadow or 1)*0.15 end
	return orig_draw_shader(self,_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
end

RSGC.Joker({
	key = "sinclair",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 10,
	config = {
		extra = {
			money = 10,
			max = 100,
			active = false,
		},
	},
	unlocked = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return { vars = { rsgc.money, rsgc.max } }
	end,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		local c = context --i got lazy. This is the same thing as rsgc, just used for "context"
		--[[ if c.end_of_round and context.main_eval and not context.blueprint then
			ease_dollars(rsgc.money) --add money
		end ]]
		if c.starting_shop and to_number(G.GAME.dollars) > rsgc.max and not context.blueprint then --checks entering the shop and compares the ammount of dollars player has with rsgc.max, in this case 100. to_number() is for talisman compatiblity.
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and G.jokers.cards[i].debuff == false then --checks for any card which is NOT THIS CARD and if the cards are debuffed.
					SMODS.debuff_card(G.jokers.cards[i], true, card.config.center.key) --debuffs the cards
					rsgc.active = true --sets active to true. I added this to avoid the cards being undebuffed for no reason when the shop is left with 0 cash or less.
				end
			end
			return {
				message = localize('k_debuffed'),
				colour = G.C.RED,
				card = card
			}
		end
		if c.ending_shop and to_number(G.GAME.dollars) <= 0 and rsgc.active and not context.blueprint  then --checks if the player has left the shop, compares the ammount of dollars player has to 0, and checks if active is true
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and G.jokers.cards[i].debuff == true then --same thing as the one above, but this time checks for debuffed cards
					SMODS.debuff_card(G.jokers.cards[i], false, card.config.center.key) --removes the debuff from debuffed cards
					rsgc.active = false --sets the check as false since it reverted
				end
			end
			return {
				message = localize('k_dedebuffed'),
				colour = G.C.GREEN,
				card = card
			}
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.money
	end,
})

RSGC.Joker({
	key = "tree",
	atlas = "joke",
	pos = { x = 0, y = 0 },
	rarity = 1,
	cost = 4,
	config = { extra = { mult = 3, mult_mod = 2 } },
	unlocked = true,
	discovered = true,
	perishable_compat = false,
	eternal_compat = true,
	blueprint_compat = true,
	unbound = {evo = "tree3",tarots = 0,cards=0,discards=0},
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.mult, rsgc.mult_mod },
		}
	end,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		if context.joker_main then
			return {
				mult = rsgc.mult,
			}
		end
		if (context.end_of_round and context.cardarea == G.jokers) and not context.blueprint then
			rsgc.mult = rsgc.mult + rsgc.mult_mod
			return {
				message = localize('k_tree_grow'),
				colour = G.C.RED,
				card = card
			}
		end
		--------unbound--------
		if context.after and not context.blueprint then
			card.ability.unbound.cards = card.ability.unbound.cards + #G.play.cards
		end
		if context.discard and not context.blueprint then
			card.ability.unbound.discards = card.ability.unbound.discards + 1
		end
		if context.using_consumeable and not context.blueprint then
			card.ability.unbound.tarots = card.ability.unbound.tarots + 1
		end
		if context.after or context.discard or context.using_consumeable and not context.blueprint then
			if card.ability.unbound.tarots >= 33 and card.ability.unbound.discards >= 333 and card.ability.unbound.cards >= 333 then
				return RSGC.unbound(card)
			end
		end
	end,
})

RSGC.Joker({
	key = "tree3",
	atlas = "joke",
	pos = { x = 0, y = 8 },
	rarity = "rsgc_unb",
	cost = 400,
	config = { extra = { eeemult = 3, eeemult_mod = 2 } },
	unlocked = true,
	discovered = true,
	perishable_compat = false,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.eeemult, rsgc.eeemult_mod },
		}
	end,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		if context.joker_main then
			return {
				eeemult = rsgc.eeemult,
			}
		end
		if (context.end_of_round and context.cardarea == G.jokers) and not context.blueprint then
			rsgc.eeemult = rsgc.eeemult + rsgc.eeemult_mod
			return {
				message = localize('k_tree3_grow'),
				colour = G.C.RED,
				card = card
			}
		end
	end,
	draw = function(self, card, layer)
		card.children.center:draw_shader("rsgc_tree", nil, card.ARGS.send_to_shader)
	end,
})

RSGC.Joker({
	key = "bartender",
	atlas = "joke",
	pos = { x = 5, y = 3 },
	rarity = 2,
	cost = 6,
	config = { extra = { mult = 5, con_slot = 1 } },
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		local drinks = G.consumeables and #G.consumeables.cards or 0
		return {
			vars = { rsgc.mult, rsgc.con_slot, rsgc.mult * drinks},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local rsgc = card.ability.extra
			local drinks = #G.consumeables.cards
			return {
				mult = rsgc.mult * drinks,
			}
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		local rsgc = card.ability.extra
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + rsgc.con_slot
	end,

	remove_from_deck = function(self, card, from_debuff)
		local rsgc = card.ability.extra
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - rsgc.con_slot
	end,
})

RSGC.Joker({
	key = "pride_rainbow",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 0,
	},
	pools = {gay = true},
	pride_flag_paints = {any=true},
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_pan",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 4,
	},
	pools = {gay = true},
	pride_flag_paints = {pink=true,yellow=true,cyan=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_bi",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 3,
	},
	pools = {gay = true},
	pride_flag_paints = {red=true,purple=true,blue=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_trans",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 5,
	},
	pools = {gay = true},
	pride_flag_paints = {blue=true,pink=true,white=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_lesbian",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 9,
	},
	pools = {gay = true},
	pride_flag_paints = {orange=true,white=true,purple=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_gay",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 1,
	},
	pools = {gay = true},
	pride_flag_paints = {cyan=true,white=true,blue=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_nb",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 2,
	},
	pools = {gay = true},
	pride_flag_paints = {yellow=true,purple=true,black=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_ace",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 6,
	},
	pools = {gay = true},
	pride_flag_paints = {black=true,white=true,purple=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_aro",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 7,
	},
	pools = {gay = true},
	pride_flag_paints = {green=true,white=true,black=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "pride_aroace",
	atlas = "joke",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 8,
	},
	pools = {gay = true},
	pride_flag_paints = {yellow=true,white=true,blue=true},
	loc_vars = function(self, info_queue, card)
		for k,v in pairs(self.pride_flag_paints) do
			info_queue[#info_queue + 1] = RSGC.paint_tooltip(k)
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return G.GAME.current_pride_flag == self.key
    end,
})

RSGC.Joker({
	key = "triangleJoke",
	atlas = "joke",
	pos = { x = 4, y = 1 },
	pixel_size = { w = 71, h = 73},
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			xmult = 3
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.xmult },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and #G.play.cards == 3 then
			if context.other_card:get_id() == 3 then
				local rsgc = card.ability.extra
				return{
					xmult = rsgc.xmult,
				}
			end
		end
	end,
})

RSGC.Joker({
	key = "godot",
	atlas = "joke",
	pos = { x = 4, y = 0 },
	rarity = 2,
	cost = 7,
	config = {extra = { x_mult = 3,}},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.x_mult},
		}
	end,
	calculate = function(self, card, context)
		if context.other_joker and RSGC.has_tweak(context.other_joker) then
			local rsgc = card.ability.extra
			return {
				xmult = rsgc.x_mult,
				card = card
			}
		end
	end,
})

RSGC.Joker({
	key = "tall_joker",
	atlas = "joke",
	pos = { x = 4, y = 5 },
	rarity = 1,
	cost = 4,
	display_size = { w = 71.0 / 1.3, h = 95 * 1.1 },
	config = {
		extra = {
			chips = 50
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.chips },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_bonus") then
				local rsgc = card.ability.extra
				return{
					chips = rsgc.chips,
				}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_bonus") then return true end --if this was false this joker wouldnt spawn naturally.	
		end
		return false
	end,
})

RSGC.Joker({
	key = "short_joker",
	atlas = "joke",
	pos = { x = 4, y = 6 },
	rarity = 1,
	cost = 4,
	display_size = { w = 71.0 * 1.1, h = 95 / 1.01 },
	config = {
		extra = {
			mult = 10
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_mult") then
				local rsgc = card.ability.extra
				return{
					mult = rsgc.mult,
				}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_bonus") then return true end --if this was false this joker wouldnt spawn naturally.	
		end
		return false
	end,
})

RSGC.Joker({
	key = "swordfish",
	atlas = "joke",
	pos = { x = 4, y = 8 },
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			xmult = 5
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.xmult },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_mult") then
				if context.other_card:is_suit("Spades") then
					if context.other_card:get_id() == 14 then
						local rsgc = card.ability.extra
						return{
							xmult = rsgc.xmult,
						}
					end
				end
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_mult") then return true end --if this was false this joker wouldnt spawn naturally.	
		end
		return false
	end,
})

RSGC.Joker({
	key = "memory",
	atlas = "joke",
	pos = { x = 4, y = 7 },
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i + 1]
				end
			end
			if other_joker and other_joker ~= card and other_joker.config.center.rarity == 1 and other_joker.config.center.blueprint_compat then
				card.ability.blueprint_compat = "compatible"
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,
	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil
		return {
			main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
		}
	end,
	calculate = function(self, card, context)
		local other_joker = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				other_joker = G.jokers.cards[i + 1]
			end
		end
		if other_joker and other_joker ~= card and other_joker.config.center.rarity == 1 then
			context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
			context.blueprint_card = context.blueprint_card or card

			if context.blueprint > #G.jokers.cards + 1 then
				return
			end

			local other_joker_ret, trig = other_joker:calculate_joker(context)
			local eff_card = context.blueprint_card or card

			context.blueprint = nil
			context.blueprint_card = nil

			if other_joker_ret == true then
				return other_joker_ret
			end
			if other_joker_ret or trig then
				if not other_joker_ret then
					other_joker_ret = {}
				end
				other_joker_ret.card = eff_card
				other_joker_ret.colour = G.C.FILTER
				other_joker_ret.no_callback = true
				return other_joker_ret
			end
		end
	end,
})

RSGC.Joker({
	key = "catJoker",
	atlas = "joke",
	pos = { x = 4, y = 9 },
	pools = {gay = true},
	rarity = 3,
	cost = 7,
	config = {
		extra = {
			retrigger_amount = 1
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.retrigger_amount },
		}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 3 then
				local rsgc = card.ability.extra
				local current_retrigger_count = 0
				for i, _card in pairs(G.hand.cards) do
					if _card:get_id() == 3 then
						current_retrigger_count = current_retrigger_count + rsgc.retrigger_amount
					end
				end
				return{
					repetitions = current_retrigger_count
				}
			end
		end
	end,
})

RSGC.Joker({
	key = "frankenjoker",
	atlas = "joke",
	pos = { x = 5, y = 0 },
	rarity = 1,
	cost = 4,
	display_size = { w = 71.0 * 1.021, h = 95 * 1.021 },
	config = {
		extra = {
			chipsgained = 10,
			multgained = 2
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.chipsgained, rsgc.multgained },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_wild") then
				local rsgc = card.ability.extra
				local poll = pseudorandom('frankenpoll')
				local color = nil
				if poll < 1/2 then
					context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
					context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + rsgc.chipsgained
					color = G.C.CHIPS
				else
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + rsgc.multgained
					color = G.C.MULT
				end
                return {
                    message = localize('k_upgrade_ex'),
					colour = color,
                    card = card
                }
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_wild") then return true end --if this was false this joker wouldnt spawn naturally.	
		end
		return false
	end,
})

RSGC.Joker({
	key = "punker",
	atlas = "joke",
	pos = { x = 5, y = 1 },
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			multgained = 6,
			multgainedsteel = 12,
			currentmult = 0
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = false,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		local rsgc = card.ability.extra
		return {
			vars = { rsgc.multgained, rsgc.multgainedsteel, rsgc.currentmult },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local rsgc = card.ability.extra
			return {
				mult = rsgc.currentmult,
			}
		end
		if context.individual and context.cardarea == G.play and not context.blueprint then
			local rsgc = card.ability.extra
			local currentincrease = rsgc.multgained
			if SMODS.has_enhancement(context.other_card, "m_mult") then
				for i, _card in pairs(G.hand.cards) do
					if SMODS.has_enhancement(_card, "m_steel") then
						currentincrease = rsgc.multgainedsteel
					end
				end
				rsgc.currentmult = rsgc.currentmult + currentincrease
				return {
                    message = localize('k_upgrade_ex'),
					colour = G.C.RED,
                    card = card
                }
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_mult") then return true end --if this was false this joker wouldnt spawn naturally.	
		end
		return false
	end,
})


RSGC.Joker({
	key = "kai",
	atlas = "joke",
	pos = { x = 5, y = 4 },
	rarity = 3,
	cost = 10,
	config = {
		extra = {
			mult_chips = 2,
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
			local rsgc = card.ability.extra
			local tally = G.GAME and G.GAME.hands.Pair.played or 0
			return {
			vars = { rsgc.mult_chips, tally * rsgc.mult_chips},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local rsgc = card.ability.extra

			return {
				mult = rsgc.mult_chips * G.GAME.hands.Pair.played,
				chips = rsgc.mult_chips * G.GAME.hands.Pair.played
			}
		end
	end
})

RSGC.Joker({
	key = "kate",
	atlas = "joke",
	pos = { x = 1, y = 1 },
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			chips = 10
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local rsgc = card.ability.extra
		local tally = G.GAME and G.GAME.hands.Straight.played or 0
		return {vars = { rsgc.chips, tally * rsgc.chips},
	}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local rsgc = card.ability.extra
			return {
				chips = rsgc.chips * G.GAME.hands.Straight.played
			}
		end
	end
})

RSGC.Joker({
	key = "42wallbreak",
	atlas = "joke",
	pos = { x = 1, y = 1 },
	rarity = 3,
	cost = 19,
	config = {
		extra = {
			retriggers = 2
		},
	},
	unlocked = true,
	discovered = true,
	perishable_compat = true,
	eternal_compat = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
		local rsgc = card.ability.extra
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == SMODS.Ranks["rsgc_42"].id then
				return {
					repetitions = rsgc.retriggers
				}
			end
		end
	end
})

--Boosters
SMODS.Booster({
    key = 'gay',
    atlas = 'booster',
    kind = "gay",
	pos = { x = 0, y = 1 },
    config = {choose = 1, extra = 4,gay_pack = true},
    cost = 6,
    weight = 0.08,
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
		local legend = {"j_rsgc_gabriel","j_rsgc_alphys"}
		local pollable_legends = {}
		for i,v in ipairs(legend) do 
			if G.P_CENTERS[v] and not (G.GAME.used_jokers[v] and not next(find_joker("Showman"))) then 
				table.insert(pollable_legends,v)
			end
		end
		if #pollable_legends > 0 then
			if pseudorandom("gay_" .. G.GAME.round_resets.ante) > 0.995 then
				local poll = pseudorandom_element(pollable_legends,pseudoseed('gay_af'))
				return create_card("gay", G.pack_cards, nil, nil, true, true, poll, nil)
			end
		end
        return create_card("gay", G.pack_cards, nil, nil, true,  true, nil, "gay_pack")
    end,
    ease_background_colour = function(self)
        --ease_colour(G.C.DYN_UI.MAIN, RSGC.C.GAY)
        ease_background_colour{new_colour = RSGC.C.GAY, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_rsgc_gay',
    draw_hand = false,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.4,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {RSGC.C.GAY, lighten(RSGC.C.GAY, 0.4), lighten(RSGC.C.GAY, 0.2), darken(RSGC.C.GAY, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})



