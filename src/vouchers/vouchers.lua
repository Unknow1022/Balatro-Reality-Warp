SMODS.Atlas {
    key = "reality_warp_vouchers",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Voucher {
    key = 'catador',
    atlas = 'reality_warp_vouchers',
    pos = { x = 0, y = 0 },
    cost = 10,
    loc_txt = {
        name = 'Taster',
        text = {
            "{C:common}Common Jokers{} appear",
            "{C:attention}less frequently{} in shop"
        }
    },
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_catador = true
        G.GAME.used_vouchers['v_Witch brew_catador'] = true
        G.GAME.used_vouchers.v_catador = true
        G.GAME.used_vouchers.catador = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_catador = false
            G.GAME.current_round.voucher.spawn['v_Witch brew_catador'] = false
        end
    end
}

SMODS.Voucher {
    key = 'critico',
    atlas = 'reality_warp_vouchers',
    requires = { 'v_reality_warp_catador' },
    pos = { x = 1, y = 0 },
    cost = 10,
    loc_txt = {
        name = 'Critic',
        text = {
            "{C:common}Common Jokers{} no longer",
            "appear in shop"
        }
    },
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_critico = true
        G.GAME.used_vouchers['v_Witch brew_critico'] = true
        G.GAME.used_vouchers.v_critico = true
        G.GAME.used_vouchers.critico = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_critico = false
            G.GAME.current_round.voucher.spawn['v_Witch brew_critico'] = false
        end
    end
}

SMODS.Voucher {
    key = 'embrujo',
    atlas = 'reality_warp_vouchers',
    pos = { x = 0, y = 1 },
    cost = 10,
    loc_txt = {
        name = 'Embrujo',
        text = {
            "{C:attention}Potions{} appear {C:attention}2X{}",
            "more frequently in shop"
        }
    },
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_embrujo = true
        G.GAME.used_vouchers['v_Witch brew_embrujo'] = true
        G.GAME.used_vouchers.v_embrujo = true
        G.GAME.used_vouchers.embrujo = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_embrujo = false
            G.GAME.current_round.voucher.spawn['v_Witch brew_embrujo'] = false
        end
    end
}

SMODS.Voucher {
    key = 'caldero',
    atlas = 'reality_warp_vouchers',
    requires = { 'v_reality_warp_embrujo' },
    pos = { x = 1, y = 1 },
    cost = 10,
    loc_txt = {
        name = 'Caldero',
        text = {
            "{C:attention}Potions{} appear {C:attention}4X{}",
            "more frequently in shop"
        }
    },
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_caldero = true
        G.GAME.used_vouchers['v_Witch brew_caldero'] = true
        G.GAME.used_vouchers.v_caldero = true
        G.GAME.used_vouchers.caldero = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_caldero = false
            G.GAME.current_round.voucher.spawn['v_Witch brew_caldero'] = false
        end
    end
}

SMODS.Voucher {
    key = 'destilacion_recurrente',
    atlas = 'reality_warp_vouchers',
    pos = { x = 0, y = 2 },
    cost = 10,
    loc_txt = {
        name = 'Recurring Distillation',
        text = {
            "{C:attention}15% chance{} for any used",
            "{C:attention}consumable{} to be recreated"
        }
    },
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_destilacion_recurrente = true
        G.GAME.used_vouchers['v_Witch brew_destilacion_recurrente'] = true
        G.GAME.used_vouchers.v_destilacion_recurrente = true
        G.GAME.used_vouchers.destilacion_recurrente = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_destilacion_recurrente = false
            G.GAME.current_round.voucher.spawn['v_Witch brew_destilacion_recurrente'] = false
        end
    end
}

SMODS.Voucher {
    key = 'destilacion_infinita',
    atlas = 'reality_warp_vouchers',
    requires = { 'v_reality_warp_destilacion_recurrente' },
    pos = { x = 1, y = 2 },
    cost = 10,
    loc_txt = {
        name = 'Infinite Distillation',
        text = {
            "{C:attention}45% chance{} for any used",
            "{C:attention}consumable{} to be recreated"
        }
    },
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_destilacion_infinita = true
        G.GAME.used_vouchers['v_Witch brew_destilacion_infinita'] = true
        G.GAME.used_vouchers.v_destilacion_infinita = true
        G.GAME.used_vouchers.destilacion_infinita = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_destilacion_infinita = false
            G.GAME.current_round.voucher.spawn['v_Witch brew_destilacion_infinita'] = false
        end
    end
}

if Card and Card.use_consumeable then
    local orig_use_consumeable_vouchers = Card.use_consumeable
    function Card:use_consumeable(area, copier)
        local voucher_chance = 0
        if G.GAME and G.GAME.used_vouchers then
            if G.GAME.used_vouchers.v_reality_warp_destilacion_infinita or G.GAME.used_vouchers['v_Witch brew_destilacion_infinita'] or G.GAME.used_vouchers.v_destilacion_infinita or G.GAME.used_vouchers.destilacion_infinita then
                voucher_chance = 45
            elseif G.GAME.used_vouchers.v_reality_warp_destilacion_recurrente or G.GAME.used_vouchers['v_Witch brew_destilacion_recurrente'] or G.GAME.used_vouchers.v_destilacion_recurrente or G.GAME.used_vouchers.destilacion_recurrente then
                voucher_chance = 15
            end
        end

        local will_recreate = false
        local saved_set = (self.ability and self.ability.set) or 'Tarot'
        local saved_key = (self.config and self.config.center and self.config.center.key) or (self.ability and self.ability.name)

        if voucher_chance > 0 and not copier and saved_key and saved_key ~= '' then
            if pseudorandom('destilacion_voucher') < (voucher_chance / 100) then
                will_recreate = true
            end
        end

        local ret = orig_use_consumeable_vouchers(self, area, copier)

        if will_recreate then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
                        play_sound('tarot2', 1.4, 0.85)
                        play_sound('gold_seal', 1.3, 0.9)
                        local new_card = create_card(saved_set, G.consumeables, nil, nil, nil, nil, saved_key, 'destilacion')
                        new_card:add_to_deck()
                        G.consumeables:emplace(new_card)
                        new_card:juice_up(0.6, 0.6)
                        card_eval_status_text(new_card, 'extra', nil, nil, nil, {
                            message = 'Destilado!',
                            colour = G.C.SECONDARY_SET.Tarot
                        })
                    end
                    return true
                end
            }))
        end

        return ret
    end
