SMODS.Atlas {
    key = "reality_warp_jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}
SMODS.Joker {
    key = 'masterful_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Masterful Joker',
        text = {
            "If played hand contains a",
            "{C:attention}Four of a Kind{}, creates a",
            "random {C:tarot}Tarot{} card",
            "{C:inactive}(Must have room){}"
        }
    },
    config = { extra = {} },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and context.poker_hands and context.poker_hands['Four of a Kind'] and next(context.poker_hands['Four of a Kind']) then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message = 'Tarot!',
                        colour = G.C.PURPLE,
                        message_card = card,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.add_card { set = 'Tarot', key_append = 'mas' }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end
                            }))
                        end
                    }
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'outstanding_joker',
    atlas = 'reality_warp_jokers',
    unlocked = false,
    loc_txt = {
        name = 'Outstanding Joker',
        text = {
            "Retrigger the {C:attention}highest{}",
            "rank card(s) in played",
            "hand {C:attention}1{} additional time"
        },
        unlock = {
            "Play a",
            "{C:attention}Five of a Kind{}"
        }
    },
    config = { extra = { repetitions = 1 } },
    rarity = 1,
    pos = { x = 1, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { (card and card.ability and card.ability.extra and card.ability.extra.repetitions) or 1 } }
    end,
    check_for_unlock = function(self, args)
        if (args.type == 'hand' or args.type == 'play_hand') and (args.handname == 'Five of a Kind' or args.handname == 'Flush Five') then
            return true
        end
        if G.GAME and G.GAME.hands and G.GAME.hands['Five of a Kind'] and (G.GAME.hands['Five of a Kind'].played or 0) > 0 then
            return true
        end
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local cards_to_check = context.scoring_hand or context.full_hand
            if cards_to_check and #cards_to_check > 0 then
                local highest_rank = -1
                for _, c in ipairs(cards_to_check) do
                    local r = (c.get_id and c:get_id()) or (c.base and c.base.id) or 0
                    if r > highest_rank then
                        highest_rank = r
                    end
                end
                local this_r = (context.other_card.get_id and context.other_card:get_id()) or (context.other_card.base and context.other_card.base.id) or 0
                if highest_rank > 0 and this_r == highest_rank then
                    return {
                        repetitions = (card.ability.extra and card.ability.extra.repetitions) or 1,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker {
    key = 'blueberry_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Blueberry',
        text = {
            "{C:blue}+1{} Hand when {C:attention}Blind{} is selected.",
            "Self-destructs after {C:attention}#1#{} round#2#{}",
            "{C:inactive}(Art by kars_on_mars){}"
        }
    },
    config = { extra = { hands = 1, rounds_left = 3 } },
    rarity = 1,
    pos = { x = 2, y = 0 },
    cost = 4,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        local r = (card and card.ability and card.ability.extra and card.ability.extra.rounds_left) or 3
        return { vars = { r, (r == 1 and '' or 's') } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            ease_hands_played(card.ability.extra.hands)
            return {
                message = '+1 Hand!',
                colour = G.C.BLUE
            }
        end

        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
            if card.ability.extra.rounds_left <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = 'Expired!',
                    colour = G.C.RED
                }
            else
                return {
                    message = card.ability.extra.rounds_left .. ' left!',
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'dj_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'DJ Joker',
        text = {
            "If played hand contains only {C:attention}1 card{},",
            "converts it into a random {C:attention}Lucky{},",
            "{C:attention}Steel{}, {C:attention}Gold{}, or {C:attention}Glass{} card",
            "{C:inactive}(Once per round, #1#){}"
        }
    },
    config = { extra = { used = false } },
    rarity = 2,
    pos = { x = 3, y = 0 },
    cost = 6,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        local used = (card and card.ability and card.ability.extra and card.ability.extra.used) or false
        local status_text = used and "Used this round" or "Available"
        return { vars = { status_text } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra = card.ability.extra or {}
            if not card.ability.extra.used then
                local play_count = (context.full_hand and #context.full_hand) or (context.scoring_hand and #context.scoring_hand) or (G.play and G.play.cards and #G.play.cards) or 0
                if play_count == 1 and context.scoring_hand and #context.scoring_hand == 1 then
                    card.ability.extra.used = true
                    local target_card = context.scoring_hand[1]
                    local enhancements = { G.P_CENTERS.m_lucky, G.P_CENTERS.m_steel, G.P_CENTERS.m_gold, G.P_CENTERS.m_glass }
                    local chosen_enh = pseudorandom_element(enhancements, pseudoseed('dj_joker'))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            play_sound('tarot1')
                            target_card:set_ability(chosen_enh)
                            target_card:juice_up(0.5, 0.5)
                            card:juice_up(0.3, 0.5)
                            card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Remixed!', colour = G.C.SECONDARY_SET.Enhanced })
                            return true
                        end
                    }))
                end
            end
        end

        if (context.end_of_round or context.setting_blind) and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra = card.ability.extra or {}
            card.ability.extra.used = false
        end
    end,
}

