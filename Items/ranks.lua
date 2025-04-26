
--42
SMODS.Rank {

    key = '42',
    card_key = '42',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 0 },

    next = { 'anva_42' },
	prev = { 'anva_42' },

    nominal = 42,
    shorthand = '42',
    hidden = true,

	in_pool = function(self, args)
        return false
    end
}

table.insert(SMODS.Ranks['10'].next, 'anva_11')--add 11 after 10
--11
SMODS.Rank {

    key = '11',
    card_key = '11',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 1 },

    next = { 'anva_12' },
	prev = { '10' },

    nominal = 11,
    shorthand = '11',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}
--12
SMODS.Rank {

    key = '12',
    card_key = '12',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 2 },

    next = { 'anva_13' },
	prev = { 'anva_11' },

    nominal = 12,
    shorthand = '12',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}

--13
SMODS.Rank {

    key = '13',
    card_key = '13',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 3 },

    next = { 'anva_14' },
	prev = { 'anva_12' },

    nominal = 13,
    shorthand = '13',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}

--14
SMODS.Rank {

    key = '14',
    card_key = '14',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 4 },

    next = { 'anva_15' },
	prev = { 'anva_13' },

    nominal = 14,
    shorthand = '14',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}

--15
SMODS.Rank {

    key = '15',
    card_key = '15',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 5 },

    next = { 'anva_16' },
	prev = { 'anva_14' },

    nominal = 15,
    shorthand = '15',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}

--16
SMODS.Rank {

    key = '16',
    card_key = '16',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 6 },

    next = { 'anva_17' },
	prev = { 'anva_15' },

    nominal = 16,
    shorthand = '16',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}

--17
SMODS.Rank {

    key = '17',
    card_key = '17',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 7 },

    next = { 'anva_18' },
	prev = { 'anva_16' },

    nominal = 17,
    shorthand = '17',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}

--18
SMODS.Rank {

    key = '18',
    card_key = '18',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 8 },

    next = { 'anva_19' },
	prev = { 'anva_17' },

    nominal = 18,
    shorthand = '18',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}

--19
SMODS.Rank {

    key = '19',
    card_key = '19',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 9 },

    next = { 'anva_20' },
	prev = { 'anva_18' },

    nominal = 19,
    shorthand = '19',
    hidden = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}

--20
SMODS.Rank {

    key = '20',
    card_key = '20',

    hc_atlas = 'ranks_hc',
    lc_atlas = 'ranks_lc',
    pos = { x = 10 },

    next = { '2' },
	prev = { 'anva_19' },

    nominal = 20,
    shorthand = '20',
    hidden = true,

    straight_edge = true,

	in_pool = function(self, args)
        return G.GAME.high_ranks
    end
}
