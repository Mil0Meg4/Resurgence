--Does math on all values inside a table, with the option of using another table as reference.
--Config contains the values for the math, which can be set, add or mult
--Insert values you don't wnt to be affected inside banned_keywords
ANVA.mod_table_values = function(table, ref, config,banned_keywords)
    if not config then config = {} end
    if not banned_keywords then banned_keywords = {} end
    if not ref then ref = table end--if no ref table is given, take the main one as a reference
    --convert config to three vars to avoid typing it in full every time
    local set = config.set or nil--value to replace the starting value with
    local add = config.add or 0--value to add to the starting value 
    local mult = config.mult or 1--value to multiply the starting value by
    local function modify_values(table, ref)--declares the function to use later
        for k, v in pairs(table) do--iterates trough all the values of the table
            if type(v) == "number" then--if value is a number do the math
                if k == "x_mult" and v == 1 or k == "x_chips" and v == 1 or v == 0 then banned_keywords[k] = true end--ban keys if they have their starting values
                if ref and ref[k] and not banned_keywords[k] then--checks if the key is in the ref table and is not banned
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