SMODS.Joker {
    key = 'disenador_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Designer Joker',
        text = {
            "Scored {C:attention}Wild Cards{} give {C:money}$#1#{}"
        }
    },
    config = { extra = { dollars = 1 } },
    rarity = 1,
    pos = { x = 4, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { (card and card.ability and card.ability.extra and card.ability.extra.dollars) or 1 } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if is_wild_card(context.other_card) then
                local d = (card.ability and card.ability.extra and card.ability.extra.dollars) or 1
                ease_dollars(d)
                return {
                    dollars = d,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'discard_accumulator',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Discard Accumulator',
        text = {
            "Gains {C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
            "for each discard remaining at end of round",
            "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips, {C:mult}+#4#{C:inactive} Mult){}",
            "{C:inactive}(Resets after defeating a Boss Blind){}"
        }
    },
    config = { extra = { chips_per_discard = 15, mult_per_discard = 2, chips = 0, mult = 0 } },
    rarity = 1,
    pos = { x = 6, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        return { vars = { ex.chips_per_discard or 15, ex.mult_per_discard or 2, ex.chips or 0, ex.mult or 0 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local ex = card.ability.extra or {}
            local chips = ex.chips or 0
            local mult = ex.mult or 0
            if chips > 0 or mult > 0 then
                return { chips = chips, mult = mult, card = card }
            end
        end

        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            local discards = (G.GAME and G.GAME.current_round and G.GAME.current_round.discards_left) or 0
            if discards > 0 then
                card.ability.extra.chips = (card.ability.extra.chips or 0) + discards * (card.ability.extra.chips_per_discard or 15)
                card.ability.extra.mult = (card.ability.extra.mult or 0) + discards * (card.ability.extra.mult_per_discard or 2)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = '+' .. tostring(discards * card.ability.extra.chips_per_discard) .. ' Chips, +' .. tostring(discards * card.ability.extra.mult_per_discard) .. ' Mult!',
                    colour = G.C.CHIPS
                })
            end
            if G.GAME and G.GAME.blind and G.GAME.blind.boss then
                card.ability.extra.chips = 0
                card.ability.extra.mult = 0
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Reset!', colour = G.C.RED })
            end
        end
    end
}


SMODS.Joker {
    key = 'puppet_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Puppet',
        text = {
            "At the start of each blind,",
            "{C:attention}swap{} the leftmost card in hand",
            "with a {C:attention}random card{} in your deck"
        }
    },
    config = { extra = {} },
    rarity = 1,
    pos = { x = 0, y = 6 },
    cost = 4,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.drawn_triggered = false
        end
        if (context.first_hand_drawn or (context.setting_blind and not card.ability.extra.drawn_triggered)) and not context.blueprint then
            card.ability.extra.drawn_triggered = true
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    if G.hand and G.hand.cards and #G.hand.cards >= 1 and G.deck and G.deck.cards and #G.deck.cards >= 1 then
                        local hand_card = G.hand.cards[1]
                        local swap_target = pseudorandom_element(G.deck.cards, pseudoseed('marioneta'))
                        G.hand:remove_card(hand_card)
                        G.deck:emplace(hand_card)
                        G.deck:remove_card(swap_target)
                        G.hand:emplace(swap_target)
                        hand_card:juice_up(0.3, 0.5)
                        swap_target:juice_up(0.3, 0.5)
                        card:juice_up(0.2, 0.3)
                        card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Swapped!', colour = G.C.ATTENTION })
                    end
                    return true
                end
            }))
        end
    end
}

SMODS.Joker {
    key = 'amnesia_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Amnesia',
        text = {
            "During the {C:attention}first hand{} of each blind,",
            "your {C:attention}most played{} hand scores as",
            "your {C:attention}least played{} hand"
        }
    },
    config = { extra = { first_done = false, saved_level = 0, most_key = '', least_key = '' } },
    rarity = 1,
    pos = { x = 1, y = 6 },
    cost = 4,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.first_done = false
            card.ability.extra.saved_level = 0
            card.ability.extra.most_key = ''
            card.ability.extra.least_key = ''
            local most_key, most_count = '', -1
            local least_key, least_count = '', math.huge
            if G.GAME and G.GAME.hands then
                for k, h in pairs(G.GAME.hands) do
                    if h.visible then
                        local p = h.played or 0
                        if p > most_count then most_count = p; most_key = k end
                        if p < least_count then least_count = p; least_key = k end
                    end
                end
            end
            card.ability.extra.most_key = most_key
            card.ability.extra.least_key = least_key
        end
        if context.before and not context.blueprint and not card.ability.extra.first_done then
            local mk = card.ability.extra.most_key
            local lk = card.ability.extra.least_key
            if mk ~= '' and lk ~= '' and mk ~= lk and G.GAME.hands[mk] and G.GAME.hands[lk] then
                card.ability.extra.saved_level = G.GAME.hands[mk].level
                G.GAME.hands[mk].level = G.GAME.hands[lk].level
                card.ability.extra.first_done = true
            end
        end
        if context.after and not context.blueprint and card.ability.extra.first_done and card.ability.extra.saved_level > 0 then
            local mk = card.ability.extra.most_key
            if mk ~= '' and G.GAME.hands[mk] then
                G.GAME.hands[mk].level = card.ability.extra.saved_level
                card.ability.extra.saved_level = 0
            end
        end
    end
}

