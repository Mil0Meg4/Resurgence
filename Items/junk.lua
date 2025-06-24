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
        RSGC.use_consumable(card,G.hand.highlighted, function()
            for _, v in ipairs(G.hand.highlighted) do
                SMODS.change_base(v,nil,"rsgc_42")
            end
        end)
    end,
    in_pool = function(self, wawa, wawa2)
		return false
	end
})