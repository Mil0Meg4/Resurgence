--Does math on all values inside a table, with the option of using another table as reference.
--Operation contains the values for the math, which can be set, add or mult.
--Insert values in target_keywords if you want to affect only them, or into banned_keywords if you want to affect anything but them.
--If linear is off, the ref table replaces the main one, otherwise the function uses the main table as a base and the ref table for the modification
RSGC.mod_table_values = function(table, ref, operation,target_keywords,banned_keywords,linear)
    if not operation then operation = {} end
    if target_keywords and not next(target_keywords) then target_keywords = nil end--if target_keywords exists but is empty, it becomes nil
    if not banned_keywords then banned_keywords = {} end
    if not ref then ref = table end--if no ref table is given, take the main one as a reference
	banned_keywords["unbound"] = true--does not modify the unbound vals
	banned_keywords["paint"] = true--does not modify the paint vals
    --convert config to three vars to avoid typing it in full every time
    local set = operation.set or nil--value to replace the starting value with
    local add = operation.add or 0--value to add to the starting value 
    local mult = operation.mult or 1--value to multiply the starting value by
    local function modify_values(table, ref)--declares the function to use later
        for k, v in pairs(table) do--iterates trough all the values of the table
            if type(v) == "number" then--if value is a number do the math
                if k == "x_mult" and v == 1 or k == "x_chips" and v == 1 or v == 0 then banned_keywords[k] = true end--ban keys if they have their starting values
                if ref and ref[k]--checks if the key is in the ref table
                and (not target_keywords or target_keywords and target_keywords[k])--checks if tagert_keyword is not false and if the key is none of the targeted ones
                and not banned_keywords[k] then--checks if the key is not banned
                    if not linear then--checks if linear chanage should be used
                        table[k] = ((set or ref[k]) + add) * mult--solves the math in order
                    else
                        local temp = (set or table[k]) + add--creates a temporary value
                        local temp_ref = (set or ref[k]) + add--creates a temporary value
                        table[k] = temp + (temp_ref * mult) - temp_ref--solves the math in order
                    end
                end
            elseif type(v) == "table" and ref and k and not banned_keywords[k] then--if the value is a table do math on all the values inside of it
                modify_values(v, ref[k])
            end
        end
    end
    if table == nil then--returns if there is no table
        return
    end
    modify_values(table, ref)--call the previously declared function
end

function RSGC.remove_stickers(card)
	for k, v in pairs(SMODS.Stickers) do
        if not (RSGC.is_paint(k) or RSGC.is_tweak(k)) then
			card:remove_sticker(k)
        end
    end
end

--Returns true if imputed Sticker is a Tweak
function RSGC.is_tweak(str)
    local tweaks = RSGC.Tweaks_keys
    for _, v in ipairs(tweaks) do
        if 'rsgc_' .. v == str then
            return true
        end
    end
    return false
end

--Removes a joker's Tweak
function RSGC.remove_tweak(card)
	for k, _ in pairs(card and card.ability or {}) do
		if RSGC.is_tweak(k) then
			card.ability[k] = nil
		end
	end
end
  
--Sets a joker's Tweak, repleacing previous one
function RSGC.set_tweak(card, type)
    local key = 'rsgc_' .. type
  
    if card and RSGC.is_tweak(key) then
        RSGC.remove_tweak(card)
        SMODS.Stickers[key]:apply(card, true)
    end
end

--Checks if card has a certain tweak. Leave the type field empty to check for any tweak
function RSGC.has_tweak(card,type)
	local key = type and 'rsgc_' .. type or nil
	for k, _ in pairs(card and card.ability or {}) do
		if RSGC.is_tweak(k) then
			return not key and k or k == key
		end
	end
	return false
end

--Returns true if imputed Sticker is a Paint
function RSGC.is_paint(str)
    local paints = RSGC.Paint_keys
    for _, v in ipairs(paints) do
        if 'rsgc_paint_' .. v == str then
            return true
        end
    end
    return false
