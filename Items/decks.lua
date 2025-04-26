SMODS.Back {
	key = "number20",
	unlocked = false,
	atlas = "joke",
	pos = { x = 0, y = 0},
	apply = function(self)
        	G.E_MANAGER:add_event(Event({
            	func = function()
                	for _, card in ipairs(G.playing_cards) do
                		if card:get_id() == 11 then
                  	  		assert(SMODS.change_base(card, nil, "anva_11" ))
                  	  	end
                        if card:get_id() == 12 then
                  	  		assert(SMODS.change_base(card, nil, "anva_12" ))
                  	  	end
                        if card:get_id() == 13 then
                  	  		assert(SMODS.change_base(card, nil, "anva_13" ))
                  	  	end
                        if card:get_id() == 14 then
                  	  		assert(SMODS.change_base(card, nil, "anva_14" ))
                  	  	end
                	end
                return true
           	end
        	}))
    end
}