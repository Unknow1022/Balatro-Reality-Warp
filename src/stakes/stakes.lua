SMODS.Atlas {
    key = "reality_warp_stakes",
    path = "reality_warp_stakes.png",
    px = 29,
    py = 29
}

SMODS.Atlas {
    key = "reality_warp_stake_stickers",
    path = "reality_warp_stake_stickers.png",
    px = 71,
    py = 95
}

SMODS.Sticker {
    key = "weakened",
    atlas = "reality_warp_stickers",
    pos = { x = 0, y = 2 },
    badge_colour = HEX('94a3b8'),
    prefix_config = { key = false },
    sets = { Joker = true },
    rate = 0.3,
    needs_enable_flag = true,
    should_apply = function(self, card, center, area, bypass_roll)
        return G.GAME and G.GAME.modifiers and G.GAME.modifiers.enable_weakened_in_shop and
            SMODS.Sticker.should_apply(self, card, center, area, bypass_roll)
    end,
    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
        if card and card.ability then
            card.ability.weakened = val
        end
    end,
    loc_txt = {
        name = "Weakened",
        text = {
            "All scoring and dollar values",
            "granted by this Joker are {C:attention}halved{}"
        }
    }
}

SMODS.Stake {
    key = 'diamond',
    above_stake = 'gold',
    applied_stakes = { 'gold' },
    prefix_config = { above_stake = { mod = false }, applied_stakes = { mod = false } },
    pos = { x = 0, y = 0 },
    sticker_pos = { x = 0, y = 0 },
    atlas = 'reality_warp_stakes',
    sticker_atlas = 'reality_warp_stake_stickers',
    colour = HEX('5eead4'),
    shiny = true,
    loc_txt = {
        name = 'Diamond Stake',
        text = {
            "Required Ante to win",
            "is increased to {C:attention}Ante 9{}"
        }
    },
    modifiers = function()
        G.GAME.win_ante = 9
    end
}

SMODS.Stake {
    key = 'obsidian',
    above_stake = 'diamond',
    applied_stakes = { 'diamond' },
    pos = { x = 1, y = 0 },
    sticker_pos = { x = 1, y = 0 },
    atlas = 'reality_warp_stakes',
    sticker_atlas = 'reality_warp_stake_stickers',
    colour = HEX('334155'),
    shiny = false,
    loc_txt = {
        name = 'Obsidian Stake',
        text = {
            "Shop rerolls cost {C:money}+$1{} base",
            "and increase by {C:money}+$2{} per reroll"
        }
    },
    modifiers = function()
        G.GAME.round_resets.reroll_cost = (G.GAME.round_resets.reroll_cost or 5) + 1
        G.GAME.modifiers.reroll_scaling = 2
    end
}

SMODS.Stake {
    key = 'amber',
    above_stake = 'obsidian',
    applied_stakes = { 'obsidian' },
    pos = { x = 2, y = 0 },
    sticker_pos = { x = 2, y = 0 },
    atlas = 'reality_warp_stakes',
    sticker_atlas = 'reality_warp_stake_stickers',
    colour = HEX('f59e0b'),
    shiny = true,
    loc_txt = {
        name = 'Amber Stake',
        text = {
            "All Booster Packs offer",
            "{C:attention}1 fewer{} card to choose from"
        }
    },
    modifiers = function()
        G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - 1
    end
}

SMODS.Stake {
    key = 'sapphire',
    above_stake = 'amber',
    applied_stakes = { 'amber' },
    pos = { x = 3, y = 0 },
    sticker_pos = { x = 3, y = 0 },
    atlas = 'reality_warp_stakes',
    sticker_atlas = 'reality_warp_stake_stickers',
    colour = HEX('3b82f6'),
    shiny = true,
    loc_txt = {
        name = 'Sapphire Stake',
        text = {
            "Vouchers in the shop",
            "cost {C:money}$15{} instead of $10"
        }
    },
    modifiers = function()
        G.GAME.modifiers.voucher_cost_increase = 5
    end
}