SMODS.Joker {
    key = 'photographer_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Photographer',
        text = {
            "The {C:attention}first hand{} played each blind",
            "is captured. Playing the same",
            "hand type again gives {C:mult}+#1#{} Mult",
            "{C:inactive}(Captured: #2#){}"
        }
    },
    config = { extra = { mult = 10, captured = '', first_done = false } },
    rarity = 1,
    pos = { x = 2, y = 6 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability.extra) or self.config.extra
        return { vars = { ex.mult or 10, ex.captured ~= '' and ex.captured or 'None' } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.captured = ''
            card.ability.extra.first_done = false
        end
        if context.joker_main then
            local hand_name = context.scoring_name or ''
            if not card.ability.extra.first_done and hand_name ~= '' then
                card.ability.extra.captured = hand_name
                card.ability.extra.first_done = true
                return { message = 'Captured!', colour = G.C.ATTENTION, card = card }
            elseif card.ability.extra.first_done and hand_name == card.ability.extra.captured and hand_name ~= '' then
                return { mult = card.ability.extra.mult, card = card }
            end
        end
    end
}

SMODS.Joker {
    key = 'countdown_joker',
    atlas = 'reality_warp_jokers',
    unlocked = false,
    loc_txt = {
        name = 'Countdown',
        text = {
            "Counter starts at {C:attention}10{}.",
            "Each card played reduces it by {C:attention}1{}.",
            "Hit exactly {C:attention}0{} → {X:mult,C:white}X#1#{} Mult.",
            "Exceed 0 → counter {C:attention}resets{}",
            "{C:inactive}(Current counter: {C:attention}#2#{C:inactive}){}"
        },
        unlock = {
            "Play exactly {C:attention}10 cards",
            "total in a single blind"
        }
    },
    config = { extra = { counter = 10, xmult = 3, cards_this_blind = 0, triggered = false } },
    rarity = 2,
    pos = { x = 3, y = 6 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        return { vars = { ex.xmult or 3, ex.counter or 10 } }
    end,
    check_for_unlock = function(self, args)
        if (args and args.type == 'countdown_cards') or (G.GAME and G.GAME.reality_warp_countdown_cards and G.GAME.reality_warp_countdown_cards >= 10) then
            return true
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.counter = 10
            card.ability.extra.cards_this_blind = 0
            card.ability.extra.triggered = false
            G.GAME.reality_warp_countdown_cards = 0
        end
        if context.before and not context.blueprint then
            local played = (context.full_hand and #context.full_hand) or
                           (G.play and G.play.cards and #G.play.cards) or 0
            card.ability.extra.cards_this_blind = (card.ability.extra.cards_this_blind or 0) + played
            G.GAME.reality_warp_countdown_cards = card.ability.extra.cards_this_blind
            card.ability.extra.counter = card.ability.extra.counter - played
            if card.ability.extra.counter < 0 then
                card.ability.extra.counter = 10
                card.ability.extra.triggered = false
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Reset!', colour = G.C.RED })
            elseif card.ability.extra.counter == 0 then
                card.ability.extra.triggered = true
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'ZERO! X3!', colour = G.C.MULT })
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            if card.ability.extra.triggered then
                card.ability.extra.triggered = false
                card.ability.extra.counter = 10
                return {
                    x_mult = 3,
                    card = card,
                    message = 'X3 Mult!'
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'smuggler_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Smuggler',
        text = {
            "At the start of each blind,",
            "a random card gets a",
            "{C:attention}random enhancement{} (Bonus or Mult)"
        }
    },
    config = { extra = { drawn_triggered = false } },
    rarity = 1,
    pos = { x = 4, y = 6 },
    cost = 4,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.drawn_triggered = false
        end
        if (context.first_hand_drawn or (context.setting_blind and not card.ability.extra.drawn_triggered)) and not context.blueprint then
            card.ability.extra.drawn_triggered = true
            local all_cards = {}
            if G.playing_cards then
                for _, c in ipairs(G.playing_cards) do all_cards[#all_cards + 1] = c end
            end
            if #all_cards > 0 then
                local target = pseudorandom_element(all_cards, pseudoseed('contrabandista'))
                local enhancements = { G.P_CENTERS.m_bonus, G.P_CENTERS.m_mult }
                local enh = pseudorandom_element(enhancements, pseudoseed('contrabandista_enh'))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        target:set_ability(enh)
                        target:juice_up(0.5, 0.5)
                        card:juice_up(0.3, 0.3)
                        card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Smuggled!', colour = G.C.GREEN })
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Joker {
    key = 'sheet_music_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Sheet Music',
        text = {
            "{C:attention}Straights{} give {C:chips}+#1#{} Chips.",
            "{C:attention}Straight Flushes{} also give {C:mult}+#2#{} Mult"
        }
    },
    config = { extra = { chips = 80, mult = 40 } },
    rarity = 1,
    pos = { x = 5, y = 6 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability.extra) or self.config.extra
        return { vars = { ex.chips or 80, ex.mult or 40 } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.poker_hands then
            local has_sf = (context.poker_hands['Straight Flush'] and next(context.poker_hands['Straight Flush'])) or
                           (context.poker_hands['Royal Flush'] and next(context.poker_hands['Royal Flush']))
            local has_st = context.poker_hands['Straight'] and next(context.poker_hands['Straight'])
            if has_sf then
                return { chips = card.ability.extra.chips or 80, mult = card.ability.extra.mult or 40, card = card }
            elseif has_st then
                return { chips = card.ability.extra.chips or 80, card = card }
            end
        end
    end
}

SMODS.Joker {
    key = 'blood_pact_joker',
    atlas = 'reality_warp_jokers',
    unlocked = false,
    loc_txt = {
        name = 'Blood Pact',
        text = {
            "At the start of each blind,",
            "pay {C:money}$#1#{} to give a random card",
            "a random {C:attention}Edition{} (Foil/Holo/Poly)"
        },
        unlock = {
            "Have {C:money}$50{} or more at once"
        }
    },
    config = { extra = { cost = 2, drawn_triggered = false } },
    rarity = 3,
    pos = { x = 6, y = 6 },
    cost = 8,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { (card and card.ability.extra.cost) or 2 } }
    end,
    check_for_unlock = function(self, args)
        local dollars = tonumber(G.GAME and G.GAME.dollars) or 0
        return dollars >= 50
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.drawn_triggered = false
        end
        if (context.first_hand_drawn or (context.setting_blind and not card.ability.extra.drawn_triggered)) and not context.blueprint then
            card.ability.extra.drawn_triggered = true
            local dollars = tonumber(G.GAME and G.GAME.dollars) or 0
            local cost = card.ability.extra.cost or 2
            if dollars >= cost then
                ease_dollars(-cost)
                local candidates = {}
                if G.playing_cards then
                    for _, c in ipairs(G.playing_cards) do candidates[#candidates + 1] = c end
                end
                if #candidates > 0 then
                    local target = pseudorandom_element(candidates, pseudoseed('pacto_sangre'))
                    local editions = { 'foil', 'holo', 'polychrome' }
                    local ed = pseudorandom_element(editions, pseudoseed('pacto_sangre_ed'))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            target:set_edition({ [ed] = true }, true, true)
                            target:juice_up(0.5, 0.5)
                            card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Pact!', colour = G.C.RED })
                            return true
                        end
                    }))
                end
            end
        end
    end
}

