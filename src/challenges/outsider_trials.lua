SMODS.Challenge {
    key = 'kyra_trial',
    loc_txt = {
        name = "Kyra's Wish: Potion Mastery",
    },
    rules = {
        custom = {
            { id = 'no_reward' },
        },
        modifiers = {},
    },
    jokers = {
        { id = 'j_reality_warp_kyra', eternal = true },
        { id = 'j_reality_warp_potion_brewer', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            { id = 'c_fool' }, { id = 'c_magician' }, { id = 'c_high_priestess' },
            { id = 'c_empress' }, { id = 'c_emperor' }, { id = 'c_hierophant' },
            { id = 'c_lovers' }, { id = 'c_chariot' }, { id = 'c_justice' },
            { id = 'c_hermit' }, { id = 'c_wheel_of_fortune' }, { id = 'c_strength' },
            { id = 'c_hanged_man' }, { id = 'c_death' }, { id = 'c_temperance' },
            { id = 'c_devil' }, { id = 'c_tower' }, { id = 'c_star' },
            { id = 'c_moon' }, { id = 'c_sun' }, { id = 'c_judgement' }, { id = 'c_world' },
            { id = 'c_familiar' }, { id = 'c_grim' }, { id = 'c_incantation' },
            { id = 'c_talisman' }, { id = 'c_aura' }, { id = 'c_wraith' },
            { id = 'c_sigil' }, { id = 'c_ouija' }, { id = 'c_ectoplasm' },
            { id = 'c_immolate' }, { id = 'c_ankh' }, { id = 'c_deja_vu' },
            { id = 'c_hex' }, { id = 'c_trance' }, { id = 'c_medium' },
            { id = 'c_cryptid' }, { id = 'c_soul' }, { id = 'c_black_hole' },
        },
    },
}

SMODS.Challenge {
    key = 'ray_trial',
    loc_txt = {
        name = "Ray's Wish: Spectral Rift",
    },
    rules = {
        custom = {},
        modifiers = {},
    },
    jokers = {
        { id = 'j_reality_warp_raytracing', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            { id = 'c_soul' },
            { id = 'c_reality_warp_warp_portal' },
            { id = 'c_warp_portal' },
            { id = 'c_fool' }, { id = 'c_magician' }, { id = 'c_high_priestess' },
            { id = 'c_empress' }, { id = 'c_emperor' }, { id = 'c_hierophant' },
            { id = 'c_lovers' }, { id = 'c_chariot' }, { id = 'c_justice' },
            { id = 'c_hermit' }, { id = 'c_wheel_of_fortune' }, { id = 'c_strength' },
            { id = 'c_hanged_man' }, { id = 'c_death' }, { id = 'c_temperance' },
            { id = 'c_devil' }, { id = 'c_tower' }, { id = 'c_star' },
            { id = 'c_moon' }, { id = 'c_sun' }, { id = 'c_judgement' }, { id = 'c_world' },
        },
    },
}

SMODS.Challenge {
    key = 'charles_trial',
    loc_txt = {
        name = "Charles' Wish: Heart of Gold",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'win_ante', value = 999999 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_charles', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            { id = 'c_moon' },
            { id = 'c_star' },
            { id = 'c_world' },
            { id = 'c_sigil' },
        },
    },
}

SMODS.Challenge {
    key = 'mochi_trial',
    loc_txt = {
        name = "Mochi's Wish: Wild Wonderland",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'win_ante', value = 999999 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_mochi', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            { id = 'c_fool' }, { id = 'c_magician' }, { id = 'c_high_priestess' },
            { id = 'c_empress' }, { id = 'c_emperor' }, { id = 'c_hierophant' },
            { id = 'c_lovers' }, { id = 'c_chariot' }, { id = 'c_justice' },
            { id = 'c_hermit' }, { id = 'c_wheel_of_fortune' }, { id = 'c_strength' },
            { id = 'c_hanged_man' }, { id = 'c_death' }, { id = 'c_temperance' },
            { id = 'c_devil' }, { id = 'c_tower' }, { id = 'c_star' },
            { id = 'c_moon' }, { id = 'c_sun' }, { id = 'c_judgement' }, { id = 'c_world' },
        },
    },
}

SMODS.Challenge {
    key = 'paco_trial',
    loc_txt = {
        name = "Paco's Wish: One Hand Wonder",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'hands', value = 1 },
            { id = 'discards', value = 5 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_paco', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            { id = 'v_grabber' },
            { id = 'v_nacho_tong' },
            { id = 'c_fool' }, { id = 'c_magician' }, { id = 'c_high_priestess' },
            { id = 'c_empress' }, { id = 'c_emperor' }, { id = 'c_hierophant' },
            { id = 'c_lovers' }, { id = 'c_chariot' }, { id = 'c_justice' },
            { id = 'c_hermit' }, { id = 'c_wheel_of_fortune' }, { id = 'c_strength' },
            { id = 'c_hanged_man' }, { id = 'c_death' }, { id = 'c_temperance' },
            { id = 'c_devil' }, { id = 'c_tower' }, { id = 'c_star' },
            { id = 'c_moon' }, { id = 'c_sun' }, { id = 'c_judgement' }, { id = 'c_world' },
            { id = 'c_familiar' }, { id = 'c_grim' }, { id = 'c_incantation' },
            { id = 'c_talisman' }, { id = 'c_aura' }, { id = 'c_wraith' },
            { id = 'c_sigil' }, { id = 'c_ouija' }, { id = 'c_ectoplasm' },
            { id = 'c_immolate' }, { id = 'c_ankh' }, { id = 'c_deja_vu' },
            { id = 'c_hex' }, { id = 'c_trance' }, { id = 'c_medium' },
            { id = 'c_cryptid' }, { id = 'c_soul' }, { id = 'c_black_hole' },
        },
        banned_other = {},
    },
}

SMODS.Challenge {
    key = 'esteban_trial',
    loc_txt = {
        name = "Esteban's Wish: Dark Ascension",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'win_ante', value = 999999 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_esteban', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            { id = 'c_sun' },
            { id = 'c_star' },
        },
    },
}