end

SMODS.Voucher {
    key = 'ambrosia',
    atlas = 'reality_warp_vouchers',
    pos = { x = 0, y = 3 },
    cost = 10,
    config = { extra = { dollars = 20 } },
    loc_txt = {
        name = 'Ambrosia',
        text = {
            "Earn {C:money}+$#1#{} for each",
            "{C:attention}Blind{} defeated"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    in_pool = function(self, args)
        local count = 0
        if G.vouchers and G.vouchers.cards then
            count = #G.vouchers.cards
        elseif G.GAME and G.GAME.used_vouchers then
            for k, v in pairs(G.GAME.used_vouchers) do
                if v and string.sub(k, 1, 2) == 'v_' then
                    count = count + 1
                end
            end
        end
        return count >= 4
    end,
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_ambrosia = true
        G.GAME.used_vouchers['v_Witch brew_ambrosia'] = true
        G.GAME.used_vouchers.v_ambrosia = true
        G.GAME.used_vouchers.ambrosia = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_ambrosia = false
            G.GAME.current_round.voucher.spawn['v_Witch brew_ambrosia'] = false
        end
    end
}

SMODS.Voucher {
    key = 'nectar',
    atlas = 'reality_warp_vouchers',
    requires = { 'v_reality_warp_ambrosia' },
    pos = { x = 1, y = 3 },
    cost = 10,
    config = { extra = { blind_reduction = 5, hand_size = 1, vouchers = 1, shop_space = 1, hands = 1 } },
    loc_txt = {
        name = 'Nectar',
        text = {
            "{C:attention}-#1#%{} Chip Requirement,",
            "{C:attention}+#2#{} Hand Size,",
            "{C:attention}+#3#{} Voucher on Shop,",
            "{C:attention}+#4#{} Shop Space,",
            "{C:attention}+#5#{} Hand"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.blind_reduction,
            card.ability.extra.hand_size,
            card.ability.extra.vouchers,
            card.ability.extra.shop_space,
            card.ability.extra.hands
        } }
    end,
    in_pool = function(self, args)
        local count = 0
        if G.vouchers and G.vouchers.cards then
            count = #G.vouchers.cards
        elseif G.GAME and G.GAME.used_vouchers then
            for k, v in pairs(G.GAME.used_vouchers) do
                if v and string.sub(k, 1, 2) == 'v_' then
                    count = count + 1
                end
            end
        end
        return count >= 4
    end,
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_nectar = true
        G.GAME.used_vouchers['v_Witch brew_nectar'] = true
        G.GAME.used_vouchers.v_nectar = true
        G.GAME.used_vouchers.nectar = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_nectar = false
            G.GAME.current_round.voucher.spawn['v_Witch brew_nectar'] = false
        end
        if G.hand and G.hand.change_size then
            G.hand:change_size(card.ability.extra.hand_size or 1)
        end
        if G.GAME and G.GAME.round_resets then
            G.GAME.round_resets.hand_size = (G.GAME.round_resets.hand_size or 8) + (card.ability.extra.hand_size or 1)
            G.GAME.round_resets.hands = (G.GAME.round_resets.hands or 4) + (card.ability.extra.hands or 1)
        end
        if ease_hands_played then
            ease_hands_played(card.ability.extra.hands or 1)
        end
        if change_shop_size then
            change_shop_size(card.ability.extra.shop_space or 1)
        end
        if G.shop_vouchers and G.shop_vouchers.cards then
            G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + (card.ability.extra.vouchers or 1)
            local v_key = get_next_voucher_key and get_next_voucher_key(true)
            if v_key and G.P_CENTERS and G.P_CENTERS[v_key] then
                local v_card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2, G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[v_key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                create_shop_card_ui(v_card, 'Voucher', G.shop_vouchers)
                v_card:start_materialize()
                G.shop_vouchers:emplace(v_card)
            end
        end
    end
}

SMODS.Voucher {
    key = 'four_leaf_clover',
    atlas = 'reality_warp_vouchers',
    pos = { x = 0, y = 4 },
    cost = 10,
    loc_txt = {
        name = '4 Leaf Clover',
        text = {
            "All {C:green,E:1,S:1.1}probabilities{} have",
            "their requirement reduced by {C:attention}1{}",
            "{C:inactive}(e.g. 1 in 4 -> 1 in 3){}"
        }
    },
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_four_leaf_clover = true
        G.GAME.used_vouchers.v_four_leaf_clover = true
        G.GAME.used_vouchers.four_leaf_clover = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_four_leaf_clover = false
            G.GAME.current_round.voucher.spawn.v_four_leaf_clover = false
        end
    end
}

SMODS.Voucher {
    key = 'oops_all_20d',
    atlas = 'reality_warp_vouchers',
    requires = { 'v_reality_warp_four_leaf_clover' },
    pos = { x = 1, y = 4 },
    cost = 10,
    loc_txt = {
        name = 'Oops! All 20d!',
        text = {
            "All {C:green,E:1,S:1.1}probabilities{} have",
            "their requirement {C:attention}halved{}",
            "{C:inactive}(e.g. 1 in 10 -> 1 in 5){}"
        }
    },
    redeem = function(self, card)
        G.GAME.used_vouchers = G.GAME.used_vouchers or {}
        G.GAME.used_vouchers.v_reality_warp_oops_all_20d = true
        G.GAME.used_vouchers.v_oops_all_20d = true
        G.GAME.used_vouchers.oops_all_20d = true
        if G.GAME.current_round and G.GAME.current_round.voucher and G.GAME.current_round.voucher.spawn then
            G.GAME.current_round.voucher.spawn.v_reality_warp_oops_all_20d = false
            G.GAME.current_round.voucher.spawn.v_oops_all_20d = false
        end
    end
}

local function modify_probability_denominator(den)
    if not den or type(den) ~= 'number' or den <= 1 then return den end
    if G.GAME and G.GAME.used_vouchers then
        if G.GAME.used_vouchers.v_reality_warp_oops_all_20d or G.GAME.used_vouchers.v_oops_all_20d or G.GAME.used_vouchers.oops_all_20d then
            return math.max(1, math.floor(den / 2))
        elseif G.GAME.used_vouchers.v_reality_warp_four_leaf_clover or G.GAME.used_vouchers.v_four_leaf_clover or G.GAME.used_vouchers.four_leaf_clover then
            return math.max(1, den - 1)
        end
    end
    return den
end
G.reality_warp_modify_odds = modify_probability_denominator

if SMODS and SMODS.pseudorandom_probability then
    local orig_smods_pseudorandom_probability = SMODS.pseudorandom_probability
    function SMODS.pseudorandom_probability(card, seed, numerator, denominator, name)
        denominator = modify_probability_denominator(denominator)
        return orig_smods_pseudorandom_probability(card, seed, numerator, denominator, name)
    end
end

if SMODS and SMODS.get_probability_vars then
    local orig_smods_get_probability_vars = SMODS.get_probability_vars
    function SMODS.get_probability_vars(card, numerator, denominator, name)
        denominator = modify_probability_denominator(denominator)
        return orig_smods_get_probability_vars(card, numerator, denominator, name)
    end
end

if get_next_voucher_key then
    local orig_get_next_voucher_key = get_next_voucher_key
    function get_next_voucher_key(from_tag)
        local key = orig_get_next_voucher_key(from_tag)
        local count = 0
        if G.vouchers and G.vouchers.cards then
            count = #G.vouchers.cards
        elseif G.GAME and G.GAME.used_vouchers then
            for k, v in pairs(G.GAME.used_vouchers) do
                if v and string.sub(k, 1, 2) == 'v_' then
                    count = count + 1
                end
            end
        end
        if count < 4 then
            local attempts = 0
            while attempts < 50 and key and (string.find(key, 'ambrosia') or string.find(key, 'nectar')) do
                attempts = attempts + 1
                key = orig_get_next_voucher_key(from_tag)
            end
        end
        return key
    end
end

if G.FUNCS and G.FUNCS.cash_out then
    local orig_cash_out_ambrosia = G.FUNCS.cash_out
    G.FUNCS.cash_out = function(e)
        if G.GAME and G.GAME.used_vouchers and (G.GAME.used_vouchers.v_reality_warp_ambrosia or G.GAME.used_vouchers['v_Witch brew_ambrosia'] or G.GAME.used_vouchers.v_ambrosia or G.GAME.used_vouchers.ambrosia) then
            ease_dollars(20)
            if G.HUD and G.HUD:get_UIE_by_ID('dollar_text_UI') then
                card_eval_status_text(G.HUD:get_UIE_by_ID('dollar_text_UI'), 'extra', nil, nil, nil, { message = '+$20 Ambrosia!', colour = G.C.MONEY })
            end
        end
        return orig_cash_out_ambrosia(e)
    end
end

if Blind and Blind.set_blind then
    local orig_blind_set_blind_nectar = Blind.set_blind
    function Blind:set_blind(blind, reset, silent)
        local ret = orig_blind_set_blind_nectar(self, blind, reset, silent)
        if G.GAME and G.GAME.used_vouchers and (G.GAME.used_vouchers.v_reality_warp_nectar or G.GAME.used_vouchers.v_nectar or G.GAME.used_vouchers.nectar) then
            if self.chips then
                self.chips = math.max(1, math.floor(self.chips * 0.95))
                self.chip_text = number_format(self.chips)
            end
        end
        return ret
    end
end

if G.UIDEF and G.UIDEF.shop then
    local orig_uidef_shop_nectar = G.UIDEF.shop
    G.UIDEF.shop = function()
        local ret = orig_uidef_shop_nectar()
        if G.GAME and G.GAME.used_vouchers and (G.GAME.used_vouchers.v_reality_warp_nectar or G.GAME.used_vouchers.v_nectar or G.GAME.used_vouchers.nectar) then
            if G.shop_vouchers and G.shop_vouchers.cards then
                G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
                local v_key = get_next_voucher_key and get_next_voucher_key(true)
                if v_key and G.P_CENTERS and G.P_CENTERS[v_key] then
                    local v_card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2, G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[v_key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    create_shop_card_ui(v_card, 'Voucher', G.shop_vouchers)
                    v_card:start_materialize()
                    G.shop_vouchers:emplace(v_card)
                end
            end
        end
        return ret
    end
end

