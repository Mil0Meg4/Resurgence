RSGC = {}
RSGC.C = {
    VAMPIRICA = HEX("880808"),
    AUGMENT = HEX("b59262"),
    DIVINE = HEX("ffffbb"),
    FAUST = HEX("b66444"),
    CURSED = HEX("4a0044"),
    PRIMORDIAL = HEX("000000"),
    UNBOUND = HEX("000000"),
    ARTIFACT = HEX("000000"),
    PINK = HEX("eda5b2"),
    CYAN = HEX("93cbcb"),
    BROWN = HEX("4e3f36"),
    BLACK = HEX("000000"),
    GAY = {0,0,0,1},
    GAY_HUE = 0,
}
RSGC.GRADIENTS = {
    UNDER = {G.C.RED,G.C.PURPLE},
    ULTRA = {RSGC.C.VAMPIRICA,G.C.BLACK},
    VAMP = {RSGC.C.VAMPIRICA,G.C.MONEY},
    HOLLOW = {HEX("6b8cad"),G.C.BLACK},
    PRIMORDIAL = {HEX("3D3446"),G.C.PURPLE},
    UNBOUND = {HEX("bc5a25"),RSGC.C.VAMPIRICA},
    ARTIFACT = {HEX("40b5c4"),HEX("a8ced3")}
}
SMODS.load_file("Items/funcs.lua")()
SMODS.load_file("Items/junk.lua")()
SMODS.load_file("Items/ui.lua")()
SMODS.load_file("Items/resurgence phase.lua")()
SMODS.load_file("Items/editions.lua")()
SMODS.load_file("Items/augments.lua")()
SMODS.load_file("Items/tweaks.lua")()
SMODS.load_file("Items/enhancements.lua")()
SMODS.load_file("Items/ranks.lua")()
SMODS.load_file("Items/jokers.lua")()
SMODS.load_file("Items/primordials.lua")()
SMODS.load_file("Items/decks.lua")()
SMODS.load_file("Items/tags.lua")()
SMODS.load_file("Items/planars/ultrakill.lua")()
SMODS.load_file("Items/planars/undertale.lua")()
SMODS.load_file("Items/planars/vampire.lua")()
SMODS.load_file("Items/planars/hollowknight.lua")()
SMODS.load_file("Items/planars/hgttg.lua")()
SMODS.load_file("Items/paints.lua")()--paint must be after hgttg for ordering reasons

--joker ATLAS
SMODS.Atlas{
    key = "joke",
    path = "joker.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "long",
    path = "long long joker.png",
    px = 71,
    py = 757,
}
SMODS.Atlas{
    key = "enha",
    path = "enhancement.png",
    px = 71,
    py = 95
}
--augment ATLAS
SMODS.Atlas{
    key = "aug",
    path = "augment.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "tweak",
    path = "tweak.png",
    px = 71,
    py = 95
}
--booster pack ATLAS
SMODS.Atlas{
    key = "booster",
    path = "boosters.png",
    px = 71,
    py = 95
}
--Ranks ATLAS
SMODS.Atlas{
    key = "ranks_lc",
    path = "rank_lc.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "ranks_hc",
    path = "rank_hc.png",
    px = 71,
    py = 95
}
--suitless ATLAS
SMODS.Atlas{
    key = "suitless",
    path = "suitless.png",
    px = 71,
    py = 95
}
--spectral ATLAS
SMODS.Atlas{
    key = "specral",
    path = "spectrals.png",
    px = 71,
    py = 95
}
--tag ATLAS
SMODS.Atlas({
    key = 'tags',
    path = 'tags.png',
    px = '34',
    py = '34'
})
--Mod icon
SMODS.Atlas({
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34
})
local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        lc()
    end
    G.ARGS.LOC_COLOURS.rsgc_pink = RSGC.C.PINK
    G.ARGS.LOC_COLOURS.rsgc_cyan = RSGC.C.CYAN
    G.ARGS.LOC_COLOURS.rsgc_under = RSGC.C.UNDER
    G.ARGS.LOC_COLOURS.rsgc_aug= RSGC.C.AUGMENT
    G.ARGS.LOC_COLOURS.rsgc_black= RSGC.C.BLACK
    return lc(_c, _default)
end

local function hsv(h, s, v)
    if s <= 0 then return v,v,v end
    h = h*6
    local c = v*s
    local x = (1-math.abs((h%2)-1))*c
    local m,r,g,b = (v-c), 0, 0, 0
    if h < 1 then
        r, g, b = c, x, 0
    elseif h < 2 then
        r, g, b = x, c, 0
    elseif h < 3 then
        r, g, b = 0, c, x
    elseif h < 4 then
        r, g, b = 0, x, c
    elseif h < 5 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end
    return r+m, g+m, b+m