end

--Removes a joker's Paint
function RSGC.remove_paint(card)
	for k, _ in pairs(card and card.ability or {}) do
		if RSGC.is_paint(k) then
			card.ability[k] = nil
			card.ability.paint = nil
		end
	end
end

--Sets a joker's Paint, repleacing previous one
  function RSGC.set_paint(card, type)
    local key = 'rsgc_paint_' .. type

    if card and RSGC.is_paint(key) then
        RSGC.remove_paint(card)
        SMODS.Stickers[key]:apply(card, true)
    end
end

--Checks if card has a certain paint. Leave the type field empty to check for any paint and return its key
function RSGC.has_paint(card,type)
	local key = type and 'rsgc_paint_' .. type or nil
	for k, _ in pairs(card and card.ability or {}) do
		if (key == k or key == nil) and RSGC.is_paint(k) then
			return k
		end
	end
	return nil
end

--Returns a table with all the suit in hand and the number of cards of each
function RSGC.get_suits(scoring_hand, bypass_debuff)
    local suits = {}
    for k, _ in pairs(SMODS.Suits) do
        suits[k] = 0
    end
    for _, card in ipairs(scoring_hand) do
        if not SMODS.has_any_suit(card) then
            for suit, count in pairs(suits) do
                if card:is_suit(suit, bypass_debuff) and count == 0 then
                    suits[suit] = count + 1
                    break
                end
            end
        end
    end
    for _, card in ipairs(scoring_hand) do
        if SMODS.has_any_suit(card) then
            for suit, count in pairs(suits) do
                if card:is_suit(suit, bypass_debuff) and count == 0 then
                    suits[suit] = count + 1
                    break
                end
            end
        end
    end
    return suits
end

--Polls a random paint, based on their weights.
--Key is the seed, should be unique. Mod changes the chance of the paint being applied.
--If Guaranteed is true, a paint will alwais be applied. Options is the list of the possible paints, includes all if left empty
function poll_paint(_key, _mod, _guaranteed, _options)
	local _modifier = 1
	local paint_poll = pseudorandom(pseudoseed(_key or 'paint_generic')) 
	local available_paints = {}                                         
    if _options then 
        for k, v in pairs(SMODS.Stickers) do
            if _options[string.sub(v.key,12)] then
                table.insert(available_paints, v)
            end
        end
	else
        for k, v in pairs(SMODS.Stickers) do
            local is_paint = RSGC.is_paint(k)
            local in_pool = (v.in_pool and type(v.in_pool) == "function") and v:in_pool({source = _key})
            if is_paint and (in_pool or v.in_shop) then
                table.insert(available_paints, v)
            end
        end
	end
	local total_weight = 0
	for _, v in ipairs(available_paints) do
		total_weight = total_weight + (v.weight) 
	end

	if not _guaranteed then
		_modifier = _mod or 1
		total_weight = total_weight + (total_weight / 4 * 94) -- Find total weight with base_card_rate as 96%
	end
	
	local weight_i = 0
	for _, v in ipairs(available_paints) do
		weight_i = weight_i + v.weight * _modifier

		if paint_poll > 1 - (weight_i) / total_weight then
			return string.sub(v.key,12)
		end
	end

	return nil
end

function RSGC.poll_flag(_key)
	local flag_poll = pseudorandom(pseudoseed(_key or 'paint_generic')) 
	local pool = {
		rainbow = 20,
		trans = 6,
		lesbian = 6,
		bi = 7,
		gay = 9,
		nb = 6,
		ace = 5,
		aro = 6,
		acoace = 7,
		pan = 9,
	}
	local total_weight = 0
	for k, v in pairs(pool) do
		total_weight = total_weight + v
	end
	local weight_i = 0
	for k, v in pairs(pool) do
		weight_i = weight_i + v

		if flag_poll > 1 - (weight_i) / total_weight then
			return "j_rsgc_pride_"..k
		end
	end