SMODS.Stake {
    key = 'amethyst',
    above_stake = 'sapphire',
    applied_stakes = { 'sapphire' },
    pos = { x = 4, y = 0 },
    sticker_pos = { x = 4, y = 0 },
    atlas = 'reality_warp_stakes',
    sticker_atlas = 'reality_warp_stake_stickers',
    colour = HEX('a855f7'),
    shiny = true,
    loc_txt = {
        name = 'Amethyst Stake',
        text = {
            "{C:attention}-1{} Consumable slot",
            "in your inventory"
        }
    },
    modifiers = function()
        G.GAME.starting_params.consumable_slots = math.max(1, (G.GAME.starting_params.consumable_slots or 2) - 1)
    end
}

SMODS.Stake {
    key = 'platinum',
    above_stake = 'amethyst',
    applied_stakes = { 'amethyst' },
    pos = { x = 5, y = 0 },
    sticker_pos = { x = 5, y = 0 },
    atlas = 'reality_warp_stakes',
    sticker_atlas = 'reality_warp_stake_stickers',
    colour = HEX('cbd5e1'),
    shiny = true,
    loc_txt = {
        name = 'Platinum Stake',
        text = {
            "Shop Jokers can have",
            "the {C:attention}Weakened{} sticker"
        }
    },
    modifiers = function()
        G.GAME.modifiers.enable_weakened_in_shop = true
    end
}

SMODS.Stake {
    key = 'void',
    above_stake = 'platinum',
    applied_stakes = { 'platinum' },
    pos = { x = 6, y = 0 },
    sticker_pos = { x = 6, y = 0 },
    atlas = 'reality_warp_stakes',
    sticker_atlas = 'reality_warp_stake_stickers',
    colour = HEX('1e1035'),
    shiny = false,
    loc_txt = {
        name = 'Void Stake',
        text = {
            "The {C:purple}Dark Market{}",
            "no longer appears"
        }
    },
    modifiers = function()
        G.GAME.modifiers.no_black_market = true
        G.GAME.black_market_available = false
    end
}

SMODS.Stake {
    key = 'celestial',
    above_stake = 'void',
    applied_stakes = { 'void' },
    pos = { x = 7, y = 0 },
    sticker_pos = { x = 7, y = 0 },
    atlas = 'reality_warp_stakes',
    sticker_atlas = 'reality_warp_stake_stickers',
    colour = HEX('c084fc'),
    shiny = true,
    loc_txt = {
        name = 'Celestial Stake',
        text = {
            "{C:attention}Big Blinds{} are also {C:attention}Boss Blinds{},",
            "and every {C:attention}4 Antes{} is a {C:attention}Showdown Blind{}"
        }
    },
    modifiers = function()
        G.GAME.modifiers.celestial_stake = true
    end
}

if reset_blinds then
    local orig_reset_blinds = reset_blinds
    function reset_blinds()
        orig_reset_blinds()
        if G.GAME and G.GAME.modifiers and G.GAME.modifiers.celestial_stake then
            local get_boss = get_new_boss_filtered or get_new_boss
            if get_boss then
                G.GAME.round_resets.blind_choices.Big = get_boss(false)
            end
            local ante = (G.GAME.round_resets and G.GAME.round_resets.ante) or 1
            if ante % 4 == 0 and ante >= 1 and get_new_boss_filtered then
                G.GAME.round_resets.blind_choices.Boss = get_new_boss_filtered(true)
            end
        end
    end
end

if get_new_boss then
    local orig_get_new_boss = get_new_boss
    function get_new_boss()
        if G.GAME and G.GAME.modifiers and G.GAME.modifiers.celestial_stake then
            local ante = (G.GAME.round_resets and G.GAME.round_resets.ante) or 1
            if ante % 4 == 0 and ante >= 1 and get_new_boss_filtered then
                return get_new_boss_filtered(true)
            end
        end
        return orig_get_new_boss()
    end
end

if SMODS and SMODS.get_new_blind then
    local orig_smods_get_new_blind = SMODS.get_new_blind
    function SMODS.get_new_blind(blind_type)
        if G.GAME and G.GAME.modifiers and G.GAME.modifiers.celestial_stake then
            if blind_type == "big" or blind_type == "Big" then
                blind_type = "boss"
            end
        end
        return orig_smods_get_new_blind(blind_type)
    end
end
