--Does math on all values inside a table, with the option of using another table as reference.
--Operation contains the values for the math, which can be set, add or mult
--Insert values in target_keywords if you want to affect only them, or into banned_keywords if you want to affect anything but them
ANVA.mod_table_values = function(table, ref, operation,target_keywords,banned_keywords)
    if not operation then operation = {} end
    if target_keywords and not next(target_keywords) then target_keywords = nil end--if target_keywords exists but is empty, it becomes nil
    if not banned_keywords then banned_keywords = {} end
    if not ref then ref = table end--if no ref table is given, take the main one as a reference
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
                    table[k] = ((set or ref[k]) + add) * mult--solves the math in order
                end
            elseif type(v) == "table" and ref and k then--if the value is a table do math on all the values inside of it
                modify_values(v, ref[k])
            end
        end
    end
    if table == nil then--returns if there is no table
        return
    end
    modify_values(table, ref)--call the previously declared function
end

--Returns true if imputed Sticker is a Tweak
function ANVA.is_tweak(str)
    local tweaks = ANVA.Tweaks_keys
    for _, v in ipairs(tweaks) do
        if 'anva_' .. v == str then
            return true
        end
    end
    return false
end

--Removes a joker's tweak
function ANVA.remove_tweak(card)
        for k, _ in pairs(card and card.ability or {}) do
            if ANVA.is_tweak(k) then
                card.ability[k] = nil
            end
        end
    end
  
--Sets a joker's tweak, repleacing previous one
  function ANVA.set_tweak(card, type)
    local key = 'anva_' .. type
  
    if card and ANVA.is_tweak(key) then
        ANVA.remove_tweak(card)
      SMODS.Stickers[key]:apply(card, true)
    end
end


--Returns a table with all the suit in hand and the number of cards of each
function ANVA.get_suits(scoring_hand, bypass_debuff)
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