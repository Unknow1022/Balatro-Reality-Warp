SMODS.Atlas {
    key = "enhancements",
    path = "enhancements.png",
    px = 71,
    py = 95
}

function get_custom_enhancement(name, fallback)
    if G.P_CENTERS then
        if G.P_CENTERS['m_reality_warp_' .. name] then return G.P_CENTERS['m_reality_warp_' .. name] end
        if G.P_CENTERS['m_' .. name] then return G.P_CENTERS['m_' .. name] end
        for k, v in pairs(G.P_CENTERS) do
            if type(v) == 'table' and string.find(k, name, 1, true) and v.set == 'Enhanced' then
                return v
            end
        end
    end
    return fallback
end

function get_diamond_enhancement_center() return get_custom_enhancement('diamond', G.P_CENTERS.m_steel) end
function get_investment_enhancement_center() return get_custom_enhancement('investment', G.P_CENTERS.m_gold) end
function get_lead_enhancement_center() return get_custom_enhancement('lead', G.P_CENTERS.m_steel) end
function get_jeweled_enhancement_center() return get_custom_enhancement('jeweled', G.P_CENTERS.m_lucky) end

SMODS.Seal {
    key = 'dark_green',
    atlas = 'enhancements',
    pos = { x = 0, y = 0 },
    badge_colour = HEX('1b4d2e'),
    discovered = true,
    unlocked = true,
    loc_txt = {
        name = 'Dark Green Seal',
        label = 'Dark Green Seal',
        text = {
            "Gives {X:mult,C:white}X2.5{} Mult when scored,",
            "{C:green}#1# in 5{} chance to break",
            "when played"
        }
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, 5, 'dark_green_break')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring or context.individual) and context.cardarea == G.play then
            if not card.dark_green_scored_this_hand then
                card.dark_green_scored_this_hand = true
                if SMODS.pseudorandom_probability(card, 'dark_green_break', 1, 5) then
                    card.dark_green_broken = true
                    card.shattered = true
                end
            end
            return {
                x_mult = 2.5
            }
        end
    end
}

SMODS.Seal {
    key = 'white',
    atlas = 'enhancements',
    pos = { x = 1, y = 0 },
    badge_colour = HEX('ffffff'),
    discovered = true,
    unlocked = true,
    loc_txt = {
        name = 'White Seal',
        label = 'White Seal',
        text = {
            "Upgrades a random {C:attention}poker hand{}",
            "by {C:attention}+1 level{} when scored"
        }
    },
    calculate = function(self, card, context)
        if (context.main_scoring or context.individual) and context.cardarea == G.play then
            local hands = {}
            if G.GAME and G.GAME.hands then
                for k, v in pairs(G.GAME.hands) do
                    if v.visible then
                        table.insert(hands, k)
                    end
                end
                if #hands == 0 then
                    for k, v in pairs(G.GAME.hands) do
                        table.insert(hands, k)
                    end
                end
            end
            local chosen_hand = pseudorandom_element(hands, pseudoseed('white_seal_hand')) or 'High Card'
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname = chosen_hand, level = (G.GAME.hands[chosen_hand] and G.GAME.hands[chosen_hand].level or 1) + 1})
                    level_up_hand(card, chosen_hand, false, 1)
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Level Up!', colour = G.C.SECONDARY_SET.Planet })
                    return true
                end
            }))
        end
    end
}

SMODS.Seal {
    key = 'silver',
    atlas = 'enhancements',
    pos = { x = 2, y = 0 },
    badge_colour = HEX('bdc3c7'),
    discovered = true,
    unlocked = true,
    loc_txt = {
        name = 'Silver Seal',
        label = 'Silver Seal',
        text = {
            "{C:green}#1# in 4{} chance to convert into a {C:attention}Steel Card{} when played.",
            "With {C:attention}Steel Card{}: gives {X:mult,C:white}X#2#{} Mult",
            "when scored and {X:mult,C:white}X#3#{} Mult while held in hand"
        }
    },
    loc_vars = function(self, info_queue, card)
        if info_queue then
            info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, 4, 'silver_to_steel')
        return { vars = { numerator, 2, 2.5, denominator } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring or context.individual) and context.cardarea == G.play then
            local is_steel = (card.ability and card.ability.name == 'Steel Card') or (card.config and card.config.center == G.P_CENTERS.m_steel)
            if not is_steel and SMODS.pseudorandom_probability(card, 'silver_to_steel', 1, 4) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('gold_seal')
                        card:set_ability(G.P_CENTERS.m_steel)
                        card:juice_up(0.6, 0.6)
                        card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Forged into Steel!', colour = G.C.GREY })
                        return true
                    end
                }))
            end
            if is_steel then
                return {
                    x_mult = 2.0,
                    card = card
                }
            end
        end
    end
}

SMODS.Enhancement {
    key = 'diamond',
    atlas = 'enhancements',
    pos = { x = 3, y = 0 },
    discovered = true,
    unlocked = true,
    config = { extra = { x_mult = 1.5, dollars = 3 } },
    loc_txt = {
        name = 'Shiny Card',
        text = {
            "Gives {X:mult,C:white}X#1#{} Mult when {C:attention}retriggered{},",
            "gives {C:money}$#2#{} once when",
            "held in hand at end of round"
        }
    },
    loc_vars = function(self, info_queue, card)
        local x_mult = (card and card.ability and card.ability.extra and card.ability.extra.x_mult) or (self.config and self.config.extra and self.config.extra.x_mult) or 1.5
        local dollars = (card and card.ability and card.ability.extra and card.ability.extra.dollars) or (self.config and self.config.extra and self.config.extra.dollars) or 3
        return { vars = { x_mult, dollars } }
    end,
    calculate = function(self, card, context)
        if card.ability and card.ability.h_dollars and card.ability.h_dollars > 0 then
            card.ability.h_dollars = 0
        end
        local extra = (card and card.ability and card.ability.extra) or (self.config and self.config.extra) or { x_mult = 1.5, dollars = 3 }
        local is_retrigger = (card.repetition_trigger and card.repetition_trigger ~= 0 and card.repetition_trigger ~= false)
            or (card.retrigger_count and card.retrigger_count > 0)
            or (context.retrigger_count and context.retrigger_count > 0)

        if (context.main_scoring or context.cardarea == G.play) and not context.repetition and not context.repetition_only and not context.end_of_round then
            if is_retrigger then
                return {
                    x_mult = extra.x_mult,
                    card = card
                }
            end
        end

        if (context.end_of_round or context.playing_card_end_of_round) and context.cardarea == G.hand then
            if not context.repetition and not context.repetition_only and not is_retrigger then
                return {
                    dollars = extra.dollars,
                    card = card
                }
            end
        end
    end
}

