local orig_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if next(find_joker("j_anva_everything")) and _type ~= "Base" and _type ~= "Enhanced" and _type ~= "Booster" then
        forced_key = "c_base"
        _type = "Base"
    end
    local card = orig_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    SMODS.change_base(card,nil,"anva_42")
    return card
end