SMODS.Joker {
    key = 'saboteur_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Saboteur',
        text = {
            "Each round not won in {C:attention}1 hand{},",
            "lose {C:money}$2{} {C:inactive}(cumulative: -$#1#{}){}.",
            "Win in exactly {C:attention}1 hand{} →",
            "recover all debt {C:attention}X1.5{}"
        }
    },
    config = { extra = { debt = 0, hands_played = 0 } },
    rarity = 1,
    pos = { x = 0, y = 7 },
    cost = 5,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { (card and card.ability.extra.debt) or 0 } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.hands_played = 0
        end
        if context.before and not context.blueprint then
            card.ability.extra.hands_played = (card.ability.extra.hands_played or 0) + 1
        end
        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            if (card.ability.extra.hands_played or 0) == 1 then
                local refund = math.floor((card.ability.extra.debt or 0) * 1.5)
                if refund > 0 then
                    ease_dollars(refund)
                    card.ability.extra.debt = 0
                    return { message = '+$'..refund..' Refund!', colour = G.C.MONEY, card = card }
                end
            else
                ease_dollars(-2)
                card.ability.extra.debt = (card.ability.extra.debt or 0) + 2
                return { message = '-$2 Debt', colour = G.C.RED, card = card }
            end
        end
    end
}

SMODS.Joker {
    key = 'boomerang_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Boomerang',
        text = {
            "Cards from your {C:attention}first discard{}",
            "of each blind return to hand",
            "on your {C:attention}last hand{}"
        }
    },
    config = { extra = { boomerang_cards = {}, first_discard_done = false, returned = false } },
    rarity = 1,
    pos = { x = 1, y = 7 },
    cost = 5,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.boomerang_cards = {}
            card.ability.extra.first_discard_done = false
            card.ability.extra.returned = false
        end
        if context.discard and not context.blueprint and not card.ability.extra.first_discard_done then
            card.ability.extra.first_discard_done = true
            if context.full_hand then
                for _, c in ipairs(context.full_hand) do
                    card.ability.extra.boomerang_cards[#card.ability.extra.boomerang_cards + 1] = c
                end
            end
            return { message = 'Captured!', colour = G.C.ATTENTION, card = card }
        end
        if (context.before or context.discard) and not context.blueprint then
            local hands_left = (G.GAME and G.GAME.current_round and G.GAME.current_round.hands_left) or 99
            if hands_left <= 1 and not card.ability.extra.returned and #card.ability.extra.boomerang_cards > 0 then
                card.ability.extra.returned = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        for _, bc in ipairs(card.ability.extra.boomerang_cards) do
                            if bc and bc.area and bc.area ~= G.hand then
                                bc.area:remove_card(bc)
                                G.hand:emplace(bc)
                                bc:juice_up(0.5, 0.5)
                            end
                        end
                        card.ability.extra.boomerang_cards = {}
                        card:juice_up(0.3, 0.3)
                        card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Returned!', colour = G.C.BLUE })
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Joker {
    key = 'spy_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Spy',
        text = {
            "At the start of each blind,",
            "{C:attention}3 random cards{} from your deck",
            "are added directly to your hand"
        }
    },
    config = { extra = { count = 3, drawn_triggered = false } },
    rarity = 2,
    pos = { x = 2, y = 7 },
    cost = 6,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.drawn_triggered = false
        end
        if (context.first_hand_drawn or (context.setting_blind and not card.ability.extra.drawn_triggered)) and not context.blueprint then
            card.ability.extra.drawn_triggered = true
            local n = card.ability.extra.count or 3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    local drawn = 0
                    if G.deck and G.deck.cards and G.hand then
                        local deck_copy = {}
                        for _, c in ipairs(G.deck.cards) do deck_copy[#deck_copy+1] = c end
                        for i = #deck_copy, math.max(1, #deck_copy - n + 1), -1 do
                            local c = deck_copy[i]
                            if c and drawn < n then
                                G.deck:remove_card(c)
                                G.hand:emplace(c)
                                c:juice_up(0.3, 0.3)
                                drawn = drawn + 1
                            end
                        end
                    end
                    if drawn > 0 then
                        card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Scouted!', colour = G.C.ATTENTION })
                    end
                    return true
                end
            }))
        end
    end
}