SMODS.Enhancement {
    key = 'investment',
    atlas = 'enhancements',
    pos = { x = 0, y = 1 },
    discovered = true,
    unlocked = true,
    config = { extra = { interest_pct = 10, max_interest = 10 } },
    loc_txt = {
        name = 'Investment Card',
        text = {
            "Earns {C:money}#1#% interest{} on your current money",
            "{C:inactive}(Max {C:money}$#2#{C:inactive}){} when held in hand at end of round"
        }
    },
    loc_vars = function(self, info_queue, card)
        local interest_pct = (card and card.ability and card.ability.extra and card.ability.extra.interest_pct) or (self.config and self.config.extra and self.config.extra.interest_pct) or 10
        local max_interest = (card and card.ability and card.ability.extra and card.ability.extra.max_interest) or (self.config and self.config.extra and self.config.extra.max_interest) or 10
        return { vars = { interest_pct, max_interest } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.hand then
            local current_money = (G.GAME and G.GAME.dollars) or 0
            local interest = math.min(card.ability.extra.max_interest, math.floor(current_money * (card.ability.extra.interest_pct / 100)))
            if interest > 0 then
                ease_dollars(interest)
                return {
                    message = '+$' .. interest .. ' Interest',
                    colour = G.C.MONEY
                }
            end
        end
    end
}

SMODS.Enhancement {
    key = 'lead',
    atlas = 'enhancements',
    pos = { x = 1, y = 1 },
    discovered = true,
    unlocked = true,
    config = { bonus = 10 },
    loc_txt = {
        name = 'Lead Card',
        text = {
            "{C:chips}+#1#{} Chips.",
            "Transmutes permanently at random into",
            "{C:gold}Gold{}, {C:attention}Shiny{}, or {C:grey}Metal Card{}",
            "if hand beats the Blind requirement"
        }
    },
    loc_vars = function(self, info_queue, card)
        if card and card.ability and not card.ability.bonus then
            card.ability.bonus = (self.config and self.config.bonus) or 10
        end
        local bonus = (card and card.ability and card.ability.bonus) or (self.config and self.config.bonus) or 10
        return { vars = { bonus } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring or context.individual) and context.cardarea == G.play then
            card.lead_scored_in_hand = true
        end
    end
}

SMODS.Enhancement {
    key = 'jeweled',
    atlas = 'enhancements',
    pos = {  x = 2, y = 1 },
    discovered = true,
    unlocked = true,
    config = { extra = { x_mult = 1.25, dollars = 2 } },
    loc_txt = {
        name = 'Jeweled Card',
        text = {
            "Gives {X:mult,C:white}X#1#{} Mult and {C:money}$#2#{}",
            "when scored"
        }
    },
    loc_vars = function(self, info_queue, card)
        local x_mult = (card and card.ability and card.ability.extra and card.ability.extra.x_mult) or (self.config and self.config.extra and self.config.extra.x_mult) or 1.25
        local dollars = (card and card.ability and card.ability.extra and card.ability.extra.dollars) or (self.config and self.config.extra and self.config.extra.dollars) or 2
        return { vars = { x_mult, dollars } }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring or context.individual) and context.cardarea == G.play then
            return {
                x_mult = card.ability.extra.x_mult,
                dollars = card.ability.extra.dollars,
                card = card
            }
        end
    end
}

if SMODS and SMODS.Shader then
    SMODS.Shader {
        key = 'blessed',
        path = 'blessed.fs'
    }
    SMODS.Shader {
        key = 'mosaic',
        path = 'mosaic.fs'
    }
    SMODS.Shader {
        key = 'luminous',
        path = 'luminous.fs'
    }
    SMODS.Shader {
        key = 'gilded',
        path = 'gilded.fs'
    }
    SMODS.Shader {
        key = 'prismatic',
        path = 'prismatic.fs'
    }
    SMODS.Shader {
        key = 'supercharged',
        path = 'supercharged.fs'
    }
    SMODS.Shader {
        key = 'astronomical',
        path = 'astronomical.fs'
    }
    SMODS.Shader {
        key = 'glitch',
        path = 'glitch.fs'
    }
end

if SMODS and SMODS.Edition then
    SMODS.Edition {
        key = 'blessed',
        shader = 'blessed',
        badge_colour = HEX('ffd166'),
        weight = 5,
        extra_cost = 4,
        in_shop = true,
        sound = { sound = 'tarot1', per = 1.2, vol = 0.4 },
        loc_txt = {
            name = 'Blessed',
            label = 'Blessed',
            text = {
                "Protected from being",
                "{C:attention}debuffed{}"
            }
        },
        loc_vars = function(self, info_queue)
            return { vars = {} }
        end
    }
end