SMODS.Challenge {
    key = 'thiago_trial',
    loc_txt = {
        name = "Thiago's Wish: Chips Dominion",
    },
    rules = {
        custom = {},
        modifiers = {},
    },
    jokers = {
        { id = 'j_reality_warp_thiago', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            { id = 'j_joker' }, { id = 'j_greedy_joker' }, { id = 'j_lusty_joker' },
            { id = 'j_wrathful_joker' }, { id = 'j_glutinous_joker' }, { id = 'j_jolly' },
            { id = 'j_zany' }, { id = 'j_mad' }, { id = 'j_crazy' }, { id = 'j_droll' },
            { id = 'j_half' }, { id = 'j_stencil' }, { id = 'j_ceremonial' },
            { id = 'j_mystic_summit' }, { id = 'j_misprint' }, { id = 'j_steel_joker' },
            { id = 'j_abstract' }, { id = 'j_gros_michel' }, { id = 'j_even_steven' },
            { id = 'j_scholar' }, { id = 'j_supernova' }, { id = 'j_ride_the_bus' },
            { id = 'j_blackboard' }, { id = 'j_constellation' }, { id = 'j_green_joker' },
            { id = 'j_cavendish' }, { id = 'j_card_sharp' }, { id = 'j_red_card' },
            { id = 'j_madness' }, { id = 'j_vampire' }, { id = 'j_hologram' },
            { id = 'j_baron' }, { id = 'j_obelisk' }, { id = 'j_caino' },
            { id = 'j_triboulet' }, { id = 'j_the_duo' }, { id = 'j_the_trio' },
            { id = 'j_the_family' }, { id = 'j_the_order' }, { id = 'j_the_tribe' },
            { id = 'j_driver_license' }, { id = 'j_bootstraps' }, { id = 'j_swashbuckler' },
            { id = 'j_acrobat' }, { id = 'j_sock_and_buskin' }, { id = 'j_flower_pot' },
        },
    },
}

SMODS.Challenge {
    key = 'yairo_trial',
    loc_txt = {
        name = "Yairo's Wish: Sixes & Sevens",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'win_ante', value = 999999 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_yairo', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {},
    },
}

SMODS.Challenge {
    key = 'helin_trial',
    loc_txt = {
        name = "Helin's Wish: Lone Celestial",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'joker_slots', value = 1 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_helin', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            { id = 'c_fool' }, { id = 'c_magician' }, { id = 'c_high_priestess' },
            { id = 'c_empress' }, { id = 'c_emperor' }, { id = 'c_hierophant' },
            { id = 'c_lovers' }, { id = 'c_chariot' }, { id = 'c_justice' },
            { id = 'c_hermit' }, { id = 'c_wheel_of_fortune' }, { id = 'c_strength' },
            { id = 'c_hanged_man' }, { id = 'c_death' }, { id = 'c_temperance' },
            { id = 'c_devil' }, { id = 'c_tower' }, { id = 'c_star' },
            { id = 'c_moon' }, { id = 'c_sun' }, { id = 'c_judgement' }, { id = 'c_world' },
        },
    },
}