end

local orig_update = Game.update
function Game:update(dt)

    if RSGC.longlong then 
        if G.TIMERS.REAL - RSGC.long_started > 24 then 
            RSGC.longlong = false
            RSGC.long_started = nil
        end
    end
    orig_update(self,dt)
	local anim_timer = self.TIMERS.REAL * 1.5
	local p = 0.5 * (math.sin(anim_timer) + 1)
	for k, c in pairs(RSGC.GRADIENTS) do
		if not RSGC.C[k] then
			RSGC.C[k] = { 0, 0, 0, 0 }
		end
		for i = 1, 4 do
			RSGC.C[k][i] = c[1][i] * p + c[2][i] * (1 - p)
		end
        if G.ARGS.LOC_COLOURS then 
            ---@diagnostic disable-next-line: assign-type-mismatch
            G.ARGS.LOC_COLOURS["rsgc_"..string.lower(k)] = RSGC.C[k]
        end
	end
    local r, g, b = hsv(RSGC.C.GAY_HUE / 360, .5, 1)

    RSGC.C.GAY[1] = r
    RSGC.C.GAY[3] = g
    RSGC.C.GAY[2] = b

    RSGC.C.GAY_HUE = (RSGC.C.GAY_HUE + 0.5) % 360

    if G.ARGS.LOC_COLOURS then 
        G.ARGS.LOC_COLOURS.rsgc_gay = RSGC.C.GAY
    end
    if ((SMODS.OPENED_BOOSTER or {}).ability or {}).gay_pack
    and G.booster_pack and not G.booster_pack.REMOVED then 
        ease_background_colour{new_colour = RSGC.C.GAY, special_colour = G.C.BLACK, contrast = 2}
    end
end
--new context that trigger whenever a card is destroyed or sold 
local orig_start_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	--[[ if G and G.jokers and G.jokers.cards then
		SMODS.calculate_context({ rsgc_destroyed = true, card = self })
	end ]]
    if self.ability and self.ability.rsgc_rubber and not self.ability.selling then
        local copy = copy_card(self, nil, nil, nil, nil)
        copy:start_materialize()
        copy:add_to_deck()
        G.jokers:emplace(copy)
    end
	return orig_start_dissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

function SMODS.current_mod.reset_game_globals(run_start)
	if run_start then
        G.GAME.win_ante_old = nil
        G.GAME.resurgence = false
        G.GAME.resurgence_notified = false
        G.GAME.resurging = false
        G.GAME.resurging_started = false
        G.GAME.macro_ranks = G.GAME.macro_ranks or false
        G.GAME.micro_ranks = G.GAME.micro_ranks or false
        G.GAME.current_pride_flag = RSGC.poll_flag("game_start")
        G.GAME.tinfoil_count = (G.GAME.tinfoil_count or false)
    end
end

SMODS.Sound({
	key = "augment_music",
	path = "augment.ogg",
	sync = true,
	select_music_track = function()
		return G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "Augment"
	end
})

SMODS.Sound({
	key = "gay_music",
	path = "eek.ogg",
	sync = true,
    pitch = 1,
	select_music_track = function()
		return ((SMODS.OPENED_BOOSTER or {}).ability or {}).gay_pack
        and G.booster_pack and not G.booster_pack.REMOVED
        and 2
	end
})

SMODS.Sound({
	key = "long",
	path = "long long man.ogg",
	sync = false,
    pitch = 1,
})

SMODS.Sound({
	key = "music_silence",
	path = "silence.ogg",
	sync = true,
    pitch = 1,
	select_music_track = function()
		return RSGC.longlong and 100
	end
})

SMODS.Sound({
	key = "resu_music",
	path = "resurgence.ogg",
	sync = true,
	pitch = 1,
	select_music_track = function()
		return G.GAME.resurgence and not (G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1]) and 5
	end
})

--[[ SMODS.Sound({
	key = "prim_music",
	path = "primordial.ogg",
	sync = true,
	pitch = 1,
	select_music_track = function()
		return #RSGC.advanced_find_joker(nil,"rsgc_prim", nil, nil, true) ~= 0 and 15
	end
}) ]]
-------------------------------------------------------------------------
----stuff for making tweaks and paints have their own collection tabs----
-------------------------------------------------------------------------
SMODS.current_mod.custom_collection_tabs = function()
    return {
        UIBox_button({
        button = 'your_collection_rsgc_tweaks',
        id = 'your_collection_rsgc_tweaks',
        label = { localize('rsgc_tweak_ui') },
        minw = 5,
        minh = 1
        }),
        UIBox_button({
        button = 'your_collection_rsgc_paints',
        id = 'your_collection_rsgc_paints',
        label = { localize('rsgc_paint_ui') },
        minw = 5,
        minh = 1
        })
    }