end

-- Finds jokers with specific properties (shamelessly stolen from cryptid)
function RSGC.advanced_find_joker(name, rarity, edition, ability, non_debuff, area)
	local jokers = {}
	if not G.jokers or not G.jokers.cards then
		return {}
	end
	local filter = 0
	if name then
		filter = filter + 1
	end
	if edition then
		filter = filter + 1
	end
	if type(rarity) ~= "table" then
		if type(rarity) == "string" then
			rarity = { rarity }
		else
			rarity = nil
		end
	end
	if rarity then
		filter = filter + 1
	end
	if type(ability) ~= "table" then
		if type(ability) == "string" then
			ability = { ability }
		else
			ability = nil
		end
	end
	if ability then
		filter = filter + 1
	end
	if filter == 0 then
		return {}
	end
	if not area or area == "j" then
		for k, v in pairs(G.jokers.cards) do
			if v and type(v) == "table" and (non_debuff or not v.debuff) then
				local check = 0
				if name and v.ability.name == name then
					check = check + 1
				end
				if
					edition
					and (v.edition and v.edition.key == edition)
				then
					check = check + 1
				end
				if rarity then
					for _, a in ipairs(rarity) do
						if v.config.center.rarity == a then
							check = check + 1
							break
						end
					end
				end
				if ability then
					local abilitycheck = true
					for _, b in ipairs(ability) do
						if not v.ability[b] then
							abilitycheck = false
							break
						end
					end
					if abilitycheck then
						check = check + 1
					end
				end
				if check == filter then
					table.insert(jokers, v)
				end
			end
		end
	end
	if not area or area == "c" then
		for k, v in pairs(G.consumeables.cards) do
			if v and type(v) == "table" and (non_debuff or not v.debuff) then
				local check = 0
				if name and v.ability.name == name then
					check = check + 1
				end
				if
					edition
					and (v.edition and v.edition.key == edition)
				then
					check = check + 1
				end
				if ability then
					local abilitycheck = true
					for _, b in ipairs(ability) do
						if not v.ability[b] then
							abilitycheck = false
							break
						end
					end
					if abilitycheck then
						check = check + 1
					end
				end
				if check == filter then
					table.insert(jokers, v)
				end
			end
		end
	end
	return jokers
end

function RSGC.paint_tooltip(type)
	local key = 'rsgc_paint_' .. type
	local paint = SMODS.Stickers[key]
	if not paint then return end

	local vars = {}
	if paint.loc_vars then
		local card = { ability = {} }
		paint:apply(card, true)
		vars = paint:loc_vars({}, card).vars
	end

	return {set = 'Other',key = key,vars = vars}
end

function RSGC.update_add_to_deck(card, func)
	if not card.added_to_deck then
		return func(card)
	else
		card:remove_from_deck(true)
		local ret = func(card)
		card:add_to_deck(true)
		return ret
	end
end

-- subtitles by AutumnMood
local orig_generate_UIBox_ability_table = Card.generate_UIBox_ability_table;
function Card:generate_UIBox_ability_table()
	local ret = orig_generate_UIBox_ability_table(self)
	
	local center_obj = self.config.center
	
	if center_obj and center_obj.discovered and ((center_obj.set and G.localization.descriptions[center_obj.set] 
	and G.localization.descriptions[center_obj.set][center_obj.key]
	and G.localization.descriptions[center_obj.set][center_obj.key].rsgc_subtitle) or center_obj.rsgc_subtitle) then
	
		if ret.name and ret.name ~= true then
			local text = ret.name
			--text[1].config.object.text_offset.y = text[1].config.object.text_offset.y - 14
			ret.name = {{n=G.UIT.R, config={align = "cm"},nodes={
				{n=G.UIT.R, config={align = "cm"}, nodes=text},
				{n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.O, 
					config={
						object = DynaText({string = (center_obj.set 
						and G.localization.descriptions[center_obj.set] 
						and G.localization.descriptions[center_obj.set][center_obj.key].rsgc_subtitle)
						or center_obj.rsgc_subtitle, 
						colours = {G.C.WHITE},
						float = true,
						shadow = true,
						offset_y = 0.1,
						silent = true,
						spacing = 1,
						scale = 0.37
					})}}
				}}
			}}}
		end
	end
	return ret