if SMODS and SMODS.Edition then
    SMODS.Edition {
        key = 'mosaic',
        shader = 'mosaic',
        badge_colour = HEX('00b4d8'),
        weight = 5,
        extra_cost = 4,
        in_shop = true,
        sound = { sound = 'tarot1', per = 1.1, vol = 0.4 },
        config = { x_chips = 1.5 },
        loc_txt = {
            name = 'Mosaic',
            label = 'Mosaic',
            text = {
                "{X:chips,C:white}X#1#{} Chips",
                "{C:inactive}(Original idea from Cryptid Mod){}"
            }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { (card and card.edition and card.edition.x_chips) or (self.config and self.config.x_chips) or 1.5 } }
        end,
        calculate = function(self, card, context)
            if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    x_chips = (card and card.edition and card.edition.x_chips) or (self.config and self.config.x_chips) or 1.5
                }
            end
        end
    }
end

if SMODS and SMODS.Edition then
    SMODS.Edition {
        key = 'luminous',
        shader = 'luminous',
        badge_colour = HEX('ffea00'),
        weight = 4,
        extra_cost = 4,
        in_shop = true,
        sound = { sound = 'holo1', per = 1.2, vol = 0.4 },
        loc_txt = {
            name = 'Luminous',
            label = 'Luminous',
            text = { "{C:attention}+1{} hand size" }
        },
        loc_vars = function(self, info_queue)
            return { vars = {} }
        end,
        add_to_deck = function(self, card, from_debuff)
            G.hand:change_size(1)
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.hand:change_size(-1)
        end
    }
end

if SMODS and SMODS.Edition then
    SMODS.Edition {
        key = 'gilded',
        shader = 'gilded',
        badge_colour = HEX('e5a93b'),
        weight = 5,
        extra_cost = 4,
        in_shop = true,
        sound = { sound = 'coin3', per = 1.1, vol = 0.5 },
        loc_txt = {
            name = 'Gilded',
            label = 'Gilded',
            text = {
                "Earn {C:money}$3{} at end of round",
                "{C:inactive}({C:money}+$1{} when played){}"
            }
        },
        loc_vars = function(self, info_queue)
            return { vars = {} }
        end,
        calculate = function(self, card, context)
            if context.end_of_round and context.cardarea == G.jokers and not context.game_over then
                ease_dollars(3)
                return { message = '+$3', colour = G.C.MONEY }
            elseif context.main_scoring and context.cardarea == G.play then
                ease_dollars(1)
                return { dollars = 1 }
            end
        end
    }
end

local function is_prismatic_edition(ed)
    if not ed then return false end
    if type(ed) == 'string' then
        return ed == 'e_prismatic' or ed == 'e_reality_warp_prismatic' or ed == 'prismatic'
    end
    if type(ed) == 'table' then
        return ed.prismatic or ed.reality_warp_prismatic or ed.key == 'e_prismatic' or ed.key == 'e_reality_warp_prismatic' or ed.type == 'prismatic'
    end
    return false
end

local function is_card_prismatic_eligible(card)
    if not card then return false end
    if not (card.ability and card.ability.set == 'Joker') then
        return true
    end
    local center = card.config and card.config.center
    if center then
        if center.blueprint_compat == false then return false end
        local k = center.key or ''
        if k == 'j_golden' or k == 'j_chaos' or k == 'j_delayed_grat' or k == 'j_juggler' 
           or k == 'j_troubadour' or k == 'j_four_fingers' or k == 'j_credit_card' 
           or k == 'j_shortcut' or k == 'j_smeared' or k == 'j_pareidolia' 
           or k == 'j_burglar' or k == 'j_chicot' or k == 'j_luchador' 
           or k == 'j_diet_cola' or k == 'j_merry_andy' or k == 'j_oops' then
            return false
        end
    end
    if card.ability then
        if card.ability.blueprint_compat == false then return false end
        local n = card.ability.name or ''
        if n == 'Golden Joker' or n == 'Chaos the Clown' or n == 'Delayed Gratification'
           or n == 'Juggler' or n == 'Troubadour' or n == 'Four Fingers'
           or n == 'Credit Card' or n == 'Shortcut' or n == 'Smeared Joker'
           or n == 'Pareidolia' or n == 'Burglar' or n == 'Chicot'
           or n == 'Luchador' or n == 'Diet Cola' or n == 'Merry Andy'
           or n == 'Oops! All 6s' then
            return false
        end
    end
    if type(is_joker_copiable) == 'function' and not is_joker_copiable(card) then
        return false
    end
    return true
end

if SMODS and SMODS.Edition then
    SMODS.Edition {
        key = 'prismatic',
        shader = 'prismatic',
        badge_colour = HEX('a855f7'),
        weight = 2,
        extra_cost = 6,
        in_shop = true,
        sound = { sound = 'polychrome1', per = 1.3, vol = 0.5 },
        loc_txt = {
            name = 'Prismatic',
            label = 'Prismatic',
            text = { "{C:attention}+1{} repetition" }
        },
        loc_vars = function(self, info_queue)
            return { vars = {} }
        end,
        calculate = function(self, card, context)
            if card.ability and card.ability.set == 'Joker' then
                if not is_card_prismatic_eligible(card) then
                    return nil
                end
                if context.retrigger_joker_check and context.other_card == card and not context.retrigger_joker then
                    if context.other_context and (context.other_context.retrigger_joker or context.other_context.retrigger_joker_check) then
                        return nil
                    end
                    local has_effect = false
                    if context.other_ret then
                        if context.other_ret.jokers and type(context.other_ret.jokers) == 'table' and next(context.other_ret.jokers) then
                            has_effect = true
                        elseif type(context.other_ret) == 'table' and (context.other_ret.mult or context.other_ret.chips or context.other_ret.x_mult or context.other_ret.Xmult or context.other_ret.dollars or context.other_ret.message) then
                            has_effect = true
                        end
                    end
                    if has_effect then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = 1,
                            card = card
                        }
                    end
                end
            else
                if context.repetition and context.cardarea == G.play then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            end
        end
    }