end

local function wrap_without_paints_and_tweaks(func)
    local removed = {}
    for k, v in pairs(SMODS.Stickers) do
        if RSGC.is_paint(k) or RSGC.is_tweak(k) then
        removed[k] = v
        SMODS.Stickers[k] = nil
        end
    end

    local ret = func()

    for k, v in pairs(removed) do
        SMODS.Stickers[k] = v
    end

    return ret
end

local stickers_ui_ref = create_UIBox_your_collection_stickers
create_UIBox_your_collection_stickers = function()
    return wrap_without_paints_and_tweaks(stickers_ui_ref)
end

local other_objects_ref = create_UIBox_Other_GameObjects
create_UIBox_Other_GameObjects = function()
    return wrap_without_paints_and_tweaks(other_objects_ref)
end


------------------------------------------------------------
-----------------------Planar Sets--------------------------
------------------------------------------------------------
SMODS.ObjectType({
	key = "undertale",
	default = "j_rsgc_frisk",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.ObjectType({
	key = "ultrakill",
	default = "j_rsgc_filth",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.ObjectType({
	key = "planar",
	default = "j_rsgc_filth",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.ObjectType({
	key = "vampire",
	default = "j_rsgc_poe",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "hollow",
	default = "j_rsgc_sly",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "gay",
	default = "j_blueprint",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.j_blueprint)
		self:inject_card(G.P_CENTERS.j_brainstorm)
		self:inject_card(G.P_CENTERS.j_vampire)
		self:inject_card(G.P_CENTERS.j_midas_mask)
	end,
})

--------------------------------------------------------
-------------------Alpha and Omega----------------------
--------------------------------------------------------

local font_replacement = NFS.read(SMODS.current_mod.path..'assets/fonts/font.ttf')
love.filesystem.write('font_replacement.ttf', font_replacement)
G.FONTS[1].FONT = love.graphics.newFont('font_replacement.ttf', G.TILESIZE * 10)
love.filesystem.remove('font_replacement.ttf')

SMODS.Rank {

    key = 'alpha_rank',
    card_key = 'ALPHA',

    --hc_atlas = 'aug',
    --lc_atlas = 'aug',
    pos = { x = 1 },

    next = { 'rsgc_omega_rank' },
	prev = { 'rsgc_omega_rank' },

    nominal = 0,
    shorthand = 'α',
    hidden = true,

    straight_edge = true,

	in_pool = function(self, args)
        return false
    end
}
SMODS.Rank {

    key = 'omega_rank',
    card_key = 'OMEGA',

    --hc_atlas = 'aug',
    --lc_atlas = 'aug',
    pos = { x = 1 },

    next = { 'rsgc_alpha_rank' },
	prev = { 'rsgc_alpha_rank' },

    nominal = 0,
    shorthand = 'Ω',
    hidden = true,

    straight_edge = true,
    
	in_pool = function(self, args)
        return false
    end
}
SMODS.Suit {

    key = 'greek',
    card_key = 'GREEK',

    lc_atlas = 'enha',
    lc_ui_atlas = 'enha',
    lc_colour = RSGC.C.VAMPIRICA,

    hc_atlas = 'enha',
    hc_ui_atlas = 'enha',
    hc_colour = RSGC.C.VAMPIRICA,

    hidded = true,
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },

    in_pool = function(self, args)
        return false
    end
}

--Optional Features
 SMODS.current_mod.optional_features = function()
    return {
        post_trigger = true
    }
end 
--------------------------------------------------------
----------------------Functions-------------------------
--------------------------------------------------------

function RSGC.fact (n)
    if n <= 0 then
      return 1
    else
      return n * RSGC.fact(n-1)
    end
  end

function RSGC.acorn (n, n2)
    if n <= 0 or n2 <= 0 then
        return 1
    else
        return  (  (  (
        ( ( n ^ n ) ^ 3 ) ^ ( n2 ^ 3 )
                ) ) )
    end
end

local orig_get_new_boss = get_new_boss
function get_new_boss() 
    local temp = G.GAME.win_ante
    G.GAME.win_ante = G.GAME.win_ante_old or G.GAME.win_ante
    local ret = orig_get_new_boss()
    G.GAME.win_ante = temp
    return ret
end