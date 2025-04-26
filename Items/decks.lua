SMODS.Back {
	key = "number20",
	unlocked = false,
	atlas = "joke",
	pos = { x = 0, y = 0},
    config = {remove_faces = true},
	apply = function(self)

        G.GAME.starting_params.anva_banned_ranks = {Ace = true}
		G.GAME.high_ranks = true

		local added_ranks = {'anva_11', 'anva_12','anva_13','anva_14','anva_15','anva_16','anva_17','anva_18','anva_19','anva_20'}

		local all_suit = {}

		for k, v in pairs(SMODS.Suits) do
			if type(v) == 'table' and type(v.in_pool) == 'function' and v.in_pool then
				if v:in_pool({initial_deck = true}) then
					all_suit[#all_suit+1] = v.card_key
				end
			else
				all_suit[#all_suit+1] = v.card_key
			end
		end


		local extra_cards = {}

		for i=1, #all_suit do
			for j=1, #added_ranks do
				extra_cards[#extra_cards+1] = {s = all_suit[i], r = added_ranks[j]}
			end
		end

    end,
}