end

local function is_supercharged_card(card)
    if not card then return false end
    if card.edition then
        if card.edition.supercharged or card.edition.key == 'e_reality_warp_supercharged' or card.edition.key == 'e_supercharged' or card.edition.type == 'supercharged' then
            return true
        end
    end
    return false
end

local function apply_supercharged_values(card)
    if not card or not card.ability then return false end
    if card.ability.supercharged_applied then return card.ability.supercharged_has_doubled end

    card.ability.supercharged_applied = true
    card.ability.supercharged_orig = {}
    local any_doubled = false

    local skip_keys = {
        odds = true, odd = true, id = true, rank = true, suit = true,
        order = true, cost = true, name = true, set = true, type = true
    }

    if card.ability.extra ~= nil then
        if type(card.ability.extra) == 'number' then
            card.ability.supercharged_orig.extra = card.ability.extra
            card.ability.extra = card.ability.extra * 2
            any_doubled = true
        elseif type(card.ability.extra) == 'table' then
            card.ability.supercharged_orig.extra = {}
            for k, v in pairs(card.ability.extra) do
                if type(v) == 'number' and not skip_keys[k] and v ~= 0 then
                    card.ability.supercharged_orig.extra[k] = v
                    card.ability.extra[k] = v * 2
                    any_doubled = true
                end
            end
        end
    end

    local direct_keys = {
        'mult', 't_mult', 'chips', 't_chips', 'x_mult', 'x_chips',
        'h_mult', 'h_x_mult', 'h_dollars', 'p_dollars', 'bonus', 'd_size', 'h_size'
    }
    for _, k in ipairs(direct_keys) do
        local v = card.ability[k]
        if type(v) == 'number' and v ~= 0 then
            card.ability.supercharged_orig[k] = v
            card.ability[k] = v * 2
            any_doubled = true
        end
    end

    card.ability.supercharged_has_doubled = any_doubled
    return any_doubled
end

local function remove_supercharged_values(card)
    if not card or not card.ability or not card.ability.supercharged_applied then return end
    local orig = card.ability.supercharged_orig
    if orig then
        if orig.extra ~= nil then
            if type(orig.extra) == 'table' and type(card.ability.extra) == 'table' then
                for k, v in pairs(orig.extra) do
                    card.ability.extra[k] = v
                end
            else
                card.ability.extra = orig.extra
            end
        end
        for k, v in pairs(orig) do
            if k ~= 'extra' and type(v) == 'number' then
                card.ability[k] = v
            end
        end
    end
    card.ability.supercharged_orig = nil
    card.ability.supercharged_applied = nil
    card.ability.supercharged_has_doubled = nil
end

if SMODS and SMODS.Edition then
    SMODS.Edition {
        key = 'supercharged',
        shader = 'supercharged',
        badge_colour = HEX('ff3366'),
        weight = 4,
        extra_cost = 5,
        in_shop = true,
        sound = { sound = 'foil1', per = 1.25, vol = 0.45 },
        config = { chips = 100, mult = 25 },
        loc_txt = {
            name = 'Supercharged',
            label = 'Supercharged',
            text = {
                "Doubles all numeric values",
                "of this {C:attention}Joker{} or card if possible;",
                "otherwise gives {C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult"
            }
        },
        loc_vars = function(self, info_queue, card)
            if card and is_supercharged_card(card) then
                apply_supercharged_values(card)
            end
            local chips = (card and card.edition and card.edition.chips) or (self.config and self.config.chips) or 100
            local mult = (card and card.edition and card.edition.mult) or (self.config and self.config.mult) or 25
            return { vars = { chips, mult } }
        end,
        add_to_deck = function(self, card, from_debuff)
            if is_supercharged_card(card) then
                apply_supercharged_values(card)
            end
        end,
        remove_from_deck = function(self, card, from_debuff)
            remove_supercharged_values(card)
        end,
        calculate = function(self, card, context)
            if card and is_supercharged_card(card) then
                apply_supercharged_values(card)
            end
            if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
                local was_doubled = card.ability and card.ability.supercharged_has_doubled
                if not was_doubled then
                    return {
                        chips = (card and card.edition and card.edition.chips) or (self.config and self.config.chips) or 100,
                        mult = (card and card.edition and card.edition.mult) or (self.config and self.config.mult) or 25
                    }
                end
            end
        end
    }
end

if SMODS and SMODS.Edition then
    SMODS.Edition {
        key = 'astronomical',
        shader = 'astronomical',
        badge_colour = HEX('4338ca'),
        weight = 2,
        extra_cost = 6,
        in_shop = true,
        sound = { sound = 'polychrome1', per = 1.15, vol = 0.45 },
        config = { x_chips = 1.2, x_mult = 1.2 },
        loc_txt = {
            name = 'Astronomical',
            label = 'Astronomical',
            text = {
                "{X:chips,C:white}X#1#{} Chips and",
                "{X:mult,C:white}X#2#{} Mult"
            }
        },
        loc_vars = function(self, info_queue, card)
            local xc = (card and card.edition and card.edition.x_chips) or (self.config and self.config.x_chips) or 1.2
            local xm = (card and card.edition and card.edition.x_mult) or (self.config and self.config.x_mult) or 1.2
            return { vars = { xc, xm } }
        end,
        calculate = function(self, card, context)
            if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    x_chips = (card and card.edition and card.edition.x_chips) or (self.config and self.config.x_chips) or 1.2,
                    x_mult = (card and card.edition and card.edition.x_mult) or (self.config and self.config.x_mult) or 1.2
                }
            end
        end
    }
end

