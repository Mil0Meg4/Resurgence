return {
    descriptions = {
        Back={
            b_rsgc_number20 = {
                name = "Deck of Numbers",
                text = {"Start with {C:attention}numbered{}",
                "ranks from {C:attention}0.1{} to {C:attention}20"
            }
            },
        },
        Blind={},
        Edition={
            e_rsgc_divine = {
                name = "Divine",
                text = {
                    "Upgrade played",
                    "hand {C:attention}#1#{} time"
                }
            },
            e_rsgc_faustian = {
                name = "Faustian",
                text = {
                    "Earn {C:money}$#1#{}",
                }
            }
        },
        Joker={
            j_rsgc_sigma = {
                name = 'SIGMA',
                text = { "the next {C:purple}Tarot{} card used",
                         "{C:attention}transforms{} this Joker into",
                          "a {C:dark_edition}unique{} {C:attention}Joker{} based off",
                          "the used card"
                }
            },
            j_rsgc_charon = {
                name = 'Charon',
                text = { "Quintuples money",
                        "at the end of Shop",
                         "{C:inactive}(Max of {C:money}$#1#{C:inactive}){}"
                }
            },
            j_rsgc_gabriel = {
                name = 'Gabriel',
                rsgc_subtitle = "Judge of Hell",
                text = {"At end of {C:money}shop{},",
                        "adds {C:dark_edition}Divine{} to",
                        "Joker to the right",
                        "Each {C:dark_edition}Divine{} Joker",
                        "gives {X:mult,C:white}X#1#{} Mult"
                }
            },
            j_rsgc_gaba = {
                name = 'Gabriel',
                rsgc_subtitle = "Apostate of Hate",
                text = {"At end of {C:money}shop{},",
                        "{C:red}removes{} {C:dark_edition}Divine{} from",
                        "Joker to the right",
                        "to gain {X:mult,C:white}^#2#{} Mult",
                        "{C:inactive}(Currently {X:mult,C:white}^#1#{C:inactive} Mult)"
                }
            },
            j_rsgc_sinclair = {
                name = 'Sinclair',
                text = {"Earns {C:money}$#1#{} at end of round.",
                        "When Shop is entered, if you have {C:money}$#2#{}",
                        "or more {C:red}debuffs{} all other {C:attention}Jokers{} until",
                        "you have {C:money}$0{} or less when exiting."
                },
            },
            j_rsgc_pugnala = {
                name = 'Pugnala',
                text = { "{X:mult,C:white}X#1#{} Mult if played",
                         "hand contains only",
                         "{C:clubs}Clubs{} and {C:diamonds}Diamonds{}"
                }
            },
            j_rsgc_frisk = {
                name = 'Frisk',
                text = { "{C:chips}+#1#{} Chips for",
                         "each {C:attention}unique rarity",
                         "among owned {C:attention}Jokers",
                         "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },            
            j_rsgc_saya = {
                name = 'Saya Sakura',
                text = { "{C:chips}+#1#{} Chips or {C:mult}+#2#{} Mult",
                         "Switches every hand",
                         "{C:inactive}(Currently {C:attention}#3#{C:inactive})"
                }
            },
            j_rsgc_papyrus = {
                name = 'Papyrus',
                text = {"If played hand has",
                        "only {C:attention}1{} card, {C:attention}paint{} ",
                        "played cards {C:chips}Blue{}",
                        "before scoring"
                }
            },
            j_rsgc_kai = {
                name = 'Bi Kai',
                text = {
                        "{C:purple}+#1#{} Chips and Mult",
                        "{C:attention}Pair{} per played this run",
                        "{C:inactive}(Currently {C:purple}+#2#{C:inactive} Chips and Mult)"
                }
            },
            j_rsgc_kate = {
                name = 'Straight Kate',
                text = {
                        "{C:chips}+#1#{} Chips per {C:attention}Straight{} ",
                        "played this run",
                        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_rsgc_sans = {
                name = 'Sans',
                text = {"When selecting {C:attention}Blind{}, get",
                    "its associated {C:attention}Skip Tag.",
                    "When skipping {C:attention}Blind{}, this",
                    "Joker gains {C:chips}+#2#{} Chips for",
                    "each {C:rsgc_under}Undertale{} Joker",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_rsgc_doom = {
                name = 'Doom Itself',
                text = { "{C:chips}+#1#{} Chips, or {C:chips}+#2#{} Chips if all",
                    "cards in {C:attention}full deck{} are {C:attention}Stone Cards",
                    "{C:red}Destroy{} a random non-{C:attention}Stone{} card from your",
                    "deck when a {C:attention}Stone Card{} is scored"
                }
            },
            j_rsgc_bartender = {
                name = 'Bartender',
                text = { "{C:attention}+#2#{} Consumable Slot",
                    "{C:red}+#1#{} Mult per {C:attention}consumable{} held",
                    "{C:inactive}(Currently {C:red}+#3#{C:inactive} Mult)"
                }
            },
            j_rsgc_andromeda = {
                name = 'Andromeda',
                text = { "Create a {C:attention}The Star {C:purple}Tarot",
                    "and add {C:money}$#1# {C:attention}sell value{} to",
                    "all {C:attention}Consumables{} when a",
                    "{C:diamonds}Diamond{} is scored",
                    "{C:inactive}(Mult have room)"
                }
            },
            j_rsgc_tree = {
                name = 'Tree',
                text = { "{C:mult}+#1#{} Mult",
                         "{C:mult}+#2#{} Mult at end of round"
                }
            },
            j_rsgc_tree3 = {
                name = 'Tree(3)',
                text = { "{X:mult,C:white}^^^#1#{} Mult",
                         "{X:mult,C:white}^^^#2#{} Mult at end of round"
                }
            },
            j_rsgc_poe = {
                name = 'Poe',
                text = {"Scored {C:hearts}Hearts{} give {C:mult}+#1#{} Mult",
                        "Every other {C:hearts}Hearts{} card scored",
                        "consecutively, starting at the {C:attention}3rd{},",
                        "{C:attention}Doubles{} this gain until end of {C:attention}blind",
                        "{C:inactive}(eg. +4, +4, +8, +8, +16){}"
                }
            },
            j_rsgc_jandc = {
                name = 'Johnathon & Charlotte',
                text = {"{C:attention}+#2#{} Consumable Slots",
                        "{C:chips}-#1#{} Chips for every non-{C:dark_edition}negative{}",
                        "consumable held over {C:attention}4",
                        "{C:inactive}(Currently {C:chips}-#3#{C:inactive} Chips)"
                }
            },
            j_rsgc_pride_rainbow = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted"
                }
            },
            j_rsgc_pride_bi = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:red}Red{}, {C:purple}Purple{} or {C:chips}Blue"
                }
            },
            j_rsgc_pride_pan = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:rsgc_pink}Pink{}, {C:money}Yellow{} or {C:rsgc_cyan}Cyan"
                }
            },
            j_rsgc_pride_gay = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:rsgc_cyan}Cyan{}, {C:inactive}White{} or {C:chips}Blue"
                }
            },
            j_rsgc_pride_nb = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:money}Yellow{}, {C:purple}Purple{} or {C:rsgc_black}Black"
                }
            },
            j_rsgc_pride_trans = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:chips}Blue{}, {C:rsgc_pink}Pink{} or {C:inactive}White"
                }
            },
            j_rsgc_pride_ace = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:rsgc_black}Black{}, {C:inactive}White{} or {C:purple}Purple"
                }
            },
            j_rsgc_pride_aro = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:green}Green{}, {C:inactive}White{} or {C:rsgc_black}Black{}"
                }
            },
            j_rsgc_pride_aroace = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:money}Yellow{}, {C:inactive}White{} or {C:chips}Blue"
                }
            },
            j_rsgc_pride_lesbian = {
                name = 'Pride Flag',
                text = { "All cards and Jokers",
                    "in {C:attention}booster{} are {C:attention}Painted",
                    "{C:attention}Orange{}, {C:inactive}White{} or {C:purple}Purple"
                }
            },
            j_rsgc_filth = {
                name = 'Filth',
                text = { "{C:mult}+#2#{} Mult and {C:chips}+#1#{} Chips"
                }
            },
            j_rsgc_alphys = {
                name = 'Alphys',
                rsgc_subtitle = "The Royal Scientist",
                text = { "Create a {C:attention}Blueprint",
                    "when selecting {C:attention}Boss Blind",
                    "{C:inactive}(Mult have room)"
                }
            },
            j_rsgc_gaster = {
                name = 'Gaster',
                rsgc_subtitle = "The Royal Scientist",
                text = { "{C:attention}+6{} Joker Slots, Consumable Slots,",
                    "Handsize, and Shop Slots",
                    "Scored {C:attention}6s{} give {C:chips}+66{}",
                    "Chips and {C:mult}+6{} Mult",
                    "After {C:attention}66{} {C:attention}6s{} are scored,",
                    "get {C:attention}6 Negative Tags{}",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}/66){}"
                }
            },
            j_rsgc_triangleJoke = {
                name = 'Triangle Joker',
                text = { "Each played {C:attention}3{} gives",
                    "{X:mult,C:white}X#1#{} Mult when scored",
                    "if played hand has",
                    "exactly {C:attention}3{} cards"
                }
            },
            j_rsgc_catJoker = {
                name = 'Cat Joker',
                text = { "{C:attention}Retrigger{} each played {C:attention}3{}",
                    "{C:attention}#1#{} time per {C:attention}3{} held in hand"
                }
            },
            j_rsgc_sly = {
                name = 'Sly',
                text = { "Earn {C:money}$#1#{} when",
                    "a card or Joker",
                    "is {C:attention}Retriggered"
                }
            },
            j_rsgc_nailsage = {
                name = 'Great Nailsage Sly',
                text = { "Earn {C:money}$#1#{} when a card ",
                    "or Joker is {C:attention}Retriggered",
                    "{X:mult,C:white}X#2#{} mult for",
                    "each {C:money}$#3#{} you have",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult"
                }
            },
            j_rsgc_sheo = {
                name = 'Paintmaster Sheo',
                text = { "Retrigger all played",
                    "{C:attention}Painted{} cards and",
                    "all {C:attention}Painted{} Jokers"
                }
            },
            j_rsgc_sappho = {
                name = 'Sappho of Lesbos',
                text = { "Retrigger all played",
                    "{C:spades}Spades{}, {C:hearts}Hearts{}, {C:clubs}Clubs{},",
                    "{C:diamonds}Diamonds{}, and {C:attention}Wild{} cards {C:attention}#1#{} times"
                }
            },
            j_rsgc_mini_mice = {
                name = 'Mini Mice',
                text = {"{C:red}+#1#{} Mult",
                    "All hands are considered",
                    "to be a {C:attention}High Card"
                }
            },
            j_rsgc_tall_joker = {
                name = 'Tall Joker',
                text = {"Played {C:attention}Bonus Cards{} give",
                        "{C:blue}+#1#{} Chips when scored"
                }
            },
            j_rsgc_short_joker = {
                name = 'Short Joker',
                text = {"Played {C:attention}Mult Cards{} give",
                        "{C:red}+#1#{} Mult when scored"
                }
            },
            j_rsgc_frankenjoker = {
                name = 'Frankenjoker',
                text = {"Played {C:attention}Wild Cards{} permanently",
                        "gain either {C:blue}+#1#{} Chips or",
                        "{C:red}+#2#{} Mult randomly when scored"
                }
            },
            j_rsgc_punker = {
                name = 'Punk Joker',
                text = {"Gains {C:red}+#1#{} Mult when each played",
                        "{C:attention}Mult Card{} is scored, gains {C:red}+#2#{} Mult",
                        "instead if a {C:attention}Steel Card{} held in hand",
                        "{C:inactive}(Currently {C:red}+#3#{C:inactive} Mult)"
                }
            },
            j_rsgc_v1 = {
                name = 'V1',
                text = {"{C:attention}X#1#{} value of {C:red}Red Paint",
                "Increases by {C:attention}X#2#{} every",
                "{C:attention}#3#{} {C:inactive}[#4#]{} {C:attention}Steel Cards{} scored",
                "Whenever a Joker is",
                "{C:attention}Tweaked{}, paint it {C:red}Red",
                }
            },
            j_rsgc_sos = {
                name = 'Silent Old Sanctuary',
                text = {"{C:red}+#1#{} Mult and {X:mult,C:white}X#2#{} Mult",
                    "per empty {C:attention}Joker{} slot",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult and {X:mult,C:white}X#4#{C:inactive} Mult"
                }
            },
            j_rsgc_swordfish = {
                name = 'Swordfish',
                text = {"Played {C:attention}Mult Aces of Spades{} give",
                        "{X:mult,C:white}X#1#{} Mult when scored"
                }
            },
            j_rsgc_directer = {
                name = 'The Directer',
                text = {"Any Joker, consumable",
                    "and voucher can appear",
                    "in the {C:attention}shop{}, with",
                    "{C:attention}equal chances",
                }
            },
            j_rsgc_godot = {
                name = 'Godot',
                text = {"Each {C:attention}Tweaked{} Joker",
                    "gives {X:mult,C:white}X#1#{} Mult",
                }
            },
            j_rsgc_everything = {
                name = "Life, the Universe",
                rsgc_subtitle = "and Everything",
                text = {"{C:attention}All{} future cards are {C:attention}42s",
                    "Scored {C:attention}42s{} give",
                    "{C:red}+#1#{} Mult and {X:mult,C:white}X#2#{} Mult"
                }
            },
            j_rsgc_memory = {
                name = "Joker from Memory",
                text={
                    "Copies ability of {C:chips}Common",
                    "{C:attention}Joker{} to the right",
                },
            },
            j_rsgc_tiataxet = {
                name = "Tia & Ta'xet",
                rsgc_subtitle = "Twins of Ends",
                text={
                    "All held cards are given",
                    "the {C:green}most common{} Rank, Suit,",
                    "{C:attention}Enhancement{}, {C:attention}Seal{}, {C:dark_edition}Edition{} and",
                    "{C:attention}Paint{} amongst held cards"
                },
            },
            j_rsgc_jimbo = {
                name = "Jimbo",
                rsgc_subtitle = "True Form",
                text = {
                    "{C:mult}+#1#{} Mult",
                },
                unlock={
                    "Start the",
                    "{C:rsgc_primordial}Resurgence",
                },
            },
            j_rsgc_boykisser = {
                name = "Boykisser",
                text = {"Create a {C:rsgc_gay}Boykisser Tag",
                    "if played hand contains {C:attention}2{}",
                    "scoring {C:attention}Kings{} or {C:attention}Jacks",
                },
            },
            j_rsgc_42wallbreak = {
                name = "42nd Wall Break",
                text = {"Retrigger all",
                    "played {C:attention}42s #1#{} times"
                },
            },
            j_rsgc_hampter = {
                name = "Hampter",
                text = {"When a {C:attention}Micro{} card is",
                    "scored, this Joker gains",
                    "{X:mult,C:white}X1{} Mult times its {C:attention}rank",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                },
            },
            j_rsgc_whoa={
                name="WHOA Joker",
                text={
                    "This Joker gains",
                    "{C:chips}+#2#{} Chips when each",
                    "played {C:attention}20{} is scored",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                },
            },
            j_rsgc_shard={
                name="Prismatic Shard",
                text={
                    "All Jokers in {C:attention}Buffon",
                    "{C:attention}Packs{} are {C:attention}Obelisks",
                    "{C:dark_edition}Transforms{} after",
                    "obtaining {C:attention}3 Obelisks"
                },
            },
            j_rsgc_gsword={
                name="Galaxy Sword",
                text={
                    "{X:mult,C:white}X#1#{} Mult",
                    "All cards in {C:spectral}Spectral",
                    "{C:attention}Packs{} are {C:dark_edition}Galaxy Souls",
                    "{C:dark_edition}Transforms{} after using 3 {C:inactive}[#2#]{}",
                },
            },
            j_rsgc_msword={
                name="Master Sword",
                text={
                    "{C:chips}+#1#{} Chips {C:mult}+#2#{} Mult",
                    "{X:chips,C:white}X#3#{} Chips {X:mult,C:white}X#4#{} Mult",
                },
            },
        },
        Augment={
            c_rsgc_aug_mother = {
                name = 'Motherboard',
                text = { ""
                }
            },
            c_rsgc_aug_lever = {
                name = 'Lever',
                text = { "{C:attention}#1#{} selected Joker",
                    "is given a {C:attention}Lever{}",
                }
            },
            c_rsgc_aug_kintsugi = {
                name = 'Kintsugi',
                text = { "{C:attention}#1#{} selected Joker",
                    "is made {C:attention}Gilded{}",
                }
            },
            c_rsgc_aug_rubber = {
                name = 'Rubber',
                text = { "{C:attention}#1#{} selected Joker",
                    "loses all {C:attention}Stickers{}",
                    "and is made {C:attention}Rubber"
                }
            },
            c_rsgc_aug_polar = {
                name = 'Polar Inversion',
                text = { "{C:dark_edition}Invert{} all values of up",
                "to {C:attention}#1#{} selected Jokers",
                "{C:inactive}(ex: {C:attention}12{C:inactive} becomes {C:attention}-12{C:inactive})",
                }
            },
            c_rsgc_aug_tinfoil = {
                name = 'Tinfoil',
                text = { "",
                }
            },
        },
        Enhanced = {
            m_rsgc_omega = {
                name = "Omega Card",
                text = {"{X:chips,C:white}^#1#{} Chips"}
            },
            m_rsgc_alpha = {
                name = "Alpha Card",
                text = {"{X:mult,C:white}^#1#{} Mult"}
            },
        },
        Other={
            rsgc_mother = {
                name = 'Motherboard',
                text = { "Sets all Values to 1",
                    "at end of shop"
                }
            },
            rsgc_lever = {
                name = 'Lever',
                text = { "{C:attention}X#1#{} to all values",
                "increases by {C:attention}#2#{} after",
                "hand is played",
                "{C:attention}Resets{} after defeating",
                "{C:attention}Boss Blind{} with {C:attention}X#3#{} or more"
                }
            },
            rsgc_gilded = {
                name = 'Gilded',
                text = { "Earns {C:money}$#1#{} instead of",
                "giving {C:chips}Chips{} or {C:red}Mult",
                "{C:inactive}(Additve Chips/Mult only)",
                }
            },
            rsgc_rubber = {
                name = 'Rubber',
                text = { "When {C:red}destroyed{},",
                    "creates a {C:attention}copy",
                    "of itself"
                }
            },
            rsgc_paint_red = {
                name = 'Red Paint',
                text = { "{C:red}+#1#{} Mult"
                }
            },
            rsgc_paint_blue = {
                name = 'Blue Paint',
                text = { "{C:chips}+#1#{} Chips"
                }
            },
            rsgc_paint_green = {
                name = 'Green Paint',
                text = { "{C:red}+#1#{} Discards"
                }
            },
            rsgc_paint_yellow = {
                name = 'Yellow Paint',
                text = { "Earn {C:money}$#1#{}"
                }
            },
            rsgc_paint_orange = {
                name = 'Orange Paint',
                text = { "Retriggers {C:attention}#1#{} time"
                }
            },
            rsgc_paint_pink = {
                name = 'Pink Paint',
                text = { "{C:chips}+#1#{} Chips per {C:rsgc_pink}Pink",
                    "Joker and {C:rsgc_pink}Pink{}",
                    "card in {C:attention}full deck",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            rsgc_paint_white = {
                name = 'White Paint',
                text = { "{C:chips}+#1#{} Chips",
                    "{C:chips}+#2#{} Chips per other",
                    "{C:attention}Painted{} card in {C:attention}full deck",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
                }
            },
            rsgc_paint_black = {
                name = 'Black Paint',
                text = { "{X:mult,C:white}X#1#{} Mult",
                "{X:mult,C:white}X#2#{} Mult per other",
                "{C:attention}Painted{} Joker",
                "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
            }
            },
            rsgc_paint_cyan = {
                name = 'Cyan Paint',
                text = { "{C:chips}+#1#{} Hands"
                }
            },
            rsgc_paint_purple = {
                name = 'Purple Paint',
                text = { "{C:chips}+#2#{} Chips",
                    "{C:red}+#1#{} Mult"
                }
            },
            rsgc_paint_brown = {
                name = 'Brown Paint',
                text = { "Copies ability of",
                    "{C:attention}Paint{} to the right"
                }
            },
            p_rsgc_small_aug_1 = {
                name = "Tinker Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:rsgc_aug} Augment{} cards",
                },
            },
            p_rsgc_small_aug_2 = {
                name = "Tinker Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:rsgc_aug} Augment{} cards",
                },
            },
            p_rsgc_mid_aug = {
                name = "Jumbo Tinker Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:rsgc_aug} Augment{} cards",
                },
            },
            p_rsgc_big_aug  = {
                name = "Mega Tinker Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:rsgc_aug} Augment{} cards",
                },
            },
            p_rsgc_gay = {
                name = "Gay Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:rsgc_gay} Gay{} jokers",
                },
            },
            m_rsgc_micro_ranks = {
                name = "Micro Ranks",
                text = {
                    "(ie; {C:attention}0.1{}, {C:attention}0.2{}, {C:attention}0.3{}, {C:attention}0.4{}, {C:attention}0.5{},",
                    "{C:attention}0.6{}, {C:attention}0.7{}, {C:attention}0.8{}, {C:attention}0.9{} and {C:attention}1{})",
                }
            },
            m_rsgc_macro_ranks = {
                name = "Macro Ranks",
                text = {
                    "(ie; {C:attention}11{}, {C:attention}12{}, {C:attention}13{}, {C:attention}14{}, {C:attention}15{}, {C:attention}16{}, ",
                    "{C:attention}17{}, {C:attention}18{}, {C:attention}19{}, {C:attention}20{}, {C:attention}42{}, {C:attention}69{}, and {C:attention}Googol{})",
                }
            },
        },
        Planet={
            c_rsgc_no_planet = {
                name = "Literally Just Nothing",
                text={
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                },
            },
        },
        Spectral={
            c_rsgc_gsoul = {
                name = "Galaxy Soul",
                text={
                    "{s:0.8,C:inactive}a mystical artifact, to attain", 
                    "{s:0.8,C:inactive}unlimited power and then didn't", 
                    "{s:0.8,C:inactive}buy it for 40 gems at least"
                },
            },
        },
        Stake={},
        Tag={
            tag_rsgc_boy = {
                name = "Boykisser Tag",
                text = {
                    "Gives a free",
                    "{C:rsgc_gay}Gay Pack",
                },
            },
        },
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
            k_kiss = "Kiss :3",
            k_no_planet = "Fucking Nothing",
            k_rsgc_aug_pack = "Tinker Pack",
            k_rsgc_gay = "Gay Pack",
            k_rsgc_prim = "Primordial",
            k_rsgc_super_rare = "Absurd",
            k_rsgc_unb = "Unbound",
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
            k_blueprinted = "Blueprint",
            rsgc_tweak_ui = "Tweaks",
            rsgc_paint_ui = "Paints",
            rsgc_nothinghand = "Nothing",
            rsgc_chips = "Chips",
            rsgc_mult = "Mult",
        },
        high_scores={},
        labels={
            rsgc_prim = "Primordial",
            rsgc_super_rare = "Absurd",
            rsgc_unb = "Unbound",
            rsgc_paint_red = "Red Paint",
            rsgc_paint_blue = "Blue Paint",
            rsgc_paint_green = "Green Paint",
            rsgc_paint_yellow = "Yellow Paint",
            rsgc_paint_orange = "Orange Paint",
            rsgc_paint_pink = "Pink Paint",
            rsgc_paint_cyan = "Cyan Paint",
            rsgc_paint_purple = "Purple Paint",
            rsgc_paint_brown = "Brown Paint",
            rsgc_paint_white = "White Paint",
            rsgc_paint_black = "Black Paint",
            rsgc_faustian = "Faustian",
            rsgc_divine = "Divine",
        },
        poker_hand_descriptions={
            rsgc_nothinghand = {"..."}
        },
        poker_hands={
            rsgc_nothinghand = "Nothing"
        },
        quips={},
        ranks={
            rsgc_googol = "Googol",
            rsgc_42 = "42",
            rsgc_11 = "11",
            rsgc_12 = "12",
            rsgc_13 = "13",
            rsgc_14 = "14",
            rsgc_15 = "15",
            rsgc_16 = "16",
            rsgc_17 = "17",
            rsgc_18 = "18",
            rsgc_19 = "19",
            rsgc_20 = "20",
            rsgc_01 = "0.1",
            rsgc_02 = "0.2",
            rsgc_03 = "0.3",
            rsgc_04 = "0.4",
            rsgc_05 = "0.5",
            rsgc_06 = "0.6",
            rsgc_07 = "0.7",
            rsgc_08 = "0.8",
            rsgc_09 = "0.9",
            rsgc_1 = "1",
            rsgc_alpha_rank = "Alpha",
            rsgc_omega_rank = "Omega",
            rsgc_rankless = "Nothing",
        },
        suits_plural={
            rsgc_greek = "Greek",
            rsgc_suitless = "Nothing"
        },
        suits_singular={
            rsgc_greek = "Greek",
            rsgc_suitless = "Nothing"
        },
        v_dictionary={
            ml_rsgc_paint_green_desc = "Pink Paint",
        },
        v_text={},
        tutorial = {
			rsgc_intro_1 = {
				"Hey buddy! You broke the",
				"{C:dark_edition,E:1}seals{} and summoned the",
                "spirits of {C:edition,E:1}Light{} and {C:dark_edition,E:1}Dark{}!",
			},
            rsgc_intro_2 = {
				"Or something like that,",
                "i don't remember"
			},
            rsgc_intro_3 = {
				"Luckily, my {C:dark_edition,E:1}true powers{} have",
                "been unleashed too, those spirits",
                "stand {C:red}no chance{} against them!"

			},
        }
    },
}