SMODS.Challenge {
    key = 'calamari_trial',
    loc_txt = {
        name = "Calamari Wish: Squid Sisters",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'joker_slots', value = 2 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_marie', eternal = true },
        { id = 'j_reality_warp_callie', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {},
    },
}

SMODS.Challenge {
    key = 'sally_trial',
    loc_txt = {
        name = "Sally's Wish: Quest Master",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'win_ante', value = 999999 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_sally', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {},
    },
}

SMODS.Challenge {
    key = 'cefalopop_trial',
    loc_txt = {
        name = "Off the Hook: Cephalopop Harmony",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'joker_slots', value = 2 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_marina', eternal = true },
        { id = 'j_reality_warp_perla', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {},
    },
}

SMODS.Challenge {
    key = 'mew_mew_trial',
    loc_txt = {
        name = "Mew Mew's Wish: Doki Doki Rush",
    },
    rules = {
        custom = {},
        modifiers = {
            { id = 'win_ante', value = 999999 },
        },
    },
    jokers = {
        { id = 'j_reality_warp_mew_mew', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {},
    },
}

local OUTSIDER_TRIALS_DATA = {
    {
        id = 'paco',
        name = "PACO",
        title = "PACO'S WISH: ONE HAND STAND",
        dominant_color = HEX('eab308'),
        accent = HEX('ebb746'),
        bg_color = HEX('2e1a05'),
        jokers = { 'j_reality_warp_paco' },
        quote = "\"One shot, that's all you get! Burn through your 5 discards and make that single hand count.\"",
        rules = {
            "Win Condition: Ante 8",
            "Hands locked to exactly 1 every round",
            "Discards set to 5 every round",
            "Only Planet cards appear and function",
        },
        deck_rules = {
            "Starting Joker: Paco (Eternal)",
            "Hands: 1 per round (Grabber & Nacho Tong banned)",
            "Discards: 5 per round (Wasteful & Recycler enabled!)",
            "Consumables: 100% Celestial & Planet cards",
        },
        challenge_id = 'c_reality_warp_paco_trial',
    },
    {
        id = 'esteban',
        name = "ESTEBAN",
        title = "ESTEBAN'S WISH: DARK ASCENSION",
        dominant_color = HEX('475569'),
        accent = HEX('d6d3d1'),
        bg_color = HEX('1c1917'),
        jokers = { 'j_reality_warp_esteban' },
        quote = "\"Purge the red hues from our court. Turn every soul into Spades or Clubs!\"",
        rules = {
            "Goal: Convert 100% of deck to Spades or Clubs",
            "Deck starts with ONLY Hearts & Diamonds (0 Spades/Clubs)",
            "Vertical gauge tracks your conversion progress",
            "Banned: The Sun and The Star Tarots",
        },
        deck_rules = {
            "Starting Joker: Esteban (Eternal)",
            "Deck: Red Suits only at the beginning",
            "Target: 52/52 Spades & Clubs",
            "Vertical Progress Gauge on the right",
        },
        challenge_id = 'c_reality_warp_esteban_trial',
    },
    {
        id = 'thiago',
        name = "THIAGO",
        title = "THIAGO'S WISH: CHIPS DOMINION",
        dominant_color = HEX('6366f1'),
        accent = HEX('a1a0ff'),
        bg_color = HEX('17153b'),
        jokers = { 'j_reality_warp_thiago' },
        quote = "\"Multipliers are a distraction! Only pure, unadulterated Chips determine victory.\"",
        rules = {
            "Win Condition: Ante 8",
            "Banned: ALL Mult & X-Mult Jokers",
            "Only Chip-granting Jokers appear and function",
            "Scale your Chip engine to overcome blind targets",
        },
        deck_rules = {
            "Starting Joker: Thiago (Eternal)",
            "Jokers allowed: Chips-only Jokers",
            "Shop & Booster Packs: Chips Jokers guaranteed",
            "Banned: All +Mult / XMult Jokers",
        },
        challenge_id = 'c_reality_warp_thiago_trial',
    },
    {
        id = 'yairo',
        name = "YAIRO",
        title = "YAIRO'S WISH: SIXES & SEVENS",
        dominant_color = HEX('2563eb'),
        accent = HEX('8fb6e8'),
        bg_color = HEX('161f38'),
        jokers = { 'j_reality_warp_yairo' },
        quote = "\"Life is in turmoil! Remake every card in your deck into 6s and 7s.\"",
        rules = {
            "Goal: Convert 100% of deck into ranks 6 and 7",
            "Vertical progress bar monitors transformed cards",
            "Use Tarots, Spectrals and Strengths wisely",
            "Complete the transmutation across Ante 8",
        },
        deck_rules = {
            "Starting Joker: Yairo (Eternal)",
            "Deck: Standard 52 starting cards",
            "Target: Entire deck composed of 6s & 7s",
            "Vertical Progress Gauge on the right",
        },
        challenge_id = 'c_reality_warp_yairo_trial',
    },
    {
        id = 'helin',
        name = "HELIN",
        title = "HELIN'S WISH: LONE CELESTIAL",
        dominant_color = HEX('9333ea'),
        accent = HEX('8d60b5'),
        bg_color = HEX('25103a'),
        jokers = { 'j_reality_warp_helin' },
        quote = "\"The cosmos need no interference. Just you, me, and the stars above.\"",
        rules = {
            "Complete the run with ONLY Helin",
            "Joker slots locked to 1 (No extra Jokers)",
            "Tarots and other consumables are banned",
            "ONLY Planet cards appear in shop & Celestial packs",
        },
        deck_rules = {
            "Starting Joker: Helin (Eternal)",
            "Joker Slots: 1 maximum",
            "Consumables: 100% Planet cards",
            "Packs: Celestial Booster Packs only",
        },
        challenge_id = 'c_reality_warp_helin_trial',
    },
    {
        id = 'calamari',
        name = "CALAMARI",
        title = "CALAMARI WISH: SQUID SISTERS",
        dominant_color = HEX('16a34a'),
        accent = HEX('3afb41'),
        bg_color = HEX('07331e'),
        jokers = { 'j_reality_warp_marie', 'j_reality_warp_callie' },
        quote = "\"Stay Fresh! Only Callie & Marie on stage, no backup dancers allowed!\"",
        rules = {
            "Win Condition: Ante 8",
            "Play exclusively with Marie & Callie",
            "Joker slots capped to 2",
            "No other Jokers appear throughout the run",
        },
        deck_rules = {
            "Starting Jokers: Marie (Eternal) & Callie (Eternal)",
            "Joker Slots: 2 fixed",
            "Jokers in Shop & Packs: Completely disabled",
            "Synergize between Green & Red suits",
        },
        challenge_id = 'c_reality_warp_calamari_trial',
    },
    {
        id = 'sally',
        name = "SALLY",
        title = "SALLY'S WISH: QUEST MASTER",
        dominant_color = HEX('dc2626'),
        accent = HEX('e8413e'),
        bg_color = HEX('380b0b'),
        jokers = { 'j_reality_warp_sally' },
        quote = "\"Step right up! Complete 10 of my dynamic quests before you hit Ante 8!\"",
        rules = {
            "Goal: Complete at least 10 Sally Quests",
            "Ante 8 limit disabled: keep playing until quests are done!",
            "Vertical gauge increments upon each finished quest",
            "Reach 10 completed quests to reveal the 'WIN!' button",
        },
        deck_rules = {
            "Starting Joker: Sally (Eternal)",
            "Target: 10 Completed Quests",
            "Quests reset and update on every Blind",
            "Claim victory directly via the 'WIN!' button",
        },
        challenge_id = 'c_reality_warp_sally_trial',
    },
    {
        id = 'cefalopop',
        name = "CEFALOPOP",
        title = "OFF THE HOOK: CEPHALOPOP HARMONY",
        dominant_color = HEX('0891b2'),
        accent = HEX('28d2dc'),
        bg_color = HEX('082730'),
        jokers = { 'j_reality_warp_marina', 'j_reality_warp_perla' },
        quote = "\"Don't get cooked, stay Off the Hook! Marina and Pearl run the entire show!\"",
        rules = {
            "Win Condition: Ante 8",
            "Play solely with Marina & Pearl",
            "Joker slots capped to 2",
            "No other Jokers can ever appear or be bought",
        },
        deck_rules = {
            "Starting Jokers: Marina (Eternal) & Pearl (Eternal)",
            "Joker Slots: 2 fixed",
            "Jokers in Shop & Packs: Disabled",
            "Synergy: Massive Mult & Chip boosts",
        },
        challenge_id = 'c_reality_warp_cefalopop_trial',
    },
    {
        id = 'mew_mew',
        name = "MEW MEW",
        title = "MEW MEW'S WISH: DOKI DOKI RUSH",
        dominant_color = HEX('db2777'),
        accent = HEX('ec4899'),
        bg_color = HEX('3b0820'),
        jokers = { 'j_reality_warp_mew_mew' },
        quote = "\"Play the hand my heart desires! Fill my Doki Meter to 30 for an instant WIN!\"",
        rules = {
            "Goal: Fill the Doki Meter to 30",
            "Every time you play the requested Poker Hand: +1 Doki",
            "Ante 8 limit disabled: play until you hit 30 Doki!",
            "Reach 30 Doki points to reveal the 'WIN!' button",
        },
        deck_rules = {
            "Starting Joker: Mew mew! (Eternal)",
            "Doki Target: 30 / 30",
            "Claim victory directly via the 'WIN!' button",
            "Vertical Progress Gauge on the right",
        },
        challenge_id = 'c_reality_warp_mew_mew_trial',
    },
    {
        id = 'kyra',
        name = "KYRA",
        title = "KYRA'S WISH: POTION MASTERY",
        dominant_color = HEX('00b4d8'),
        accent = HEX('00e5ff'),
        bg_color = HEX('082530'),
        jokers = { 'j_reality_warp_kyra', 'j_reality_warp_potion_brewer' },
        quote = "\"Show me your mastery of the brewing arts! Only potions can pave your path to Ante 6.\"",
        rules = {
            "Win Condition: Ante 6",
            "Consumables: Potions ONLY",
            "Jokers: Potion-related Jokers ONLY",
            "Starts with Kyra & Potion Brewer",
        },
        deck_rules = {
            "Starting Jokers: Kyra (Eternal) & Potion Brewer (Eternal)",
            "Banned: All Tarots, Spectrals & Planets",
            "Shop & Booster Packs: Potions exclusively",
            "Win Ante: 6",
        },
        challenge_id = 'c_reality_warp_kyra_trial',
    },
    {
        id = 'ray',
        name = "RAY",
        title = "RAY'S WISH: SPECTRAL RIFT",
        dominant_color = HEX('4338ca'),
        accent = HEX('818cf8'),
        bg_color = HEX('1e1b4b'),
        jokers = { 'j_reality_warp_raytracing' },
        quote = "\"The rift is unstable... only pure Spectral energies may be harnessed across the rifts!\"",
        rules = {
            "Consumables: Spectral cards ONLY",
            "Forbidden: The Soul & Warp Portal",
            "Tarots & Planets are strictly banned",
            "Starts with RayTracing",
        },
        deck_rules = {
            "Starting Joker: RayTracing (Eternal)",
            "Shop & Packs: Pure Spectral cards only",
            "Banned Consumables: Tarots, Planets, The Soul",
            "Win Condition: Ante 8",
        },
        challenge_id = 'c_reality_warp_ray_trial',
    },
    {
        id = 'charles',
        name = "CHARLES",
        title = "CHARLES' WISH: HEART OF GOLD",
        dominant_color = HEX('b91c1c'),
        accent = HEX('ef4444'),
        bg_color = HEX('3a0909'),
        jokers = { 'j_reality_warp_charles' },
        quote = "\"Every royal court must beat in unison. Turn every single card in your deck into a Heart!\"",
        rules = {
            "Goal: Convert 100% of your deck to Hearts",
            "Banned: Tarots converting to other suits",
            "Vertical gauge on the right tracks your progress",
            "Starts with Charles",
        },
        deck_rules = {
            "Starting Joker: Charles (Eternal)",
            "Target: 52/52 Hearts in playing deck",
            "Banned: Spades, Diamonds, Clubs conversions",
            "Vertical Progress Gauge on the right",
        },
        challenge_id = 'c_reality_warp_charles_trial',
    },
    {
        id = 'mochi',
        name = "MOCHI",
        title = "MOCHI'S WISH: WILD WONDERLAND",
        dominant_color = HEX('c026d3'),
        accent = HEX('e879f9'),
        bg_color = HEX('330638'),
        jokers = { 'j_reality_warp_mochi' },
        quote = "\"Why be confined to one suit? Let adaptability run wild across your entire deck!\"",
        rules = {
            "Goal: Convert 100% of deck to Wild Cards",
            "Banned: All Tarot cards & Arcana packs",
            "Vertical gauge on the right tracks your progress",
            "Starts with Mochi",
        },
        deck_rules = {
            "Starting Joker: Mochi (Eternal)",
            "Target: 52/52 Wild Cards in playing deck",
            "Banned: Tarot Cards & Arcana Booster Packs",
            "Vertical Progress Gauge on the right",
        },
        challenge_id = 'c_reality_warp_mochi_trial',
    },
}

G.UIDEF = G.UIDEF or {}

local function build_outsider_trials_tab_layout(args)
    G.SELECTED_OUTSIDER_TRIAL = G.SELECTED_OUTSIDER_TRIAL or 'paco'

    local selected_trial = OUTSIDER_TRIALS_DATA[1]
    for _, t in ipairs(OUTSIDER_TRIALS_DATA) do
        if t.id == G.SELECTED_OUTSIDER_TRIAL then
            selected_trial = t
            break
        end
    end

    -- Clean up previous trial card area if any
    if G.trials_joker_area then
        G.trials_joker_area:remove()
        G.trials_joker_area = nil
    end

    -- 1. Horizontal row of Outsider buttons:
    -- Main color equals the dominant color of the joker, text is white like Balatro normal button
    local joker_chips = {}
    for _, t in ipairs(OUTSIDER_TRIALS_DATA) do
        local is_sel = (t.id == selected_trial.id)
        table.insert(joker_chips, {
            n = G.UIT.C,
            config = {
                align = "cm",
                padding = 0.04,
                r = 0.08,
                colour = t.dominant_color,
                outline = is_sel and 0.04 or 0.015,
                outline_colour = is_sel and G.C.GOLD or G.C.WHITE,
                hover = true,
                shadow = true,
                button = 'select_outsider_trial',
                trial_id = t.id,
                minw = 0.72,
                minh = 0.58,
            },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                text = t.name,
                                scale = 0.17,
                                colour = G.C.WHITE,
                                shadow = true
                            }
                        }
                    }
                }
            }
        })
    end

    -- 2. Challenge Joker Card Area (Left Side)
    local joker_keys = selected_trial.jokers or { 'j_reality_warp_' .. selected_trial.id }
    local num_jokers = #joker_keys
    local card_scale = (num_jokers > 1) and 0.85 or 0.95
    local area_w = (num_jokers > 1) and (G.CARD_W * card_scale * 2.15) or (G.CARD_W * card_scale * 1.15)
    local area_h = G.CARD_H * card_scale * 1.15

    G.trials_joker_area = CardArea(
        0, 0,
        area_w,
        area_h,
        { card_limit = num_jokers, type = 'title', highlight_limit = 0, collection = true }
    )

    for _, j_key in ipairs(joker_keys) do
        local center = G.P_CENTERS[j_key] or G.P_CENTERS['j_reality_warp_' .. j_key] or G.P_CENTERS['j_' .. j_key]
        if center then
            local card = Card(
                G.trials_joker_area.T.x + G.trials_joker_area.T.w/2,
                G.trials_joker_area.T.y + G.trials_joker_area.T.h/2,
                G.CARD_W * card_scale,
                G.CARD_H * card_scale,
                G.P_CARDS.empty,
                center,
                { bypass_discovery_center = true, bypass_discovery_ui = true }
            )
            card.ability = card.ability or { name = center.name or 'Default', set = center.set or 'Joker', mult = 0, chips = 0, x_mult = 1 }
            card.sprite_facing = 'front'
            card.facing = 'front'
            if card.children and card.children.front then
                card.children.front.facing = 'front'
            end
            card.states.hover.can = true
            G.trials_joker_area:emplace(card)
        end
    end

    local joker_box = {
        n = G.UIT.C,
        config = {
            align = "cm",
            padding = 0.08,
            r = 0.16,
            colour = HEX('0f172a'),
            outline = 0.03,
            outline_colour = selected_trial.dominant_color,
            shadow = true,
            minw = (num_jokers > 1) and 2.5 or 1.6,
            minh = 4.4,
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.28 },
                nodes = {
                    { n = G.UIT.T, config = { text = (num_jokers > 1) and "TRIAL JOKERS" or "TRIAL JOKER", scale = 0.20, colour = selected_trial.dominant_color, shadow = true } }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 3.7 },
                nodes = {
                    { n = G.UIT.O, config = { object = G.trials_joker_area } }
                }
            }
        }
    }

    -- 3. Box with description of the challenge (in color white and rules in list)
    local challenge_rules_nodes = {}
    for _, r in ipairs(selected_trial.rules) do
        table.insert(challenge_rules_nodes, {
            n = G.UIT.R,
            config = { align = "cl", minh = 0.22 },
            nodes = {
                { n = G.UIT.T, config = { text = "- " .. r, scale = 0.19, colour = HEX('1e293b'), shadow = false } }
            }
        })
    end

    local deck_rules_nodes = {}
    for _, dr in ipairs(selected_trial.deck_rules) do
        table.insert(deck_rules_nodes, {
            n = G.UIT.R,
            config = { align = "cl", minh = 0.22 },
            nodes = {
                { n = G.UIT.T, config = { text = "- " .. dr, scale = 0.19, colour = HEX('334155'), shadow = false } }
            }
        })
    end

    local white_box = {
        n = G.UIT.C,
        config = {
            align = "cm",
            padding = 0.10,
            r = 0.16,
            colour = G.C.WHITE,
            outline = 0.03,
            outline_colour = selected_trial.dominant_color,
            shadow = true,
            minw = (num_jokers > 1) and 8.0 or 8.8,
            minh = 4.4
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.35 },
                nodes = {
                    { n = G.UIT.T, config = { text = selected_trial.title, scale = 0.29, colour = selected_trial.dominant_color, shadow = false } }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.32, maxw = (num_jokers > 1) and 7.6 or 8.4 },
                nodes = {
                    { n = G.UIT.T, config = { text = selected_trial.quote, scale = 0.20, colour = HEX('475569'), shadow = false } }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.06 },
                nodes = {}
            },
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "tl", padding = 0.06, minw = (num_jokers > 1) and 3.8 or 4.2 },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cl", minh = 0.25 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = "CHALLENGE OBJECTIVES:", scale = 0.21, colour = HEX('0f172a'), shadow = false } }
                                }
                            },
                            {
                                n = G.UIT.C,
                                config = { align = "cl", padding = 0.02 },
                                nodes = challenge_rules_nodes
                            }
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { minw = 0.02, minh = 2.0, colour = HEX('cbd5e1'), r = 0.01 },
                        nodes = {}
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "tl", padding = 0.06, minw = (num_jokers > 1) and 3.8 or 4.2 },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cl", minh = 0.25 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = "DECK RESTRICTIONS:", scale = 0.21, colour = HEX('0f172a'), shadow = false } }
                                }
                            },
                            {
                                n = G.UIT.C,
                                config = { align = "cl", padding = 0.02 },
                                nodes = deck_rules_nodes
                            }
                        }
                    }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.08 },
                nodes = {}
            },
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    padding = 0.05,
                    r = 0.10,
                    colour = G.C.GREEN,
                    hover = true,
                    shadow = true,
                    button = 'start_outsider_trial',
                    trial_id = selected_trial.id,
                    minw = 2.8,
                    minh = 0.40
                },
                nodes = {
                    { n = G.UIT.T, config = { text = "START TRIAL", scale = 0.26, colour = G.C.WHITE, shadow = true } }
                }
            }
        }
    }

    local layout = {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.06, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.38 },
                nodes = {
                    { n = G.UIT.T, config = { text = "OUTSIDER JOKER TRIALS", scale = 0.44, colour = G.C.GOLD, shadow = true } }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.24 },
                nodes = {
                    { n = G.UIT.T, config = { text = "Select an Outsider to inspect their trials and deck restrictions", scale = 0.21, colour = G.C.UI.TEXT_LIGHT } }
                }
            },
            -- Horizontal row of Outsider buttons
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.03 },
                nodes = joker_chips
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.05 },
                nodes = {}
            },
            -- Order: Joker area on left, then White Box with challenge rules & description on right
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.04 },
                nodes = {
                    joker_box,
                    { n = G.UIT.C, config = { minw = 0.15 }, nodes = {} },
                    white_box
                }
            }
        }
    }
    return layout