if SMODS and SMODS.Edition then
    SMODS.Edition {
        key = 'glitch',
        shader = 'glitch',
        badge_colour = HEX('00ffcc'),
        weight = 2,
        extra_cost = 5,
        in_shop = true,
        sound = { sound = 'holo1', per = 1.35, vol = 0.5 },
        loc_txt = {
            name = 'Glitch',
            label = 'Glitch',
            text = {
                "When scored, triggers {C:attention}1{} of {C:attention}6{} random effects:",
                "{C:money}+$1-$10{}, {C:chips}+50-400{} Chips, {C:mult}+20-150{} Mult,",
                "{X:chips,C:white}X1.1-X2.0{} Chips, {X:mult,C:white}X1.1-X1.8{} Mult,",
                "or creates a random {C:attention}consumable{} {C:inactive}(incl. Potions){}",
                "with a {C:green}1 in 2{} chance to be {C:dark_edition}Negative{}",
                "{C:inactive}(Effect outcome is hidden){}"
            }
        },
        loc_vars = function(self, info_queue)
            return { vars = {} }
        end,
        calculate = function(self, card, context)
            if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
                local glitch_texts = {
                    '0x' .. string.format('%X', pseudorandom('gl_hex', 4096, 65535)),
                    'ERR_404',
                    'NULL_PTR',
                    '#%!@?&',
                    'SYS_CRASH',
                    'BUFFER_OVFL',
                    'SYNTAX_ERR',
                    'CORRUPT_DAT',
                    'NIL_VAL',
                    '0xDEADBEEF',
                    'STACK_ERR',
                    'SEG_FAULT',
                    'NaN#ERR',
                    '#!?@#$',
                }
                local glitch_colors = {
                    HEX('00ffcc'), HEX('ff0055'), HEX('ffff00'), HEX('00ffff'),
                    HEX('ff00ff'), HEX('76ff03'), HEX('ff3d00'), HEX('e040fb'),
                    HEX('00e5ff'), HEX('ff1744'), HEX('651fff'), HEX('00e676'),
                    G.C.MULT, G.C.CHIPS, G.C.MONEY, G.C.PURPLE
                }
                local err_msg = pseudorandom_element(glitch_texts, pseudoseed('glitch_txt'))
                local err_col = pseudorandom_element(glitch_colors, pseudoseed('glitch_col'))

                if card and card.juice_up then card:juice_up(0.6, 0.4) end

                local roll = pseudorandom('glitch_outcome_' .. (G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante or 1) .. '_' .. (card and card.ID or 0) .. '_' .. (G.GAME and G.GAME.hands_played or 0), 1, 6)

                if roll == 1 then
                    local d = pseudorandom('glitch_d', 1, 10)
                    ease_dollars(d)
                elseif roll == 2 then
                    local c = pseudorandom('glitch_c', 50, 400)
                    if mod_chips and hand_chips then
                        hand_chips = mod_chips(hand_chips + c)
                    elseif hand_chips then
                        hand_chips = hand_chips + c
                    end
                    update_hand_text({ delay = 0 }, { chips = hand_chips })
                elseif roll == 3 then
                    local m = pseudorandom('glitch_m', 20, 150)
                    if mod_mult and mult then
                        mult = mod_mult(mult + m)
                    elseif mult then
                        mult = mult + m
                    end
                    update_hand_text({ delay = 0 }, { mult = mult })
                elseif roll == 4 then
                    local xc = 1.1 + pseudorandom('glitch_xc') * 0.9
                    xc = math.floor(xc * 100) / 100
                    if mod_chips and hand_chips then
                        hand_chips = mod_chips(hand_chips * xc)
                    elseif hand_chips then
                        hand_chips = hand_chips * xc
                    end
                    update_hand_text({ delay = 0 }, { chips = hand_chips })
                elseif roll == 5 then
                    local xm = 1.1 + pseudorandom('glitch_xm') * 0.7
                    xm = math.floor(xm * 100) / 100
                    if mod_mult and mult then
                        mult = mod_mult(mult * xm)
                    elseif mult then
                        mult = mult * xm
                    end
                    update_hand_text({ delay = 0 }, { mult = mult })
                else
                    local is_neg = pseudorandom('glitch_neg') < 0.5
                    local has_space = G.consumeables and (#G.consumeables.cards + (G.GAME.consumeable_buffer or 0) < G.consumeables.config.card_limit)
                    if not has_space then
                        is_neg = true
                    end
                    if G.consumeables then
                        G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                local c_type = pseudorandom_element({'Tarot', 'Planet', 'Spectral', 'Potion'}, pseudoseed('glitch_c_type'))
                                local c_card = create_card(c_type, G.consumeables, nil, nil, nil, nil, nil, 'glitch_consumable')
                                if is_neg then
                                    c_card:set_edition({ negative = true }, true)
                                end
                                c_card:add_to_deck()
                                G.consumeables:emplace(c_card)
                                G.GAME.consumeable_buffer = math.max(0, (G.GAME.consumeable_buffer or 1) - 1)
                                return true
                            end)
                        }))
                    end
                end

                return {
                    message = err_msg,
                    colour = err_col
                }
            end
        end
    }
end

