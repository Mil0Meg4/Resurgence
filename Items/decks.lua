SMODS.Back {
	key = "number20",
	unlocked = false,
	atlas = "joke",
	pos = { x = 0, y = 0},
    config = {remove_faces = true},
	apply = function(self)
        G.GAME.starting_params.rsgc_banned_ranks = {Ace = true}
		G.GAME.macro_ranks = true
    end,
}