end

G.UIDEF.outsider_trials_tab = function(args)
    local ok, res = pcall(build_outsider_trials_tab_layout, args)
    if not ok then
        return {
            n = G.UIT.ROOT,
            config = { align = "cm", padding = 0.2, colour = G.C.CLEAR },
            nodes = {
                { n = G.UIT.R, config = { align = "cm" }, nodes = {
                    { n = G.UIT.T, config = { text = "TRIALS TAB ERROR", scale = 0.4, colour = G.C.RED } }
                }},
                { n = G.UIT.R, config = { align = "cm" }, nodes = {
                    { n = G.UIT.T, config = { text = tostring(res), scale = 0.22, colour = G.C.WHITE } }
                }}
            }
        }
    end
    return res
end

G.FUNCS = G.FUNCS or {}

G.FUNCS.select_outsider_trial = function(e)
    local tid = (e and e.config and e.config.trial_id) or 'paco'
    G.SELECTED_OUTSIDER_TRIAL = tid
    play_sound('cardSlide1', 1.0, 0.7)

    if G.trials_joker_area then
        G.trials_joker_area:remove()
        G.trials_joker_area = nil
    end

    local tab_contents = nil
    if G.OVERLAY_MENU then
        tab_contents = G.OVERLAY_MENU:get_UIE_by_ID('tab_contents')
    end
    if not tab_contents and e and e.UIBox then
        local curr = e.UIBox
        while curr do
            if curr.get_UIE_by_ID then
                tab_contents = curr:get_UIE_by_ID('tab_contents')
                if tab_contents then break end
            end
            curr = curr.parent
        end
    end
    if tab_contents and tab_contents.config and tab_contents.config.object then
        tab_contents.config.object:remove()
        tab_contents.config.object = UIBox{
            definition = G.UIDEF.outsider_trials_tab('Joker Trials'),
            config = { offset = { x = 0, y = 0 }, parent = tab_contents, type = 'cm' }
        }
        if tab_contents.UIBox then
            tab_contents.UIBox:recalculate()
        end
    end