SMODS.Joker {
    key = 'apprentice_joker',
    atlas = 'reality_warp_jokers',
    unlocked = false,
    loc_txt = {
        name = 'Apprentice',
        text = {
            "Counts activations of the",
            "{C:attention}adjacent Joker{} {C:inactive}(#1#/10){}.",
            "At {C:attention}10{}, becomes a copy",
            "of that Joker permanently"
        },
        unlock = {
            "Own {C:attention}4 Jokers{} at the same time"
        }
    },
    config = { extra = { count = 0, watching = '' } },
    rarity = 3,
    pos = { x = 3, y = 7 },
    cost = 8,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { (card and card.ability.extra.count) or 0 } }
    end,
    check_for_unlock = function(self, args)
        local n = G.jokers and G.jokers.cards and #G.jokers.cards or 0
        return n >= 4
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            local my_pos = nil
            if G.jokers and G.jokers.cards then
                for i, jk in ipairs(G.jokers.cards) do
                    if jk == card then my_pos = i; break end
                end
            end
            local adjacent = nil
            if my_pos then
                adjacent = G.jokers.cards[my_pos - 1] or G.jokers.cards[my_pos + 1]
            end
            if adjacent and adjacent ~= card then
                local adj_key = adjacent.config and adjacent.config.center and adjacent.config.center.key or ''
                if adj_key ~= card.ability.extra.watching then
                    card.ability.extra.watching = adj_key
                    card.ability.extra.count = 0
                end
                card.ability.extra.count = (card.ability.extra.count or 0) + 1
                if card.ability.extra.count >= 10 then
                    local target_center = adjacent.config and adjacent.config.center
                    if target_center then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                card:start_dissolve()
                                SMODS.add_card { key = target_center.key, key_append = 'apr' }
                                return true
                            end
                        }))
                        return { message = 'Mastered!', colour = G.C.GOLD, card = card }
                    end
                end
                return { message = (card.ability.extra.count)..'/10', colour = G.C.ATTENTION, card = card }
            end
        end
    end
}