local function sync_reality_warp_edition_loc()
    if G.localization and G.localization.descriptions and G.localization.descriptions.Edition then
        for _, k in ipairs({
            'e_reality_warp_blessed', 'e_blessed', 'blessed',
            'e_reality_warp_mosaic', 'e_mosaic', 'mosaic',
            'e_reality_warp_luminous', 'e_luminous', 'luminous',
            'e_reality_warp_gilded', 'e_gilded', 'gilded',
            'e_reality_warp_prismatic', 'e_prismatic', 'prismatic',
            'e_reality_warp_supercharged', 'e_supercharged', 'supercharged',
            'e_reality_warp_astronomical', 'e_astronomical', 'astronomical',
            'e_reality_warp_glitch', 'e_glitch', 'glitch'
        }) do
            local e_entry = G.localization.descriptions.Edition[k]
            if e_entry and type(e_entry) == 'table' then
                e_entry.text_parsed = nil
                if reparse_localization_entry then
                    reparse_localization_entry(e_entry)
                elseif loc_parse_string and e_entry.text then
                    e_entry.text_parsed = {}
                    for _, line in ipairs(e_entry.text) do
                        e_entry.text_parsed[#e_entry.text_parsed + 1] = loc_parse_string(line)
                    end
                end
            end
        end
    end
end
sync_reality_warp_edition_loc()
if G.E_MANAGER then
    G.E_MANAGER:add_event(Event({
        func = function()
            sync_reality_warp_edition_loc()
            return true
        end
    }))
end

local function is_blessed_card(card)
    if not card then return false end
    if card.edition then
        if card.edition.blessed or card.edition.bendecido then return true end
        if card.edition.key == 'e_reality_warp_blessed' or card.edition.key == 'e_blessed' or card.edition.type == 'blessed' then return true end
    end
    return false
end

local function is_mosaic_card(card)
    if not card then return false end
    if card.edition then
        if card.edition.mosaic or card.edition.mosaico then return true end
        if card.edition.key == 'e_reality_warp_mosaic' or card.edition.key == 'e_mosaic' or card.edition.type == 'mosaic' then return true end
    end
    return false
end

if Card then
    local orig_set_debuff = Card.set_debuff
    function Card:set_debuff(should_debuff)
        if should_debuff and is_blessed_card(self) then
            self.debuff = false
            return
        end
        return orig_set_debuff(self, should_debuff)
    end

    local custom_ed_map = {
        glitch = 'e_reality_warp_glitch',
        e_glitch = 'e_reality_warp_glitch',
        blessed = 'e_reality_warp_blessed',
        e_blessed = 'e_reality_warp_blessed',
        mosaic = 'e_reality_warp_mosaic',
        e_mosaic = 'e_reality_warp_mosaic',
        luminous = 'e_reality_warp_luminous',
        e_luminous = 'e_reality_warp_luminous',
        gilded = 'e_reality_warp_gilded',
        e_gilded = 'e_reality_warp_gilded',
        prismatic = 'e_reality_warp_prismatic',
        e_prismatic = 'e_reality_warp_prismatic',
        supercharged = 'e_reality_warp_supercharged',
        e_supercharged = 'e_reality_warp_supercharged',
        astronomical = 'e_reality_warp_astronomical',
        e_astronomical = 'e_reality_warp_astronomical',
    }

    local orig_set_edition = Card.set_edition
    function Card:set_edition(edition, immediate, silent)
        if type(edition) == 'string' and custom_ed_map[edition] then
            edition = custom_ed_map[edition]
        elseif type(edition) == 'table' then
            for k, v in pairs(edition) do
                if v and custom_ed_map[k] then
                    edition = custom_ed_map[k]
                    break
                end
            end
        end
        if is_prismatic_edition(edition) and self.ability and self.ability.set == 'Joker' and not is_card_prismatic_eligible(self) then
            local fallback = poll_edition('prismatic_fallback', nil, true, true, { 'e_polychrome', 'e_holo', 'e_foil' })
            return orig_set_edition(self, fallback, immediate, silent)
        end
        if self.ability and self.ability.supercharged_applied and not is_supercharged_card({ edition = edition }) then
            remove_supercharged_values(self)
        end
        local ret = orig_set_edition(self, edition, immediate, silent)
        if is_blessed_card(self) then
            self.debuff = false
        end
        if is_supercharged_card(self) then
            apply_supercharged_values(self)
        end
        return ret
    end

function apply_glitch_to_joker(joker, glitch_card)
    if not joker or not glitch_card or glitch_card.destroyed or glitch_card.shattered or glitch_card.glitch_used then return end
    glitch_card.glitch_used = true
    glitch_card.destroyed = true

    -- Oversaturated loud sound effects
    play_sound('tarot1', 0.5, 1.0)
    play_sound('foil1', 0.4, 1.0)
    play_sound('holo1', 0.5, 1.0)
    play_sound('polychrome1', 0.6, 1.0)
    play_sound('generic1', 0.4, 1.0)

    -- Give Joker the Glitch edition
    joker:set_edition('e_reality_warp_glitch', true)
    joker:juice_up(1.0, 1.0)

    attention_text({
        text = 'GLITCHED!',
        scale = 0.9,
        hold = 1.3,
        backdrop_colour = HEX('00ffcc'),
        align = 'cm',
        offset = { x = 0, y = -1 }
    })

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            glitch_card:start_dissolve()
            return true
        end
    }))