end

G.FUNCS.start_outsider_trial = function(e)
    local tid = (e and e.config and e.config.trial_id) or G.SELECTED_OUTSIDER_TRIAL or 'paco'
    local challenge_id = 'c_reality_warp_' .. tid .. '_trial'

    if G.trials_joker_area then
        G.trials_joker_area:remove()
        G.trials_joker_area = nil
    end

    if G.OVERLAY_MENU then
        G.FUNCS.exit_overlay_menu()
    end

    local ch = nil
    if G.CHALLENGES then
        for _, c in ipairs(G.CHALLENGES) do
            if c.id == challenge_id or c.key == challenge_id then
                ch = c
                break
            end
        end
    end
    if not ch and SMODS and SMODS.Challenges and SMODS.Challenges[challenge_id] then
        ch = SMODS.Challenges[challenge_id]
    end

    if G.FUNCS and G.FUNCS.start_run then
        G.FUNCS.start_run(nil, { challenge = ch or challenge_id })
    end
end

if not G.FUNCS.orig_exit_overlay_menu_trials then
    G.FUNCS.orig_exit_overlay_menu_trials = G.FUNCS.exit_overlay_menu
    G.FUNCS.exit_overlay_menu = function(...)
        if G.trials_joker_area then
            G.trials_joker_area:remove()
            G.trials_joker_area = nil
        end
        if G.FUNCS.orig_exit_overlay_menu_trials then
            return G.FUNCS.orig_exit_overlay_menu_trials(...)
        end
    end
end

