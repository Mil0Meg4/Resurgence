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

	--V1 stuff
	if next(SMODS.find_card("j_rsgc_v1")) then
		RSGC.set_paint(card, "red")
	end

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
		gay = 6,
		nb = 7,
		ace = 6,
		aro = 6,
		acoace = 6,
		pan = 6,
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
function RSGC.create_card(_type,area,legendary,_rarity,skip_materialize,soulable,forced_key,key_append,above_limit,func)
    local buffer_type = area == G.jokers and 'joker_buffer' or 'consumeable_buffer'
    if above_limit or #area.cards + G.GAME[buffer_type] < area.config.card_limit then
		local card
        G.GAME[buffer_type] = G.GAME[buffer_type] + (above_limit and 0 or 1)
        G.E_MANAGER:add_event(Event {func = function()
            card = create_card(_type,area,legendary,_rarity,skip_materialize,soulable,forced_key,key_append)
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

function RSGC.is_in_collection(card)
	for j = 1, #(G.your_collection or {}) do
		for i = 1, #((G.your_collection[j] or {}).cards or {}) do
			if G.your_collection[j].cards[i] == card then 
				return true
			end
		end
	end
	return false
end