end

    local orig_card_update = Card.update
    function Card:update(dt)
        orig_card_update(self, dt)
        if self.debuff and is_blessed_card(self) then
            self.debuff = false
        end
        if self.config and self.config.center and (self.config.center.key == 'c_reality_warp_glitch' or self.config.center.key == 'c_glitch') and not self.destroyed and not self.glitch_used then
            local dragged = G.CONTROLLER and G.CONTROLLER.dragging and G.CONTROLLER.dragging.target
            if dragged and dragged ~= self and dragged.ability and dragged.ability.set == 'Joker' and not dragged.destroyed and not dragged.shattered then
                local dx = math.abs(dragged.T.x - self.T.x)
                local dy = math.abs(dragged.T.y - self.T.y)
                if dx < (self.T.w * 0.9) and dy < (self.T.h * 0.9) then
                    if not G.CONTROLLER.cursor_down or (dragged.states and dragged.states.drag and not dragged.states.drag.is) then
                        apply_glitch_to_joker(dragged, self)
                    end
                end
            elseif dragged == self and G.jokers and G.jokers.cards then
                for _, j in ipairs(G.jokers.cards) do
                    if j and j.ability and j.ability.set == 'Joker' and not j.destroyed and not j.shattered then
                        local dx = math.abs(self.T.x - j.T.x)
                        local dy = math.abs(self.T.y - j.T.y)
                        if dx < (j.T.w * 0.9) and dy < (j.T.h * 0.9) then
                            if not G.CONTROLLER.cursor_down or (self.states and self.states.drag and not self.states.drag.is) then
                                apply_glitch_to_joker(j, self)
                                break
                            end
                        end
                    end
                end
            end
        end
    end

    local orig_card_stop_drag = Card.stop_drag
    function Card:stop_drag()
        if orig_card_stop_drag then orig_card_stop_drag(self) end
        if self.ability and self.ability.set == 'Joker' and not self.destroyed and not self.shattered and G.consumeables and G.consumeables.cards then
            for _, c in ipairs(G.consumeables.cards) do
                if c and c.config and c.config.center and (c.config.center.key == 'c_reality_warp_glitch' or c.config.center.key == 'c_glitch') and not c.destroyed and not c.glitch_used then
                    local dx = math.abs(self.T.x - c.T.x)
                    local dy = math.abs(self.T.y - c.T.y)
                    if dx < (c.T.w * 1.0) and dy < (c.T.h * 1.0) then
                        apply_glitch_to_joker(self, c)
                        break
                    end
                end
            end
        elseif self.config and self.config.center and (self.config.center.key == 'c_reality_warp_glitch' or self.config.center.key == 'c_glitch') and not self.destroyed and not self.glitch_used and G.jokers and G.jokers.cards then
            for _, j in ipairs(G.jokers.cards) do
                if j and j.ability and j.ability.set == 'Joker' and not j.destroyed and not j.shattered then
                    local dx = math.abs(self.T.x - j.T.x)
                    local dy = math.abs(self.T.y - j.T.y)
                    if dx < (j.T.w * 1.0) and dy < (j.T.h * 1.0) then
                        apply_glitch_to_joker(j, self)
                        break
                    end
                end
            end
        end
    end

end

if Blind and Blind.debuff_card then
    local orig_debuff_card = Blind.debuff_card
    function Blind:debuff_card(card, from_blind)
        if is_blessed_card(card) then
            card.debuff = false
            return false
        end
        return orig_debuff_card(self, card, from_blind)
    end
end

local function init_custom_editions_loc()
    if not (G.localization and G.localization.descriptions) then return end
    G.localization.descriptions.Edition = G.localization.descriptions.Edition or {}
    
    G.localization.descriptions.Edition.e_reality_warp_blessed = {
        name = "Blessed",
        label = "Blessed",
        text = {
            "Protected from being",
            "{C:attention}debuffed{}"
        }
    }
    G.localization.descriptions.Edition.blessed = G.localization.descriptions.Edition.e_reality_warp_blessed
    G.localization.descriptions.Edition.e_blessed = G.localization.descriptions.Edition.e_reality_warp_blessed

    G.localization.descriptions.Edition.e_reality_warp_mosaic = {
        name = "Mosaic",
        label = "Mosaic",
        text = {
            "{X:chips,C:white}X1.5{} Chips",
            "{C:inactive}(Original idea from Cryptid Mod){}"
        }
    }
    G.localization.descriptions.Edition.mosaic = G.localization.descriptions.Edition.e_reality_warp_mosaic
    G.localization.descriptions.Edition.e_mosaic = G.localization.descriptions.Edition.e_reality_warp_mosaic

    G.localization.descriptions.Edition.e_reality_warp_glitch = {
        name = "Glitch",
        label = "Glitch",
        text = {
            "When scored, triggers {C:attention}1{} of {C:attention}6{} random effects:",
            "{C:money}+$1-$10{}, {C:chips}+50-400{} Chips, {C:mult}+20-150{} Mult,",
            "{X:chips,C:white}X1.1-X2.0{} Chips, {X:mult,C:white}X1.1-X1.8{} Mult,",
            "or creates a random {C:attention}consumable{} {C:inactive}(incl. Potions){}",
            "with a {C:green}1 in 2{} chance to be {C:dark_edition}Negative{}",
            "{C:inactive}(Effect outcome is hidden){}"
        }
    }
    G.localization.descriptions.Edition.glitch = G.localization.descriptions.Edition.e_reality_warp_glitch
    G.localization.descriptions.Edition.e_glitch = G.localization.descriptions.Edition.e_reality_warp_glitch

    G.localization.descriptions.Edition.e_reality_warp_supercharged = {
        name = "Supercharged",
        label = "Supercharged",
        text = {
            "Doubles all numeric values",
            "of this {C:attention}Joker{} or card if possible;",
            "otherwise gives {C:chips}+100{} Chips and {C:mult}+25{} Mult"
        }
    }
    G.localization.descriptions.Edition.supercharged = G.localization.descriptions.Edition.e_reality_warp_supercharged
    G.localization.descriptions.Edition.e_supercharged = G.localization.descriptions.Edition.e_reality_warp_supercharged

    G.localization.descriptions.Other = G.localization.descriptions.Other or {}
    G.localization.descriptions.Other.blessed = G.localization.descriptions.Edition.e_reality_warp_blessed
    G.localization.descriptions.Other.e_reality_warp_blessed = G.localization.descriptions.Edition.e_reality_warp_blessed
    G.localization.descriptions.Other.mosaic = G.localization.descriptions.Edition.e_reality_warp_mosaic
    G.localization.descriptions.Other.e_reality_warp_mosaic = G.localization.descriptions.Edition.e_reality_warp_mosaic
    G.localization.descriptions.Other.glitch = G.localization.descriptions.Edition.e_reality_warp_glitch
    G.localization.descriptions.Other.e_reality_warp_glitch = G.localization.descriptions.Edition.e_reality_warp_glitch
    G.localization.descriptions.Other.supercharged = G.localization.descriptions.Edition.e_reality_warp_supercharged
    G.localization.descriptions.Other.e_reality_warp_supercharged = G.localization.descriptions.Edition.e_reality_warp_supercharged

    if G.P_CENTERS then
        for _, k in ipairs({ 'blessed', 'mosaic', 'luminous', 'gilded', 'prismatic', 'supercharged', 'astronomical', 'glitch' }) do
            if G.P_CENTERS['e_reality_warp_' .. k] then
                G.P_CENTERS['e_' .. k] = G.P_CENTERS['e_reality_warp_' .. k]
            end
        end
    end