-- ============================================================================
-- VERTICAL PROGRESS HUD (Appears on the right side above G.deck)
-- ============================================================================
local SPECIFIC_GOAL_TRIALS = {
    ['c_reality_warp_mew_mew_trial'] = true,
    ['mew_mew_trial'] = true,
    ['c_reality_warp_sally_trial'] = true,
    ['sally_trial'] = true,
    ['c_reality_warp_charles_trial'] = true,
    ['charles_trial'] = true,
    ['c_reality_warp_mochi_trial'] = true,
    ['mochi_trial'] = true,
    ['c_reality_warp_esteban_trial'] = true,
    ['esteban_trial'] = true,
    ['c_reality_warp_yairo_trial'] = true,
    ['yairo_trial'] = true,
}

G.FUNCS = G.FUNCS or {}
G.FUNCS.claim_outsider_trial_win = function(e)
    if not G.GAME.won then
        G.GAME.won = true
        if G.GAME.challenge and G.PROFILES and G.PROFILES[G.SETTINGS.profile] and G.PROFILES[G.SETTINGS.profile].challenge_progress then
            G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[G.GAME.challenge] = true
            if G.save_settings then G:save_settings() end
        end
        if check_for_unlock then
            check_for_unlock({type = 'win_challenge'})
            check_for_unlock({type = 'win'})
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                if G.FUNCS and G.FUNCS.overlay_menu and create_UIBox_win then
                    G.FUNCS.overlay_menu{ definition = create_UIBox_win(), config = { no_esc = true } }
                end
                return true
            end
        }))
    end
end

function create_outsider_trial_hud(text_title, count, total, percent, is_complete, col)
    if G.HUD_outsider_trial and not G.HUD_outsider_trial.REMOVED then
        G.HUD_outsider_trial:remove()
        G.HUD_outsider_trial = nil
    end

    local clamped_pct = math.max(0, math.min(100, percent or 0))
    local bar_w = 2.00
    local bar_h = 0.16
    local fill_w = math.max(0.04, bar_w * (clamped_pct / 100))
    local empty_w = math.max(0.0, bar_w - fill_w)

    local status_display = tostring(count) .. "/" .. tostring(total)
    local pct_display = string.format("%.0f%%", clamped_pct)

    local progress_bar_node = {
        n = G.UIT.R,
        config = {
            align = "cm",
            minw = bar_w,
            minh = bar_h,
            r = 0.08,
            colour = HEX('000000'),
            outline = 0.02,
            outline_colour = HEX('3f3f46'),
            padding = 0.015
        },
        nodes = {
            {
                n = G.UIT.C,
                config = {
                    align = "cl",
                    minw = fill_w,
                    minh = bar_h,
                    r = 0.06,
                    colour = is_complete and G.C.GOLD or col,
                    shadow = false
                },
                nodes = {}
            },
            (empty_w > 0.01) and {
                n = G.UIT.C,
                config = {
                    align = "cr",
                    minw = empty_w,
                    minh = bar_h,
                    colour = G.C.CLEAR
                },
                nodes = {}
            } or nil
        }
    }

    local action_node
    if is_complete then
        action_node = {
            n = G.UIT.R,
            config = { align = "cm", padding = 0.02 },
            nodes = {
                UIBox_button({
                    id = 'trial_win_claim_btn',
                    label = {"CLAIM WIN!"},
                    button = 'claim_outsider_trial_win',
                    colour = G.C.GOLD,
                    minw = bar_w,
                    minh = 0.32,
                    scale = 0.26,
                    emboss = 0.06,
                    col = true
                })
            }
        }
    else
        action_node = progress_bar_node
    end

    local t = {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.C,
                config = {
                    id = 'outsider_trial_hud_box',
                    align = "cm",
                    padding = 0.06,
                    r = 0.12,
                    colour = HEX('09090b'),
                    outline = 0.03,
                    outline_colour = is_complete and G.C.GOLD or HEX('3f3f46'),
                    shadow = true,
                    minw = 2.15,
                    emboss = 0.06
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm", padding = 0.02 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { align = "cl", minw = 1.05 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = text_title, scale = 0.22, colour = is_complete and G.C.GOLD or col, shadow = true } }
                                }
                            },
                            {
                                n = G.UIT.C,
                                config = { align = "cr", minw = 1.05 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = status_display .. " (" .. pct_display .. ")", scale = 0.20, colour = is_complete and G.C.GOLD or G.C.WHITE, shadow = true } }
                                }
                            }
                        }
                    },
                    action_node
                }
            }
        }
    }

    local major_elem = (G.HUD_pouch and not G.HUD_pouch.REMOVED and G.HUD_pouch) or G.consumeables
    local offset_y = (major_elem == G.HUD_pouch) and 0.12 or 0.20

    local hud = UIBox{
        definition = t,
        config = {
            align = "bm",
            offset = { x = 0, y = offset_y },
            major = major_elem,
            bond = 'Weak'
        }
    }
    hud.states.drag.can = false
    hud.states.collide.can = is_complete and true or false

    G.HUD_outsider_trial = hud
    G.HUD_outsider_trial._last_val = count
    G.HUD_outsider_trial._last_total = total
    G.HUD_outsider_trial._last_comp = is_complete
end

