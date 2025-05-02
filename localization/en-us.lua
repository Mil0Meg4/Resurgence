return {
    descriptions = {
        Back={
            b_anva_number20 = {
                name = "Deck of Numbers",
                text = {"Instead of Face cards and aces,",
                        "your deck includes ranks 11 through 20"}
            },
        },
        Blind={},
        Edition={},
        Joker={
            j_anva_sigma = {
                name = 'SIGMA',
                text = { "the next {C:purple}Tarot{} card used",
                         "{C:attention}transforms{} this Joker into",
                          "a {C:dark_edition}unique{} {C:attention}Joker{} based off",
                          "the used card"
                }
            },
            j_anva_charon = {
                name = 'Charon',
                text = { "Quintuples money",
                        "at the end of Shop",
                         "{C:inactive}(Max of {C:money}$#1#{C:inactive}){}"
                }
            },
            j_anva_gaba = {
                name = 'Gabriel',
                anv_subtitle = "Apostate of Hate",
                text = {"At end of {C:money}shop{},",
                        "{C:red}removes{} {C:dark_edition}Divine{} from",
                        "Joker to the left",
                        "to gain {X:mult,C:white}^#2#{} Mult",
                        "{C:inactive}(Currently {X:mult,C:white}^#1#{C:inactive} Mult)"
                }
            },
            j_anva_sinclair = {
                name = 'Sinclair',
                text = {"Earns {C:money}$#1#{} at end of round.",
                        "When Shop is entered, if you have {C:money}$#2#{}",
                        "or more {C:red}debuffs{} all other {C:attention}Jokers{} until",
                        "you have {C:money}$0{} or less when exiting."
                },
            },
            j_anva_pugnala = {
                name = 'Pugnala',
                text = { "{X:mult,C:white}X#1#{} Mult if played",
                         "hand contains only",
                         "{C:clubs}Clubs{} and {C:diamonds}Diamonds{}"
                }
            },
            j_anva_frisk = {
                name = 'Frisk',
                text = { "{C:chips}+#1#{} Chips for",
                         "each {C:attention}unique rarity",
                         "among owned {C:attention}Jokers",
                         "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_anva_papyrus = {
                name = 'Papyrus',
                text = {"If played hand has",
                        "only {C:attention}1{} card, {C:attention}paint{} ",
                        "played cards {C:chips}Blue{}",
                        "before scoring"
                }
            },
            j_anva_sans = {
                name = 'Sans',
                text = {"When selecting {C:attention}Blind{}, get",
                    "its associated {C:attention}Skip Tag.",
                    "When skipping {C:attention}Blind{}, this",
                    "Joker gains {C:chips}+#2#{} Chips for",
                    "each {C:anv_under}Undertale{} Joker",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_anva_doom = {
                name = 'Doom Itself',
                text = { "{C:chips}+#1#{} Chips, or {C:chips}+#2#{} Chips if all",
                    "cards in {C:attention}full deck{} are {C:attention}Stone Cards",
                    "{C:red}Destroy{} a random non-{C:attention}Stone{} card from your",
                    "deck when a {C:attention}Stone Cards{} is scored"
                }
            },
            j_anva_bartender = {
                name = 'Bartender',
                text = { "{C:attention}+#2#{} Consumable Slot",
                    "{C:red}+#1#{} Mult per {C:attention}consumable{} held",
                    "{C:inactive}(Currently {C:red}+#3#{C:inactive} Mult)"
                }
            },
            j_anva_andromeda = {
                name = 'Andromeda',
                text = { "Create a {C:attention}The Star {C:purple}Tarot",
                    "and add {C:money}$#1# {C:attention}sell value{} to",
                    "all {C:attention}Consumables{} when a",
                    "{C:diamonds}Diamond{} is scored",
                    "{C:inactive}(Mult have room)"
                }
            },
            j_anva_tree = {
                name = 'Tree',
                text = { "{C:mult}+#1#{} Mult",
                         "{C:mult}+#2#{} Mult at end of round"
                }
            },
            j_anva_tree3 = {
                name = 'Tree(3)',
                text = { "{X:mult,C:white}^^^#1#{} Mult",
                         "{X:mult,C:white}^^^#2#{} Mult at end of round"
                }
            },
            j_anva_poe = {
                name = 'Poe',
                text = {"Scored {C:hearts}Hearts{} give {C:mult}+#1#{} Mult",
                        "Every other {C:hearts}Hearts{} card scored",
                        "consecutively, starting at the {C:attention}3rd{},",
                        "{C:attention}Doubles{} this gain until end of {C:attention}blind",
                        "{C:inactive}(eg. +4, +4, +8, +8, +16){}"
                }
            },
            j_anva_jandc = {
                name = 'Johnathon & Charlotte',
                text = {"{C:attention}+#2#{} Consumable Slots",
                        "{C:chips}-#1#{} Chips for every non-{C:dark_edition}negative{}",
                        "consumable held over {C:attention}4",
                        "{C:inactive}(Currently {C:chips}-#3#{C:inactive} Chips)"
                }
            },
            j_anva_pride_rainbow = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted"
                }
            },
            j_anva_pride_bi = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:red}Red{}, {C:purple}Purple{} or {C:chips}Blue"
                }
            },
            j_anva_pride_pan = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:anv_pink}Pink{}, {C:money}Yellow{} or {C:anv_cyan}Cyan"
                }
            },
            j_anva_pride_gay = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:anv_cyan}Cyan{}, {C:inactive}White{} or {C:chips}Blue"
                }
            },
            j_anva_pride_nb = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:money}Yellow{}, {C:purple}Purple{} or {C:anv_black}Black"
                }
            },
            j_anva_pride_trans = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:chips}Blue{}, {C:anv_pink}Pink{} or {C:inactive}White"
                }
            },
            j_anva_pride_ace = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:anv_black}Black{}, {C:inactive}White{} or {C:purple}Purple"
                }
            },
            j_anva_pride_aro = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:green}Green{}, {C:inactive}White{} or {C:anv_black}Black{}"
                }
            },
            j_anva_pride_aroace = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:money}Yellow{}, {C:inactive}White{} or {C:chips}Blue"
                }
            },
            j_anva_pride_lesbian = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:attention}Orange{}, {C:inactive}White{} or {C:purple}Purple"
                }
            },
            j_anva_filth = {
                name = 'Filth',
                text = { "{C:mult}+#2#{} Mult and {C:chips}+#1#{} Chips"
                }
            },
            j_anva_alphys = {
                name = 'Alphys',
                anv_subtitle = "The Royal Scientist",
                text = { "Create a {C:attention}Blueprint",
                    "when selecting {C:attention}Boss Blind",
                    "{C:inactive}(Mult have room)"
                }
            },
            j_anva_gaster = {
                name = 'Gaster',
                anv_subtitle = "The Royal Scientist",
                text = { "{C:attention}+6{} Joker Slots, Consumable Slots,",
                    "Handsize, and Shop Slots",
                    "Scored {C:attention}6s{} give {C:chips}+66{}",
                    "Chips and {C:mult}+6{} Mult",
                    "After {C:attention}66{} {C:attention}6s{} are scored,",
                    "get {C:attention}6 Negative Tags{}",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}/66){}"
                }
            },
            j_anva_triangleJoke = {
                name = 'Triangle Joker',
                text = { "Each played {C:attention}3{} gives",
                    "{X:mult,C:white}X#1#{} Mult when scored",
                    "if played hand has",
                    "exactly {C:attention}3{} cards"
                }
            },
            j_anva_catJoker = {
                name = 'Cat Joker',
                text = { "{C:attention}Retrigger{} each played {C:attention}3{}",
                    "{C:attention}#1#{} time per {C:attention}3{} held in hand"
                }
            },
            j_anva_sly = {
                name = 'Sly',
                text = { "Earn {C:money}$#1#{} when",
                    "a card or Joker",
                    "is {C:attention}Retriggered"
                }
            },
            j_anva_nailsage = {
                name = 'Great Nailsage Sly',
                text = { "Earn {C:money}$#1#{} when a card ",
                    "or Joker is {C:attention}Retriggered",
                    "{X:mult,C:white}X#2#{} mult for",
                    "each {C:money}$#3#{} you have",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult"
                }
            },
            j_anva_sheo = {
                name = 'Paintmaster Sheo',
                text = { "Retrigger all played",
                    "{C:attention}Painted{} cards and",
                    "all {C:attention}Painted{} Jokers"
                }
            },
            j_anva_sappho = {
                name = 'Sappho of Lesbos',
                text = { "Retrigger all played",
                    "{C:spades}Spades{}, {C:hearts}Hearts{}, {C:clubs}Clubs{},",
                    "{C:diamonds}Diamonds{}, and {C:attention}Wild{} cards {C:attention}#1#{} times"
                }
            },
            j_anva_mini_mice = {
                name = 'Mini Mice',
                text = {"{C:red}+#1#{} Mult",
                    "All hands are considered",
                    "to be a {C:attention}High Card"
                }
            },
            j_anva_tall_joker = {
                name = 'Tall Joker',
                text = {"Played {C:attention}Bonus Cards{} give",
                        "{C:blue}+#1#{} Chips when scored"
                }
            },
            j_anva_short_joker = {
                name = 'Short Joker',
                text = {"Played {C:attention}Bonus Cards{} give",
                        "{C:red}+#1#{} Mult when scored"
                }
            },
            j_anva_v1 = {
                name = 'V1',
                text = {"{C:attention}X#1#{} value of {C:red}Red Paint",
                "Increases value by {C:attention}X#2#",
                "every {C:attention}#3#{} scored {C:attention}Steel Cards",
                "{C:inactive}(Currently {C:attention}#4#{C:inactive}/#3#){}"
                }
            },
            j_anva_sos = {
                name = 'Silent Old Sanctuary',
                text = {"{C:red}+#1#{} Mult and {X:mult,C:white}X#2#{} Mult",
                    "per empty {C:attention}Joker{} slot",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult and {X:mult,C:white}X#4#{C:inactive} Mult"
                }
            },
            j_anva_swordfish = {
                name = 'Swordfish',
                text = {"Played {C:attention}Mult Aces of Spades{} give",
                        "{X:mult,C:white}X#1#{} Mult when scored"
                }
            },
            j_anva_directer = {
                name = 'The Directer',
                text = {"Any Joker, consumable",
                    "and voucher can appear",
                    "in the {C:attention}shop{}, with",
                    "{C:attention}equal chances",
                }
            },
            j_anva_godot = {
                name = 'Godot',
                text = {"Each {C:attention}Tweaked{} Joker",
                    "gives {X:mult,C:white}X#1#{} Mult",
                }
            },
            j_anva_bfm_l = {
                name = "Big Furry Monster",
                anv_subtitle = "Left Half",
                text = {"{C:red}+#1#{} Mult if to the",
                    "left of the {C:attention}Right Half",
                }
            },
            j_anva_bfm_r = {
                name = "Big Furry Monster",
                anv_subtitle = "Right Half",
                text = {"{C:chips}+#1#{} Chips if to the",
                    "right of the {C:attention}Left Half",
                }
            },
            j_anva_everything = {
                name = "Life, the Universe",
                anv_subtitle = "and Everything",
                text = {"{C:attention}All{} future cards are {C:attention}42s",
                    "Scored {C:attention}42s{} give",
                    "{C:red}+#1#{} Mult and {X:mult,C:white}X#2#{} Mult"
                }
            },
            j_anva_memory = {
                name = "Joker from Memory",
                text={
                    "Copies ability of {C:chips}Common",
                    "{C:attention}Joker{} to the right",
                },
            },
            j_anva_tiataxet = {
                name = "Tia & Ta'xet",
                anv_subtitle = "Twins of Ends",
                text={
                    "All held cards are given",
                    "the {C:green}most common{} Rank, Suit,",
                    "{C:attention}Enhancement{}, {C:attention}Seal{}, {C:dark_edition}Edition{} and",
                    "{C:attention}Paint{} amongst held cards"
                },
            },
        },
        Augment={
            c_anva_aug_mother = {
                name = 'Motherboard',
                text = { ""
                }
            },
            c_anva_aug_lever = {
                name = 'Lever',
                text = { ""
                }
            },
            c_anva_aug_rubber = {
                name = 'Rubber',
                text = { "{C:attention}#1#{} Selected Joker",
                    "is made {C:attention}Rubber"
                }
            },
        },
        Enhanced = {
            m_anva_omega = {
                name = "Omega Card",
                text = {"{X:chips,C:white}^#1#{} Chips"}
            },
            m_anva_alpha = {
                name = "Alpha Card",
                text = {"{X:mult,C:white}^#1#{} Mult"}
            },
        },
        Other={
            anva_lever = {
                name = 'Lever',
                text = { ""
                }
            },
            anva_rubber = {
                name = 'Rubber',
                text = { "When {C:red}destroyed{},",
                    "creates a {C:attention}copy",
                    "of itself"
                }
            },
            anva_paint_red = {
                name = 'Red Paint',
                text = { "{C:red}+#1#{} Mult"
                }
            },
            anva_paint_blue = {
                name = 'Blue Paint',
                text = { "{C:chips}+#1#{} Chips"
                }
            },
            anva_paint_green = {
                name = 'Green Paint',
                text = { "{C:red}+#1#{} Discards"
                }
            },
            anva_paint_yellow = {
                name = 'Yellow Paint',
                text = { "Earn {C:money}$#1#{}"
                }
            },
            anva_paint_orange = {
                name = 'Orange Paint',
                text = { "Retriggers {C:attention}#1#{} time"
                }
            },
            anva_paint_pink = {
                name = 'Pink Paint',
                text = { "{C:chips}+#1#{} Chips per {C:anv_pink}Pink",
                    "card in {C:attention}full deck",
                    "{C:chips}+#2#{} Chips per {C:anv_pink}Pink{} Joker",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
                }
            },
            anva_paint_white = {
                name = 'White Paint',
                text = { "{C:chips}+#1#{} Chips",
                    "{C:chips}+#2#{} Chips per other",
                    "{C:attention}Painted{} card in {C:attention}full deck",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
                }
            },
            anva_paint_black = {
                name = 'Black Paint',
                text = { "{X:mult,C:white}X#1#{} Mult",
                "{X:mult,C:white}X#2#{} Mult per other",
                "{C:attention}Painted{} Joker",
                "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
            }
            },
            anva_paint_cyan = {
                name = 'Cyan Paint',
                text = { "{C:chips}+#1#{} Hands"
                }
            },
            anva_paint_purple = {
                name = 'Purple Paint',
                text = { "{C:red}+#1#{} Mult per time",
                    "an {C:attention}High Card{} or",
                    "{C:attention}Straight Flush{} has",
                    "been played this run",
                    "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)"
                }
            },
            anva_paint_brown = {
                name = 'Brown Paint',
                text = { "Copies ability of",
                    "{C:attention}Paint{} to the right"
                }
            },
            p_anva_small_aug_1 = {
                name = "Tinker Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:anv_aug} Augment{} cards",
                },
            },
            p_anva_small_aug_2 = {
                name = "Tinker Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:anv_aug} Augment{} cards",
                },
            },
            p_anva_mid_aug = {
                name = "Jumbo Tinker Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:anv_aug} Augment{} cards",
                },
            },
            p_anva_big_aug  = {
                name = "Mega Tinker Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:anv_aug} Augment{} cards",
                },
            },
        },
        Planet={
            c_anva_no_planet = {
                name = "Literally Just Nothing",
                text={
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                },
            },
        },
        Spectral={},
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_no_planet = "Fucking Nothing",
            k_anva_aug_pack = "Tinker Pack",
            k_anva_prim = "Primordial",
            k_anva_unb = "Unbound",
            k_augment = "Augment Card",
            k_tree_grow = "Grow!",
            k_tree3_grow = "Grow(3)!",
            k_discards = "+1 Discrds",
            k_hands = "+1 Hands",
            k_blue = "Blue",
            k_sans_tag = "Skele-tag",
            k_dedebuffed = "De-debuffed",
            k_plus_negative = "Negative",
            b_augment_cards = "Augment Cards",
            anva_tweak_ui = "Tweaks",
            anva_paint_ui = "Paints",
            anva_nothinghand = "Nothing"
        },
        high_scores={},
        labels={
            anva_prim = "Primordial",
            anva_unb = "Unbound",
            anva_paint_red = "Red Paint",
            anva_paint_blue = "Blue Paint",
            anva_paint_green = "Green Paint",
            anva_paint_yellow = "Yellow Paint",
            anva_paint_orange = "Orange Paint",
            anva_paint_pink = "Pink Paint",
            anva_paint_cyan = "Cyan Paint",
            anva_paint_purple = "Purple Paint",
            anva_paint_brown = "Brown Paint",
            anva_paint_white = "White Paint",
            anva_paint_black = "Black Paint",
        },
        poker_hand_descriptions={
            anva_nothinghand = {"..."}
        },
        poker_hands={
            anva_nothinghand = "Nothing"
        },
        quips={},
        ranks={
            anva_42 = "42",
            anva_11 = "11",
            anva_12 = "12",
            anva_13 = "13",
            anva_14 = "14",
            anva_15 = "15",
            anva_16 = "16",
            anva_17 = "17",
            anva_18 = "18",
            anva_19 = "19",
            anva_20 = "20",
            anva_alpha_rank = "Alpha",
            anva_omega_rank = "Omega",
            anva_rankless = "Nothing",
        },
        suits_plural={
            anva_greek = "Greek",
            anva_suitless = "Nothing"
        },
        suits_singular={
            anva_greek = "Greek",
            anva_suitless = "Nothing"
        },
        tutorial={},
        v_dictionary={
            ml_anva_paint_green_desc = "Pink Paint",
        },
        v_text={},
    },
}