end
function RSGC.is_macro(card)
	return card.base.value and SMODS.Ranks[card.base.value].rsgc_macro or false
end
function RSGC.is_micro(card)
	return card.base.value and SMODS.Ranks[card.base.value].rsgc_micro or false
end
--[[ 
function RSGC.table_has(list, value)
	for i, v in ipairs(list) do
		if v == value then
			return true
		end
	end
	return false
end ]]
--code directly taken from prism, no need to chnage anything
function RSGC.create_card(_type,area,legendary,_rarity,skip_materialize,soulable,forced_key,key_append,func)
    local buffer_type = area == G.jokers and 'joker_buffer' or 'consumeable_buffer'

    if #area.cards + G.GAME[buffer_type] < area.config.card_limit then
        G.GAME[buffer_type] = G.GAME[buffer_type] + 1
        G.E_MANAGER:add_event(Event {
            func = function()
            local card = create_card(_type,area,legendary,_rarity,skip_materialize,soulable,forced_key,key_append)
            card:add_to_deck()
            area:emplace(card)
            func(card)
            G.GAME[buffer_type] = 0
            return true
            end
        })
        return true
    end
end

function RSGC.resurgence_start()
    if (not G.GAME.seeded and not G.GAME.challenge) or SMODS.config.seeded_unlocks then
        set_joker_win()
        set_deck_win()
        check_and_set_high_score('win_streak', G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt+1)
        check_and_set_high_score('current_streak', G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt+1)
        check_for_unlock({type = 'win_no_hand'})
        check_for_unlock({type = 'win_no'})
        check_for_unlock({type = 'win_custom'})
        check_for_unlock({type = 'win_deck'})
        check_for_unlock({type = 'win_stake'})
        check_for_unlock({type = 'win'})
        inc_career_stat('c_wins', 1)
    end

    set_profile_progress()

    if G.GAME.challenge then
        G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[G.GAME.challenge] = true
        set_challenge_unlock()
        check_for_unlock({type = 'win_challenge'})
        G:save_settings()
    end

	--RSGC.jimbotalk("start")
    --[[ G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            for k, v in pairs(G.I.CARD) do
                v.sticker_run = nil
            end
            
            play_sound('win')
            G.SETTINGS.paused = true

            G.FUNCS.overlay_menu{
                definition = RSGC.create_UIBox_resurgence(),
                config = {no_esc = true}
            } 
            local Jimbo = nil

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                blocking = false,
                func = (function()
                    if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot') then 
                        Jimbo = Card_Character({x = 0, y = 0})
                        local spot = G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot')
                        spot.config.object:remove()
                        spot.config.object = Jimbo
                        Jimbo.ui_object_updated = true
                        Jimbo:add_speech_bubble('wq_'..math.random(1,7), nil, {quip = true})
                        Jimbo:say_stuff(5)
                        if G.F_JAN_CTA then 
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    Jimbo:add_button(localize('b_wishlist'), 'wishlist_steam', G.C.DARK_EDITION, nil, true, 1.6)
                                    return true
                                end}))
                        	end
                        end
                    return true
                end)
            }))
            
            return true
        end)
    }))
 ]]
    if (not G.GAME.seeded and not G.GAME.challenge) or SMODS.config.seeded_unlocks then
        G.PROFILES[G.SETTINGS.profile].stake = math.max(G.PROFILES[G.SETTINGS.profile].stake or 1, (G.GAME.stake or 1)+1)
    end
    G:save_progress()
    G.FILE_HANDLER.force = true
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            if not G.SETTINGS.paused then
                G.GAME.current_round.round_text = 'Resurgence Round '
                return true
            end
        end)
    }))