-- ============================================================================
-- GAMEPLAY TRACKING & HOOKS
-- ============================================================================
if Game and Game.update then
    local orig_game_update_trials = Game.update
    function Game:update(dt)
        orig_game_update_trials(self, dt)
        if G.STAGE == G.STAGES.RUN and G.playing_cards and #G.playing_cards > 0 then
            local ch = G.GAME and G.GAME.challenge

            if ch and SPECIFIC_GOAL_TRIALS[ch] and G.GAME.win_ante ~= 999999 then
                G.GAME.win_ante = 999999
            end

            if ch == 'c_reality_warp_charles_trial' then
                local hearts_count = 0
                local total_cards = #G.playing_cards
                for _, c in ipairs(G.playing_cards) do
                    if c:is_suit('Hearts') then
                        hearts_count = hearts_count + 1
                    end
                end
                local pct = (total_cards > 0) and (hearts_count / total_cards * 100) or 0
                local is_comp = (hearts_count == total_cards and total_cards > 0)
                if not G.HUD_outsider_trial or G.HUD_outsider_trial.REMOVED or G.HUD_outsider_trial._last_val ~= hearts_count or G.HUD_outsider_trial._last_total ~= total_cards or G.HUD_outsider_trial._last_comp ~= is_comp then
                    create_outsider_trial_hud("♥ HEARTS", hearts_count, total_cards, pct, is_comp, G.C.RED)
                end

            elseif ch == 'c_reality_warp_mochi_trial' then
                local wild_count = 0
                local total_cards = #G.playing_cards
                for _, c in ipairs(G.playing_cards) do
                    if (is_wild_card and is_wild_card(c)) or (c.config and c.config.center == G.P_CENTERS.m_wild) then
                        wild_count = wild_count + 1
                    end
                end
                local pct = (total_cards > 0) and (wild_count / total_cards * 100) or 0
                local is_comp = (wild_count == total_cards and total_cards > 0)
                if not G.HUD_outsider_trial or G.HUD_outsider_trial.REMOVED or G.HUD_outsider_trial._last_val ~= wild_count or G.HUD_outsider_trial._last_total ~= total_cards or G.HUD_outsider_trial._last_comp ~= is_comp then
                    create_outsider_trial_hud("★ WILD", wild_count, total_cards, pct, is_comp, HEX('e879f9'))
                end

            elseif ch == 'c_reality_warp_esteban_trial' then
                local dark_count = 0
                local total_cards = #G.playing_cards
                for _, c in ipairs(G.playing_cards) do
                    if c:is_suit('Spades') or c:is_suit('Clubs') then
                        dark_count = dark_count + 1
                    end
                end
                local pct = (total_cards > 0) and (dark_count / total_cards * 100) or 0
                local is_comp = (dark_count == total_cards and total_cards > 0)
                if not G.HUD_outsider_trial or G.HUD_outsider_trial.REMOVED or G.HUD_outsider_trial._last_val ~= dark_count or G.HUD_outsider_trial._last_total ~= total_cards or G.HUD_outsider_trial._last_comp ~= is_comp then
                    create_outsider_trial_hud("♠♣ DARK", dark_count, total_cards, pct, is_comp, HEX('d6d3d1'))
                end

            elseif ch == 'c_reality_warp_yairo_trial' then
                local six_seven_count = 0
                local total_cards = #G.playing_cards
                for _, c in ipairs(G.playing_cards) do
                    local id = c:get_id()
                    if id == 6 or id == 7 then
                        six_seven_count = six_seven_count + 1
                    end
                end
                local pct = (total_cards > 0) and (six_seven_count / total_cards * 100) or 0
                local is_comp = (six_seven_count == total_cards and total_cards > 0)
                if not G.HUD_outsider_trial or G.HUD_outsider_trial.REMOVED or G.HUD_outsider_trial._last_val ~= six_seven_count or G.HUD_outsider_trial._last_total ~= total_cards or G.HUD_outsider_trial._last_comp ~= is_comp then
                    create_outsider_trial_hud("6 & 7", six_seven_count, total_cards, pct, is_comp, HEX('8fb6e8'))
                end

            elseif ch == 'c_reality_warp_sally_trial' then
                local q_count = G.GAME.sally_quests_completed or 0
                local total_q = 10
                local pct = math.min(100, (q_count / total_q) * 100)
                local is_comp = (q_count >= total_q)
                if not G.HUD_outsider_trial or G.HUD_outsider_trial.REMOVED or G.HUD_outsider_trial._last_val ~= q_count or G.HUD_outsider_trial._last_total ~= total_q or G.HUD_outsider_trial._last_comp ~= is_comp then
                    create_outsider_trial_hud("QUESTS", q_count, total_q, pct, is_comp, HEX('e8413e'))
                end

            elseif ch == 'c_reality_warp_mew_mew_trial' then
                local doki = G.GAME.mew_mew_doki_meter or 0
                local total_doki = 30
                local pct = math.min(100, (doki / total_doki) * 100)
                local is_comp = (doki >= total_doki)
                if not G.HUD_outsider_trial or G.HUD_outsider_trial.REMOVED or G.HUD_outsider_trial._last_val ~= doki or G.HUD_outsider_trial._last_total ~= total_doki or G.HUD_outsider_trial._last_comp ~= is_comp then
                    create_outsider_trial_hud("DOKI", doki, total_doki, pct, is_comp, HEX('ec4899'))
                end

            elseif G.HUD_outsider_trial then
                G.HUD_outsider_trial:remove()
                G.HUD_outsider_trial = nil
            end
        elseif G.HUD_outsider_trial then
            G.HUD_outsider_trial:remove()
            G.HUD_outsider_trial = nil
        end
    end
end

-- Hook Game:start_run for Deck Initializations
if Game and Game.start_run then
    local orig_game_start_run_trials = Game.start_run
    function Game:start_run(args)
        orig_game_start_run_trials(self, args)
        if G.GAME and G.GAME.challenge then
            local ch = G.GAME.challenge

            -- Specific-goal trials disable Ante 8 win condition
            if SPECIFIC_GOAL_TRIALS[ch] then
                G.GAME.win_ante = 999999
            end

            -- Esteban: Start with ONLY Hearts and Diamonds
            if ch == 'c_reality_warp_esteban_trial' and not args.savetag then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.playing_cards then
                            for _, c in ipairs(G.playing_cards) do
                                if c:is_suit('Spades') then
                                    c:change_suit('Hearts')
                                elseif c:is_suit('Clubs') then
                                    c:change_suit('Diamonds')
                                end
                            end
                        end
                        return true
                    end
                }))
            end

            -- Paco: Discards strictly 0
            if ch == 'c_reality_warp_paco_trial' then
                G.GAME.round_resets.discards = 0
                G.GAME.current_round.discards_left = 0
            end

            -- Helin: 1 Joker slot max
            if ch == 'c_reality_warp_helin_trial' then
                if G.jokers and G.jokers.config then
                    G.jokers.config.card_limit = 1
                end
            end

            -- Calamari / Cefalopop: 2 Joker slots max
            if ch == 'c_reality_warp_calamari_trial' or ch == 'c_reality_warp_cefalopop_trial' then
                if G.jokers and G.jokers.config then
                    G.jokers.config.card_limit = 2
                end
            end
        end
    end
end

-- Prevent Ante 8 auto-win for challenges with specific goals
if end_round then
    local orig_end_round_trials = end_round
    function end_round()
        local ch = G.GAME and G.GAME.challenge
        if SPECIFIC_GOAL_TRIALS[ch] and G.GAME then
            G.GAME.win_ante = 999999
        end
        orig_end_round_trials()
    end
end

-- Ante HUD clean display for infinite ante trials (shows only current ante number)
if create_UIBox_HUD then
    local orig_create_UIBox_HUD_trials = create_UIBox_HUD
    function create_UIBox_HUD()
        local hud = orig_create_UIBox_HUD_trials()
        if G.GAME and G.GAME.challenge and (SPECIFIC_GOAL_TRIALS[G.GAME.challenge] or (G.GAME.win_ante and G.GAME.win_ante >= 999999)) then
            local function fix_hud_ante(node)
                if not node or type(node) ~= 'table' then return end
                if node.config and type(node.config.text) == 'string' then
                    if string.find(node.config.text, '999999') or node.config.text == '/∞' or (G.GAME.win_ante and G.GAME.win_ante >= 999999 and string.find(node.config.text, tostring(G.GAME.win_ante))) then
                        node.config.text = ''
                    end
                end
                if node.nodes then
                    for _, child in ipairs(node.nodes) do
                        fix_hud_ante(child)
                    end
                end
            end
            fix_hud_ante(hud)
        end
        return hud
    end
