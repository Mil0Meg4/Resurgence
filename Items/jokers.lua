SMODS.Rarity({
	key = "prim",
	badge_colour = G.C.ORANGE,
	pools = {
		["Joker"] = {
			rate = 0.01,      --added which pool its in so it can naturally spawn. mess arround with it 
		},
	},
	default_weight = 0.01,
})

SMODS.Joker({
	key = "sigma",  
	atlas = "wip",  --the atlas obv
	rarity = "anva_prim",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,  --the position in the atlas. x + 1 would be 71 pixels to the right (cause the atlas is set to 71px) and y + 1 would be 95 pixels down (cause the atlas is set to 95px)
	},
	config = {
		extra = {},   
	},
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.config.center.key== "c_hanged_man" then --checks if the used card is hanged man
			print("1")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_high_priestess" then 
			print("2")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_emperor" then 
			print("3")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_emperess" then 
			print("4")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_devil" then 
			print("5")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_moon" then 
			print("5")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_world" then 
			print("6")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_star" then 
			print("7")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_sun" then 
			print("8")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_lovers" then 
			print("9")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_tower" then 
			print("10")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_death" then 
			print("11")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_judgement" then 
			print("12")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_hermit" then 
			print("13")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_temperance" then 
			print("14")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_strength" then 
			print("15")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_wheel_of_fortune" then 
			print("16")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_justice" then 
			print("17")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_heirophant" then 
			print("18")
		elseif context.using_consumeable and context.consumeable.config.center.key== "c_magician" then 
			print("19")
		elseif context.using_consumeable and context.consumeable.ability.set == "Tarot" then --this will activate if the all the above returns false
			print("Tarot Used")
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true   --if this was false this joker wouldnt spawn naturally.
	end,
	set_badges = function(self, card, badges)
		badges[#badges-1] = create_badge("Primer", G.C.ORANGE, G.C.WHITE,1)  --This adds the primer badge ABOVE the rarity. if this was +1 it would add below
	end
})