end

init_custom_editions_loc()
if G.E_MANAGER then
    G.E_MANAGER:add_event(Event({
        func = function()
            init_custom_editions_loc()
            return true
        end
    }))
end

if SMODS and SMODS.Consumable then
    if not (SMODS.Atlases and SMODS.Atlases.reality_warp_glitch) then
        SMODS.Atlas {
            key = "reality_warp_glitch",
            path = "glitch.png",
            px = 71,
            py = 95
        }
    end

    SMODS.Consumable {
        key = 'glitch',
        set = 'Spectral',
        atlas = 'reality_warp_glitch',
        pos = { x = 0, y = 0 },
        in_pool = function(self, args)
            return false
        end,
        loc_txt = {
            name = 'Glitch',
            text = {
                "Drag a {C:attention}Joker{} onto this card",
                "to grant it {C:dark_edition}Glitch{} edition.",
                "{C:inactive,s:0.85}(Self-destructs after 1 round){}"
            }
        },
        loc_vars = function(self, info_queue, card)
            if info_queue then
                info_queue[#info_queue + 1] = G.P_CENTERS.e_reality_warp_glitch or G.P_CENTERS.e_glitch
            end
            return { vars = {} }
        end,
        can_use = function(self, card)
            if G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 then
                local target = G.jokers.highlighted[1]
                return target.ability and target.ability.set == 'Joker'
            end
            return false
        end,
        use = function(self, card, area, copier)
            if G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 then
                local target = G.jokers.highlighted[1]
                apply_glitch_to_joker(target, card)
            end
        end
    }

    SMODS.DrawStep {
        key = 'glitch_consumable_shader',
        order = 22,
        func = function(self, layer)
            if self.config and self.config.center and (self.config.center.key == 'c_reality_warp_glitch' or self.config.center.key == 'c_glitch') then
                if self.children and self.children.center then
                    local sh = G.SHADERS and (G.SHADERS['reality_warp_glitch'] or G.SHADERS['glitch'])
                    if sh then
                        if not G.SHADERS['glitch'] then G.SHADERS['glitch'] = sh end
                        pcall(function()
                            if sh:hasUniform('time') then
                                sh:send('time', (G.TIMERS and G.TIMERS.REAL) or (love.timer and love.timer.getTime()) or 0)
                            end
                        end)
                        local sh_name = G.SHADERS['reality_warp_glitch'] and 'reality_warp_glitch' or 'glitch'
                        self.children.center:draw_shader(sh_name, nil, self.ARGS.send_to_shader)
                    end
                end
            end
        end,
        conditions = { vortex = false, facing = 'front' }
    }

    if Game and Game.update then
        local orig_game_update_glitch = Game.update
        function Game:update(dt)
            orig_game_update_glitch(self, dt)
            local sh = G.SHADERS and (G.SHADERS['reality_warp_glitch'] or G.SHADERS['glitch'])
            if sh then
                if not G.SHADERS['glitch'] then G.SHADERS['glitch'] = sh end
                pcall(function()
                    if sh:hasUniform('time') then
                        sh:send('time', (G.TIMERS and G.TIMERS.REAL) or (love.timer and love.timer.getTime()) or 0)
                    end
                end)
            end
        end
    end
end

if new_round then
    local orig_new_round_glitch = new_round
    function new_round()
        orig_new_round_glitch()
        if G.GAME and G.consumeables then
            local seed = 'glitch_spawn_' .. (G.GAME.round_resets and G.GAME.round_resets.ante or 1) .. '_' .. (G.GAME.round or 0)
            if pseudorandom(seed) < ((G.GAME and G.GAME.probabilities.normal or 1) / 13) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local center = (G.P_CENTERS and (G.P_CENTERS['c_reality_warp_glitch'] or G.P_CENTERS['c_glitch']))
                        local card = nil
                        if center then
                            card = Card(G.consumeables.T.x + G.consumeables.T.w/2, G.consumeables.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
                        else
                            card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_reality_warp_glitch', 'glitch_spawn')
                        end
                        if card then
                            card:set_edition({ negative = true }, true)
                            card.ability.glitch_rounds_left = 1
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            card:juice_up(0.6, 0.6)
                            play_sound('holo1', 1.4, 0.7)
                        end
                        return true
                    end
                }))
            end
        end
    end
end

if end_round then
    local orig_end_round_glitch = end_round
    function end_round()
        orig_end_round_glitch()
        if G.consumeables and G.consumeables.cards then
            for i = #G.consumeables.cards, 1, -1 do
                local c = G.consumeables.cards[i]
                if c and c.config and c.config.center and (c.config.center.key == 'c_reality_warp_glitch' or c.config.center.key == 'c_glitch') then
                    c.ability.glitch_rounds_left = (c.ability.glitch_rounds_left or 1) - 1
                    if c.ability.glitch_rounds_left <= 0 then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                card_eval_status_text(c, 'extra', nil, nil, nil, { message = 'Broken!', colour = G.C.RED })
                                play_sound('tarot1', 0.5, 0.8)
                                c:start_dissolve()
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
end

