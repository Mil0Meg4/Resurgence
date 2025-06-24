SMODS.ConsumableType({
    key = "Junk",
    primary_colour = RSGC.C.AUGMENT,
    secondary_colour = RSGC.C.AUGMENT,
    collection_rows = {4, 3},
    shop_rate = 0,
    default = 'c_rsgc_junk_sandwich'
})
SMODS.UndiscoveredSprite({
    key = "Junk",
    atlas = "aug",
    pos = { x = 0, y = 0 },
    no_overlay = true
})
SMODS.Consumable({
    key = 'junk_sandwich',
    set = 'Junk',
    atlas = 'aug',
    pos = {x=0, y=0},
    discovered = true,
    config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
		local rsgc = self.config
        return (rsgc.max_highlited)
    end,
    can_use = function(self, card)
		return #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1
	end,
    use = function(self, card, area, copier)
for _, v in ipairs(G.hand.highlighted) do
	G.E_MANAGER:add_event(Event({
	trigger = 'after',
	delay = 0.15,
	func = function() v:flip();
	play_sound('card1', 0.8);
	v:juice_up(0.3, 0.3);
	return true end }))
	end
		for _, v in ipairs(G.hand.highlighted) do
            	SMODS.change_base(v,nil,"rsgc_42")
        end
			for _, v in ipairs(G.hand.highlighted) do
	  	 		G.E_MANAGER:add_event(Event({
	   	    	trigger = 'after',
	        	delay = 0.15,
	 	       	func = function() v:flip();
	        	play_sound('tarot2', 0.8, 0.6);
	        	v:juice_up(0.3, 0.3);
	        return true end }))
			end
    end,
    in_pool = function(self, wawa, wawa2)
		return false
	end
})