end

-- Paco Discard Prevention
if ease_discard then
    local orig_ease_discard_paco = ease_discard
    function ease_discard(mod, instant, silent)
        if G.GAME and G.GAME.challenge == 'c_reality_warp_paco_trial' and (mod or 0) > 0 then
            return
        end
        orig_ease_discard_paco(mod, instant, silent)
    end
end

if Blind and Blind.set_blind then
    local orig_blind_set_blind_paco = Blind.set_blind
    function Blind:set_blind(blind, reset, silent)
        orig_blind_set_blind_paco(self, blind, reset, silent)
        if G.GAME and G.GAME.challenge == 'c_reality_warp_paco_trial' then
            G.GAME.round_resets.discards = 5
            G.GAME.current_round.discards_left = 5
            if G.GAME.round_resets then G.GAME.round_resets.discards = 5 end
        end
    end
end

-- Consumable Restrictions
if Card and Card.can_use_consumeable then
    local orig_can_use_consumeable = Card.can_use_consumeable
    function Card:can_use_consumeable(any_state, skip_check)
        local ch = G.GAME and G.GAME.challenge
        local set = (self.ability and self.ability.set) or (self.config and self.config.center and self.config.center.set)

        if ch == 'c_reality_warp_kyra_trial' and set ~= 'Potion' then
            return false
        end
        if ch == 'c_reality_warp_ray_trial' then
            local k = (self.config and self.config.center and self.config.center.key) or ''
            if set ~= 'Spectral' or k == 'c_soul' or k == 'c_reality_warp_warp_portal' or k == 'c_warp_portal' then
                return false
            end
        end
        if (ch == 'c_reality_warp_helin_trial' or ch == 'c_reality_warp_paco_trial') and set ~= 'Planet' then
            return false
        end
        return orig_can_use_consumeable(self, any_state, skip_check)
    end
end

-- Card Creation Filter
if create_card then
    local orig_create_card_trials = create_card
    function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
        local ch = G.GAME and G.GAME.challenge

        if ch == 'c_reality_warp_kyra_trial' then
            if _type == 'Consumeables' or _type == 'Tarot' or _type == 'Planet' or _type == 'Spectral' then
                if create_potion_card_safe then
                    return create_potion_card_safe(area, key_append or 'kyra_trial')
                end
            end
            if _type == 'Joker' and key_append ~= 'start' then
                local potion_jokers = { 'j_reality_warp_kyra', 'j_reality_warp_potion_brewer', 'j_reality_warp_philosopher' }
                forced_key = pseudorandom_element(potion_jokers, pseudoseed('kyra_trial_jokers'))
            end
        end

        if ch == 'c_reality_warp_ray_trial' then
            if _type == 'Consumeables' or _type == 'Tarot' or _type == 'Planet' or _type == 'Potion' then
                _type = 'Spectral'
            end
            if forced_key == 'c_soul' or forced_key == 'c_reality_warp_warp_portal' or forced_key == 'c_warp_portal' then
                forced_key = 'c_ankh'
            end
        end

        if (ch == 'c_reality_warp_helin_trial' or ch == 'c_reality_warp_paco_trial') then
            if _type == 'Joker' and key_append ~= 'start' and ch == 'c_reality_warp_helin_trial' then
                forced_key = 'j_reality_warp_helin'
            end
            if _type == 'Consumeables' or _type == 'Tarot' or _type == 'Spectral' or _type == 'Potion' then
                _type = 'Planet'
            end
        end

        if ch == 'c_reality_warp_thiago_trial' and _type == 'Joker' and key_append ~= 'start' then
            local chip_jokers = {
                'j_reality_warp_thiago', 'j_blue_joker', 'j_ice_cream', 'j_bull',
                'j_stone', 'j_runner', 'j_hiker', 'j_wee', 'j_arrowhead',
                'j_scary_face', 'j_sly', 'j_wily', 'j_clever', 'j_devious', 'j_crafty'
            }
            forced_key = pseudorandom_element(chip_jokers, pseudoseed('thiago_trial_chips'))
        end

        if (ch == 'c_reality_warp_calamari_trial' or ch == 'c_reality_warp_cefalopop_trial') and _type == 'Joker' and key_append ~= 'start' then
            _type = 'Tarot'
        end

        return orig_create_card_trials(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    end
end

-- Scoring Hooks for Sally Quests & Mew Mew Doki Meter
if Card and Card.calculate_joker then
    local orig_calculate_joker_trials = Card.calculate_joker
    function Card:calculate_joker(context)
        local ch = G.GAME and G.GAME.challenge
        local mew_target_matched = false

        -- Mew Mew Doki Meter: check before target_hand changes in calculate
        if ch == 'c_reality_warp_mew_mew_trial' and context.before and not context.blueprint then
            local jk = self.config and self.config.center and self.config.center.key
            if (jk == 'j_reality_warp_mew_mew' or jk == 'mew_mew') and self.ability and self.ability.extra then
                if context.scoring_name and self.ability.extra.target_hand and context.scoring_name == self.ability.extra.target_hand then
                    mew_target_matched = true
                end
            end
        end

        local ret = orig_calculate_joker_trials(self, context)

        -- Mew Mew Doki Meter: +1 when requested poker hand is played
        if mew_target_matched then
            G.GAME.mew_mew_doki_meter = (G.GAME.mew_mew_doki_meter or 0) + 1
            attention_text({
                text = "DOKI! (" .. G.GAME.mew_mew_doki_meter .. "/30)",
                scale = 0.55,
                hold = 0.8,
                backdrop_colour = HEX('ec4899'),
                major = self,
                align = 'tm',
                offset = { x = 0, y = -0.5 }
            })
            if G.GAME.mew_mew_doki_meter >= 30 then
                G.GAME.trial_goal_complete = true
            end
        end

        -- Sally Quests Completed Tracker
        if ch == 'c_reality_warp_sally_trial' and not context.blueprint then
            local jk = self.config and self.config.center and self.config.center.key
            if jk == 'j_reality_warp_sally' and self.ability and self.ability.extra and self.ability.extra.completed then
                if not self.ability.extra._counted_for_trial then
                    self.ability.extra._counted_for_trial = true
                    G.GAME.sally_quests_completed = (G.GAME.sally_quests_completed or 0) + 1
                    attention_text({
                        text = "QUEST COMPLETE! (" .. G.GAME.sally_quests_completed .. "/10)",
                        scale = 0.55,
                        hold = 0.8,
                        backdrop_colour = HEX('e8413e'),
                        major = self,
                        align = 'tm',
                        offset = { x = 0, y = -0.5 }
                    })
                end
            end
        end

        return ret
    end
end