end

function RSGC.jimbotalk(_part)
  	 local step = 1
	G.SETTINGS.paused = true
	if _part == "start" then
		G.gateway = Sprite(
			G.ROOM_ATTACH.T.x + G.ROOM_ATTACH.T.w / 2 - 1,
			G.ROOM_ATTACH.T.y + G.ROOM_ATTACH.T.h / 2 - 4,
			G.CARD_W * 1.5,
			G.CARD_H * 1.5,
			G.ASSET_ATLAS["cry_atlasnotjokers"],
			{ x = 2, y = 0 }
		)
		G.gateway.states.visible = false
		G.gateway.states.collide.can = true
		G.gateway.states.focus.can = false
		G.gateway.states.hover.can = true
		G.gateway.states.drag.can = false
		G.gateway.hover = Node.hover
		G.yawetag = Sprite(
			G.ROOM_ATTACH.T.x + G.ROOM_ATTACH.T.w / 2 - 1,
			G.ROOM_ATTACH.T.y + G.ROOM_ATTACH.T.h / 2 - 4,
			G.CARD_W * 1.5,
			G.CARD_H * 1.5,
			G.ASSET_ATLAS["cry_atlasnotjokers"],
			{ x = 6, y = 5 }
		)
		G.yawetag.states.visible = false
		G.yawetag.states.collide.can = true
		G.yawetag.states.focus.can = false
		G.yawetag.states.hover.can = true
		G.yawetag.states.drag.can = false
		G.yawetag.hover = Node.hover
		step = Cryptid.intro_info({
			text_key = "cry_intro_1",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = 0 } },
			step = step,
		})
		step = Cryptid.intro_info({
			text_key = "cry_intro_2",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
		})
		step = Cryptid.intro_info({
			text_key = "cry_intro_3",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
			highlight = {
				G.gateway,
				G.yawetag,
			},
			on_start = function()
				G.gateway.states.visible = true
				G.gateway:set_alignment({ major = G.ROOM_ATTACH, type = "cm", offset = { x = -2.5, y = -3 } })
				G.yawetag.states.visible = true
				G.yawetag:set_alignment({ major = G.ROOM_ATTACH, type = "cm", offset = { x = 2.5, y = -3 } })
			end,
		})
		step = Cryptid.intro_info({
			text_key = "cry_intro_4",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
			highlight = {
				G.gateway,
				G.yawetag,
			},
		})
		local modestSprite = Sprite(0, 0, 1, 1, G.ASSET_ATLAS["cry_gameset"], { x = 0, y = 0 })
		modestSprite:define_draw_steps({
			{ shader = "dissolve", shadow_height = 0.05 },
			{ shader = "dissolve" },
		})
		local mainlineSprite = Sprite(0, 0, 1, 1, G.ASSET_ATLAS["cry_gameset"], { x = 1, y = 0 })
		mainlineSprite:define_draw_steps({
			{ shader = "dissolve", shadow_height = 0.05 },
			{ shader = "dissolve" },
		})
		local madnessSprite = Sprite(0, 0, 1, 1, G.ASSET_ATLAS["cry_gameset"], { x = 2, y = 0 })
		madnessSprite:define_draw_steps({
			{ shader = "dissolve", shadow_height = 0.05 },
			{ shader = "dissolve" },
		})
		--TODO: localize
		G.modestBtn = create_UIBox_character_button_with_sprite({
			sprite = modestSprite,
			button = "Modest",
			id = "modest",
			func = "cry_modest",
			colour = G.C.GREEN,
			maxw = 3,
		})
		G.mainlineBtn = create_UIBox_character_button_with_sprite({
			sprite = mainlineSprite,
			button = "Mainline",
			id = "mainline",
			func = "cry_mainline",
			colour = G.C.RED,
			maxw = 3,
		})
		G.madnessBtn = create_UIBox_character_button_with_sprite({
			sprite = madnessSprite,
			button = "Madness",
			id = "madness",
			func = "cry_madness",
			colour = G.C.CRY_EXOTIC,
			maxw = 3,
		})
		local gamesetUI = create_UIBox_generic_options({
			infotip = false,
			contents = {
				G.modestBtn,
				G.mainlineBtn,
				G.madnessBtn,
			},
			back_label = "Confirm",
			back_colour = G.C.BLUE,
			back_func = "cry_gameset_confirm",
		})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			blocking = false,
			blockable = false,
			func = function()
				G.madnessBtn.config.colour = G.C.CRY_EXOTIC
				return true
			end,
		}))
		gamesetUI.nodes[2] = nil
		gamesetUI.config.colour = G.C.CLEAR
		G.gamesetUI = UIBox({
			definition = gamesetUI,
			config = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = 2.5 } },
		})
		G.gamesetUI.states.visible = false
		step = Cryptid.intro_info({
			text_key = "cry_intro_5",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
			highlight = {
				G.gateway,
				G.yawetag,
				G.gamesetUI,
			},
			on_start = function()
				--the scaling should be eased later...
				G.gamesetUI.states.visible = true
				G.gateway:set_alignment({ major = G.ROOM_ATTACH, type = "cm", offset = { x = -4.5, y = 2.2 } })
				G.gateway.T.w = G.gateway.T.w * 3
				G.gateway.T.h = G.gateway.T.h * 3
				G.yawetag:set_alignment({ major = G.ROOM_ATTACH, type = "cm", offset = { x = 4.5, y = 2.2 } })
				G.yawetag.T.w = G.yawetag.T.w * 3
				G.yawetag.T.h = G.yawetag.T.h * 3
			end,
			no_button = true,
		})
	end
	if _part == "modest" or _part == "mainline" or _part == "madness" then
		local desc_length = { --number of times Jolly Joker speaks for each gameset
			modest = 2,
			mainline = 3,
			madness = 3,
		}
		G.E_MANAGER:clear_queue("tutorial")
		if G.OVERLAY_TUTORIAL.content then
			G.OVERLAY_TUTORIAL.content:remove()
		end
		G.OVERLAY_TUTORIAL.Jimbo:remove_button()
		G.OVERLAY_TUTORIAL.Jimbo:remove_speech_bubble()
		G.OVERLAY_TUTORIAL.step = nil
		for i = 1, desc_length[_part] do
			step = Cryptid.intro_info({
				text_key = "cry_" .. _part .. "_" .. i,
				attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
				step = step,
				highlight = {
					G.gamesetUI:get_UIE_by_ID(_part),
				},
			})
		end
		step = Cryptid.intro_info({
			no_button = true,
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -3 } },
			step = step,
			highlight = {
				G.gateway,
				G.yawetag,
				G.gamesetUI,
			},
		})
	end
end

function RSGC.create_UIBox_resurgence()
  local eased_red = copy_table(G.C.RED)
  eased_red[4] = 0
  ease_value(eased_red, 4, 0.5, nil, nil, true)
  local t = UIBox_button({button = 'exit_overlay_menu', label = {localize('b_endless')}, minw = 4.5, maxw = 5, minh = 1.2, scale = 0.7, shadow = true, colour = G.C.RED, focus_args = {nav = 'wide', button = 'x',set_button_pip = true}})
  t.nodes[1] = {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 2}, nodes={
        {n=G.UIT.O, config={padding = 0, id = 'jimbo_spot', object = Moveable(0,0,G.CARD_W*1.1, G.CARD_H*1.1)}},
      }},
      {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={t.nodes[1]}
    }}
  }
  --t.nodes[1].config.mid = true
  t.config.id = 'you_win_UI'
  return t
end