SMODS.Joker {
    key = 'upgrade_roulette_joker',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Upgrade Roulette',
        text = {
            "Gives a random {C:attention}Enhancement{} to a random",
            "scoring card without one. Scoring cards with an",
            "Enhancement advance to a higher tier",
            "{C:inactive}(Bonus→Mult→Wild→Lucky→Steel→Gold→Glass){}"
        }
    },
    config = { extra = {} },
    rarity = 2,
    pos = { x = 4, y = 7 },
    cost = 6,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and context.scoring_hand then
            local chain = { 'm_bonus', 'm_mult', 'm_wild', 'm_lucky', 'm_steel', 'm_gold', 'm_glass' }
            local function get_next(c)
                local cur = c.config and c.config.center and c.config.center.key
                if not cur or cur == 'c_base' then return nil end
                if cur == 'm_stone' then return 'm_steel' end
                for i, k in ipairs(chain) do
                    if k == cur then return chain[math.min(#chain, i + 1)] end
                end
                return nil
            end

            local unenhanced = {}
            local upgraded = false

            for _, c in ipairs(context.scoring_hand) do
                local cur = c.config and c.config.center and c.config.center.key
                local is_enhanced = cur and cur ~= 'c_base'
                if is_enhanced then
                    local nxt = get_next(c)
                    if nxt and G.P_CENTERS[nxt] and not c.debuff then
                        c:set_ability(G.P_CENTERS[nxt])
                        c:juice_up(0.4, 0.4)
                        upgraded = true
                    end
                else
                    table.insert(unenhanced, c)
                end
            end

            if #unenhanced > 0 then
                local chosen_card = pseudorandom_element(unenhanced, pseudoseed('roulette_card'))
                local enh_pool = { 'm_bonus', 'm_mult', 'm_wild', 'm_lucky', 'm_steel', 'm_gold', 'm_glass', 'm_stone' }
                local chosen_enh = pseudorandom_element(enh_pool, pseudoseed('roulette_enh'))
                if chosen_card and G.P_CENTERS[chosen_enh] and not chosen_card.debuff then
                    chosen_card:set_ability(G.P_CENTERS[chosen_enh])
                    chosen_card:juice_up(0.4, 0.4)
                    upgraded = true
                end
            end

            if upgraded then
                return { message = 'Roulette!', colour = G.C.SECONDARY_SET.Enhanced, card = card }
            end
        end
    end
}

SMODS.Joker {
    key = 'reversed_hermit_joker',
    atlas = 'reality_warp_jokers',
    unlocked = false,
    loc_txt = {
        name = 'Reversed Hermit',
        text = {
            "At end of round, earn",
            "{C:money}$#1#{} for each remaining {C:attention}discard{}",
            "{C:inactive}(Currently {C:money}+$#2#{C:inactive}){}"
        },
        unlock = {
            "Win a blind without",
            "using any {C:attention}discards{}"
        }
    },
    config = { extra = { dollars_per_discard = 2 } },
    rarity = 1,
    pos = { x = 5, y = 7 },
    cost = 5,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        local d_left = (G.GAME and G.GAME.current_round and G.GAME.current_round.discards_left) or 0
        local rate = ex.dollars_per_discard or 2
        return { vars = { rate, d_left * rate } }
    end,
    check_for_unlock = function(self, args)
        if (args and args.type == 'no_discard_win') or (G.GAME and G.GAME.reality_warp_no_discard_win) then
            return true
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.reality_warp_no_discard_win = false
        end
        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            local discards_used = 0
            if G.GAME and G.GAME.current_round then
                local max_d = G.GAME.current_round.discards_used or 0
                discards_used = max_d
            end
            local discards_left = (G.GAME and G.GAME.current_round and G.GAME.current_round.discards_left) or 0
            if discards_used == 0 then
                G.GAME.reality_warp_no_discard_win = true
            end
            if discards_left > 0 then
                local rate = (card.ability and card.ability.extra and card.ability.extra.dollars_per_discard) or 2
                local dollars = discards_left * rate
                if dollars > 0 then
                    ease_dollars(dollars)
                    return { message = '+$'..dollars, colour = G.C.MONEY, card = card }
                end
            end
        end
    end
}

SMODS.Joker {
    key = 'script_joker',
    atlas = 'reality_warp_jokers',
    unlocked = false,
    loc_txt = {
        name = 'Script',
        text = {
            "A script of {C:attention}3 hand types{} is set",
            "each blind. Play them in order",
            "to earn {C:money}+$#1#{} at round end.",
            "{C:inactive}(#2# -> #3# -> #4#){}"
        },
        unlock = {
            "Play {C:attention}3 different hand types{}",
            "in a single blind"
        }
    },
    config = { extra = { reward = 12, script = {}, progress = 0, completed = false } },
    rarity = 1,
    pos = { x = 6, y = 7 },
    cost = 4,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability.extra) or self.config.extra
        local s = ex.script or {}
        return { vars = { ex.reward or 12, s[1] or '?', s[2] or '?', s[3] or '?' } }
    end,
    check_for_unlock = function(self, args)
        if (args and args.type == 'diff_hands') or (G.GAME and G.GAME.reality_warp_diff_hands and G.GAME.reality_warp_diff_hands >= 3) then
            return true
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.progress = 0
            card.ability.extra.completed = false
            G.GAME.reality_warp_diff_hands = 0
            G.GAME.reality_warp_hands_seen = {}
            local hand_list = {}
            if G.GAME and G.GAME.hands then
                for k, h in pairs(G.GAME.hands) do
                    if h.visible then
                        hand_list[#hand_list+1] = { key = k, played = h.played or 0 }
                    end
                end
            end
            table.sort(hand_list, function(a, b) return a.played > b.played end)
            local script = {}
            for i = 1, math.min(3, #hand_list) do script[i] = hand_list[i].key end
            for i = #script, 2, -1 do
                local j = math.floor(pseudorandom('libreto_shuf') * i) + 1
                script[i], script[j] = script[j], script[i]
            end
            card.ability.extra.script = script
        end
        if context.joker_main and not context.blueprint then
            local hand_name = context.scoring_name or ''
            if hand_name ~= '' then
                G.GAME.reality_warp_hands_seen = G.GAME.reality_warp_hands_seen or {}
                if not G.GAME.reality_warp_hands_seen[hand_name] then
                    G.GAME.reality_warp_hands_seen[hand_name] = true
                    G.GAME.reality_warp_diff_hands = (G.GAME.reality_warp_diff_hands or 0) + 1
                end
            end
            if not card.ability.extra.completed then
                local prog = card.ability.extra.progress or 0
                local script = card.ability.extra.script or {}
                if prog < 3 and script[prog + 1] == hand_name then
                    card.ability.extra.progress = prog + 1
                    if card.ability.extra.progress == 3 then
                        card.ability.extra.completed = true
                        return { message = 'Script Done!', colour = G.C.GOLD, card = card }
                    else
                        return { message = card.ability.extra.progress..'/3', colour = G.C.ATTENTION, card = card }
                    end
                elseif prog > 0 and (script[prog + 1] ~= hand_name) then
                    card.ability.extra.progress = 0
                end
            end
        end
        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            if card.ability.extra.completed then
                local reward = card.ability.extra.reward or 12
                ease_dollars(reward)
                card.ability.extra.completed = false
                return { message = '+$'..reward..'!', colour = G.C.MONEY, card = card }
            end
        end
    end
}

SMODS.Joker {
    key = 'incremental',
    atlas = 'reality_warp_jokers',
    loc_txt = {
        name = 'Incremental Joker',
        text = {
            "Gains {C:mult}+#1#{} Mult when scored cards follow",
            "an ascending rank sequence ({C:attention}A{} -> {C:attention}2{} ... -> {C:attention}K{}).",
            "Resets if sequence breaks.",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult, next: {C:attention}#3#{C:inactive}){}"
        }
    },
    config = { extra = { mult_gain = 3, mult = 0, next_rank = 14 } },
    rarity = 1,
    pos = { x = 2, y = 10 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local rank_names = { [2]='2', [3]='3', [4]='4', [5]='5', [6]='6', [7]='7', [8]='8', [9]='9', [10]='10', [11]='J', [12]='Q', [13]='K', [14]='A' }
        local nr = (card and card.ability and card.ability.extra and card.ability.extra.next_rank) or 14
        local cur_m = (card and card.ability and card.ability.extra and card.ability.extra.mult) or 0
        local mg = (card and card.ability and card.ability.extra and card.ability.extra.mult_gain) or 3
        return { vars = { mg, cur_m, rank_names[nr] or 'A' } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and not context.blueprint then
            local rank = context.other_card and context.other_card:get_id()
            if rank and rank >= 2 and rank <= 14 then
                local expected = card.ability.extra.next_rank or 14
                if rank == expected then
                    card.ability.extra.mult = (card.ability.extra.mult or 0) + (card.ability.extra.mult_gain or 3)
                    if expected == 14 then
                        card.ability.extra.next_rank = 2
                    elseif expected == 13 then
                        card.ability.extra.next_rank = 14
                    else
                        card.ability.extra.next_rank = expected + 1
                    end
                    return {
                        message = '+' .. tostring(card.ability.extra.mult_gain or 3) .. ' Mult',
                        colour = G.C.MULT,
                        card = card
                    }
                else
                    if (card.ability.extra.mult or 0) > 0 or (card.ability.extra.next_rank or 14) ~= 14 then
                        card.ability.extra.mult = 0
                        card.ability.extra.next_rank = 14
                        return {
                            message = 'Reset!',
                            colour = G.C.RED,
                            card = card
                        }
                    end
                end
            end
        end
        if context.joker_main and (card.ability.extra.mult or 0) > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
}

SMODS.Joker {
    key = 'vending_machine',
    atlas = 'reality_warp_jokers',
    pos = { x = 5, y = 11 },
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    config = { extra = { pay_cost = 3 } },
    loc_txt = {
        name = 'Vending Machine',
        text = {
            "Press {C:money}Pay{} {C:inactive}(#1#$){} to obtain",
            "a random {C:attention}Consumable{} directly",
            "into your inventory."
        }
    },
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        return { vars = { ex.pay_cost or 3 } }
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Joker {
    key = 'hourglass',
    atlas = 'reality_warp_jokers',
    pos = { x = 6, y = 11 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    loc_txt = {
        name = 'Hourglass of Eternity',
        text = {
            "Inverts with each played hand of the round:",
            "{C:attention}Hand 1{}: {C:chips}+100 Chips{} | {C:attention}Hand 2{}: {C:mult}+20 Mult{}",
            "{C:attention}Hand 3{}: {X:mult,C:white}X1.75{} Mult",
            "On {C:attention}final hand{}: {X:mult,C:white}X3.0{} Mult and {C:red}destroys itself{}"
        }
    },
    calculate = function(self, card, context)
        if context.joker_main then
            local hands_played_this_round = G.GAME.current_round.hands_played or 0
            local is_final = (G.GAME.current_round.hands_left == 0)

            if is_final then
                if not context.blueprint then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('glass' .. math.random(1, 6))
                            card:start_dissolve()
                            return true
                        end
                    }))
                end
                return {
                    Xmult = 3.0,
                    message = 'Final Sands! X3 Mult',
                    colour = G.C.RED,
                    card = card
                }
            elseif hands_played_this_round == 0 then
                return {
                    chips = 100,
                    message = '+100 Chips',
                    colour = G.C.CHIPS,
                    card = card
                }
            elseif hands_played_this_round == 1 then
                return {
                    mult = 20,
                    message = '+20 Mult',
                    colour = G.C.MULT,
                    card = card
                }
            else
                return {
                    Xmult = 1.75,
                    message = 'X1.75 Mult',
                    colour = G.C.PURPLE,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'shell_game',
    atlas = 'reality_warp_jokers',
    pos = { x = 2, y = 11 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    config = { extra = { mult = 12, target_prize = 'money', played_this_round = false } },
    loc_txt = {
        name = 'The Shell Game',
        text = {
            "{C:mult}+#1#{} Mult.",
            "Click {C:attention}Play{} once per round during hand selection to",
            "trigger the {C:attention}Amber Acorn Showdown{}: choose your prize",
            "({C:money}Cash{}, {C:purple}Tarot{}, {C:blue}+Hands{}, or {C:mult}+Mult{}), watch the Jokers",
            "flip face-down and shuffle, then find the {C:attention}Target Joker{}!",
            "{C:inactive}(Correct pick awards prize, Mult upgrades permanently){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        return { vars = { ex.mult or 12 } }
    end,
    calculate = function(self, card, context)
        local ex = card.ability.extra
        if context.joker_main then
            return {
                mult = ex.mult,
                card = card
            }
        end
        if (context.setting_blind or context.end_of_round or context.skip_blind) and not context.blueprint then
            ex.played_this_round = false
        end
    end
}

if G and G.UIDEF and G.UIDEF.use_and_sell_buttons then
    local orig_common_use_and_sell = G.UIDEF.use_and_sell_buttons
    G.UIDEF.use_and_sell_buttons = function(card)
        local base_background = orig_common_use_and_sell(card)
        if not card or card.area ~= G.jokers or G.STATE == G.STATES.TUTORIAL then
            return base_background
        end
        if not base_background or not base_background.nodes or not base_background.nodes[1] or not base_background.nodes[1].nodes then
            return base_background
        end

        if card_has_key(card, 'vending_machine') then
            local cost = (card.ability and card.ability.extra and card.ability.extra.pay_cost) or 3
            local cur_dollars = (to_number and to_number(G.GAME and G.GAME.dollars)) or tonumber(G.GAME and G.GAME.dollars) or 0
            local has_space = G.consumeables and (#G.consumeables.cards + (G.GAME.consumeable_buffer or 0) < G.consumeables.config.card_limit)
            local can_pay = cur_dollars >= cost and has_space and not card.debuff and not (G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.DRAW_TO_HAND or G.STATE == G.STATES.PLAY_TAROT)

            local pay_btn_node = {
                n = G.UIT.R,
                config = { align = "cl" },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cr" },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {
                                    ref_table = card,
                                    align = "cr",
                                    padding = 0.1,
                                    r = 0.08,
                                    minw = 1.25,
                                    hover = can_pay,
                                    shadow = true,
                                    colour = can_pay and G.C.GOLD or G.C.UI.BACKGROUND_INACTIVE,
                                    one_press = false,
                                    button = can_pay and 'pay_vending_machine' or nil,
                                    func = 'can_pay_vending_machine'
                                },
                                nodes = {
                                    { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                                    {
                                        n = G.UIT.C,
                                        config = { align = "tm" },
                                        nodes = {
                                            {
                                                n = G.UIT.R,
                                                config = { align = "cm", maxw = 1.25 },
                                                nodes = {
                                                    { n = G.UIT.T, config = { text = "PAY ($" .. cost .. ")", colour = G.C.WHITE, scale = 0.35, shadow = true } }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            table.insert(base_background.nodes[1].nodes, pay_btn_node)
        end

        return base_background
    end
end

if G and G.FUNCS then
    G.FUNCS.can_pay_vending_machine = function(e)
        local card = e.config.ref_table
        local cost = (card and card.ability and card.ability.extra and card.ability.extra.pay_cost) or 3
        local cur_dollars = (to_number and to_number(G.GAME and G.GAME.dollars)) or tonumber(G.GAME and G.GAME.dollars) or 0
        local has_space = G.consumeables and (#G.consumeables.cards + (G.GAME.consumeable_buffer or 0) < G.consumeables.config.card_limit)
        if cur_dollars >= cost and has_space and not (card and card.debuff) and not (G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.DRAW_TO_HAND or G.STATE == G.STATES.PLAY_TAROT) then
            e.config.colour = G.C.GOLD
            e.config.button = 'pay_vending_machine'
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    end

    G.FUNCS.pay_vending_machine = function(e)
        local card = e.config.ref_table
        local cost = (card and card.ability and card.ability.extra and card.ability.extra.pay_cost) or 3
        local cur_dollars = (to_number and to_number(G.GAME and G.GAME.dollars)) or tonumber(G.GAME and G.GAME.dollars) or 0
        local has_space = G.consumeables and (#G.consumeables.cards + (G.GAME.consumeable_buffer or 0) < G.consumeables.config.card_limit)
        if cur_dollars >= cost and has_space then
            ease_dollars(-cost)
            play_sound('coin3')
            if card and card.juice_up then card:juice_up(0.6, 0.6) end
            G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.25,
                func = function()
                    local sets = { 'Tarot', 'Planet', 'Spectral' }
                    local chosen_set = pseudorandom_element(sets, pseudoseed('vending_pay_set'))
                    local new_card = SMODS.add_card {
                        set = chosen_set,
                        area = G.consumeables,
                        key_append = 'vending_pay'
                    }
                    G.GAME.consumeable_buffer = math.max(0, (G.GAME.consumeable_buffer or 1) - 1)
                    if new_card and new_card.juice_up then
                        new_card:juice_up(0.6, 0.6)
                    end
                    play_sound('tarot1')
                    card_eval_status_text(card or new_card, 'extra', nil, nil, nil, { message = '+' .. chosen_set, colour = G.C.GOLD })
                    return true
                end
            }))
        end
    end
end

