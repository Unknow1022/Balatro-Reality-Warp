SMODS.Atlas {
    key = "reality_warp_stickers",
    path = "stickers.png",
    px = 71,
    py = 95
}

SMODS.Sticker {
    key = "possessed_needle",
    atlas = "reality_warp_stickers",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('e5b80b'),
    prefix_config = { key = false },
    order = 11,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Needle)",
        text = {
            "Inverted Boss Blessing.",
            "Only 1 hand allowed per round,",
            "but that hand scores {X:mult,C:white}X10{} Mult"
        }
    },
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                x_mult = 10,
                message = 'X10 Mult [Needle]',
                colour = G.C.PURPLE
            }
        end
        if context.after and not context.blueprint then
            G.GAME.current_round.hands_left = 0
        end
    end
}

SMODS.Sticker {
    key = "possessed_flint",
    atlas = "reality_warp_stickers",
    pos = { x = 1, y = 0 },
    badge_colour = HEX('e56a2f'),
    prefix_config = { key = false },
    order = 12,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Flint)",
        text = {
            "Inverted Boss Blessing.",
            "Base Chips and Mult are halved,",
            "but each scoring card gives {X:mult,C:white}X2{} Mult"
        }
    },
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            mult = math.max(1, math.floor(mult / 2))
            hand_chips = math.max(1, math.floor(hand_chips / 2))
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
        end
        if context.individual and context.cardarea == G.play then
            return {
                x_mult = 2,
                colour = G.C.ORANGE
            }
        end
    end
}

SMODS.Sticker {
    key = "possessed_pillar",
    atlas = "reality_warp_stickers",
    pos = { x = 2, y = 0 },
    badge_colour = HEX('7e6752'),
    prefix_config = { key = false },
    order = 13,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Pillar)",
        text = {
            "Inverted Boss Blessing.",
            "Cards played previously this Ante",
            "score {C:chips}+150{} Chips and {C:mult}+20{} Mult"
        }
    },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card and context.other_card.ability and context.other_card.ability.played_this_ante then
                return {
                    chips = 150,
                    mult = 20,
                    colour = G.C.PURPLE
                }
            end
        end
    end
}

SMODS.Sticker {
    key = "possessed_hook",
    atlas = "reality_warp_stickers",
    pos = { x = 3, y = 0 },
    badge_colour = HEX('a84024'),
    prefix_config = { key = false },
    order = 14,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Hook)",
        text = {
            "Inverted Boss Blessing.",
            "Discards 2 random cards on play;",
            "each discarded card adds {X:mult,C:white}+X0.75{} Mult"
        }
    },
    calculate = function(self, card, context)
        if context.before and not context.blueprint and G.hand and G.hand.cards and #G.hand.cards > 0 then
            local count = 0
            for i = 1, math.min(2, #G.hand.cards) do
                local target = pseudorandom_element(G.hand.cards, pseudoseed('hook_disc'))
                if target then
                    draw_card(G.hand, G.discard, 90, 'down', nil, target)
                    count = count + 1
                end
            end
            card.ability.hook_bonus = 1 + (count * 0.75)
        end
        if context.joker_main then
            local bonus = card.ability.hook_bonus or 1.75
            return {
                x_mult = bonus,
                message = 'X' .. tostring(bonus) .. ' Mult [Hook]',
                colour = G.C.RED
            }
        end
        if context.after and not context.blueprint then
            card.ability.hook_bonus = nil
        end
    end
}

SMODS.Sticker {
    key = "possessed_psychic",
    atlas = "reality_warp_stickers",
    pos = { x = 4, y = 0 },
    badge_colour = HEX('efc03c'),
    prefix_config = { key = false },
    order = 15,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Psychic)",
        text = {
            "Inverted Boss Blessing.",
            "Must play 5 cards;",
            "5-card hands trigger {X:mult,C:white}X3{} Mult"
        }
    },
    calculate = function(self, card, context)
        if context.joker_main and context.full_hand and #context.full_hand >= 5 then
            return {
                x_mult = 3,
                message = 'X3 Mult [Psychic]',
                colour = G.C.GOLD
            }
        end
    end
}

SMODS.Sticker {
    key = "possessed_arm",
    atlas = "reality_warp_stickers",
    pos = { x = 0, y = 1 },
    badge_colour = HEX('6865f3'),
    prefix_config = { key = false },
    order = 16,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Arm)",
        text = {
            "Inverted Boss Blessing.",
            "Decreases level of played poker hand,",
            "but triggers {X:mult,C:white}X4{} Mult"
        }
    },
    calculate = function(self, card, context)
        if context.before and not context.blueprint and context.scoring_name then
            level_up_hand(card, context.scoring_name, nil, -1)
        end
        if context.joker_main then
            return {
                x_mult = 4,
                message = 'X4 Mult [Arm]',
                colour = G.C.PURPLE
            }
        end
    end
}

SMODS.Sticker {
    key = "possessed_eye",
    atlas = "reality_warp_stickers",
    pos = { x = 1, y = 1 },
    badge_colour = HEX('4b71e4'),
    prefix_config = { key = false },
    order = 17,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Eye)",
        text = {
            "Inverted Boss Blessing.",
            "Only 1 hand type allowed this round,",
            "which scores {X:mult,C:white}X3.5{} Mult"
        }
    },
    calculate = function(self, card, context)
        if context.joker_main then
            if not G.GAME.current_round.first_hand_type then
                G.GAME.current_round.first_hand_type = context.scoring_name
            end
            if G.GAME.current_round.first_hand_type == context.scoring_name then
                return {
                    x_mult = 3.5,
                    message = 'X3.5 Mult [Eye]',
                    colour = G.C.BLUE
                }
            end
        end
    end
}

SMODS.Sticker {
    key = "possessed_wall",
    atlas = "reality_warp_stickers",
    pos = { x = 2, y = 1 },
    badge_colour = HEX('8a59a5'),
    prefix_config = { key = false },
    order = 18,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Wall)",
        text = {
            "Inverted Boss Blessing.",
            "Blind target is doubled,",
            "but defeating it awards {C:money}+$25{}"
        }
    },
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and G.GAME and G.GAME.blind and not card.ability.wall_blind_doubled then
            card.ability.wall_blind_doubled = true
            G.GAME.blind.chips = G.GAME.blind.chips * 2
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
        if context.end_of_round and not context.repetition and not context.individual then
            card.ability.wall_blind_doubled = nil
            ease_dollars(25)
            return {
                message = '+$25 [Wall]',
                colour = G.C.MONEY
            }
        end
    end
}

SMODS.Sticker {
    key = "possessed_serpent",
    atlas = "reality_warp_stickers",
    pos = { x = 3, y = 1 },
    badge_colour = HEX('439a4f'),
    prefix_config = { key = false },
    order = 19,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Serpent)",
        text = {
            "Inverted Boss Blessing.",
            "Always draws 3 cards after play or discard;",
            "scoring cards give {C:chips}+30{} Chips"
        }
    },
    calculate = function(self, card, context)
        if (context.after or context.discard) and not context.blueprint then
            if G.FUNCS and G.FUNCS.draw_from_deck_to_hand then
                G.FUNCS.draw_from_deck_to_hand(3)
            end
        end
        if context.individual and context.cardarea == G.play then
            return {
                chips = 30,
                colour = G.C.CHIPS
            }
        end
    end
}

SMODS.Sticker {
    key = "possessed_water",
    atlas = "reality_warp_stickers",
    pos = { x = 4, y = 1 },
    badge_colour = HEX('579ec2'),
    prefix_config = { key = false },
    order = 20,
    should_apply = false,
    loc_txt = {
        name = "Possessed (Water)",
        text = {
            "Inverted Boss Blessing.",
            "Start with 0 discards,",
            "but hands played draw +4 cards immediately"
        }
    },
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            ease_discard(-G.GAME.current_round.discards_left)
        end
        if context.before and not context.blueprint then
            if G.FUNCS and G.FUNCS.draw_from_deck_to_hand then
                G.FUNCS.draw_from_deck_to_hand(4)
            end
        end
    end
}

local POSSESSED_STICKER_KEYS = {
    ['needle'] = 'possessed_needle',
    ['flint'] = 'possessed_flint',
    ['pillar'] = 'possessed_pillar',
    ['hook'] = 'possessed_hook',
    ['psychic'] = 'possessed_psychic',
    ['arm'] = 'possessed_arm',
    ['eye'] = 'possessed_eye',
    ['wall'] = 'possessed_wall',
    ['serpent'] = 'possessed_serpent',
    ['water'] = 'possessed_water'
}

local ALL_POSSESSED_KEYS = {
    'possessed_needle',
    'possessed_flint',
    'possessed_pillar',
    'possessed_hook',
    'possessed_psychic',
    'possessed_arm',
    'possessed_eye',
    'possessed_wall',
    'possessed_serpent',
    'possessed_water'
}

function possess_joker(card, boss_key)
    if not card or not card.ability then return end

    local matched_sticker = nil
    if boss_key then
        local lk = string.lower(boss_key)
        for name_frag, sticker_name in pairs(POSSESSED_STICKER_KEYS) do
            if string.find(lk, name_frag) then
                matched_sticker = sticker_name
                break
            end
        end
    end

    matched_sticker = matched_sticker or pseudorandom_element(ALL_POSSESSED_KEYS, pseudoseed('botg_possess_pick'))

    for _, k in ipairs(ALL_POSSESSED_KEYS) do
        if card.ability[k] and SMODS.Stickers[k] then
            SMODS.Stickers[k]:apply(card, false)
        end
    end

    if SMODS.Stickers[matched_sticker] then
        SMODS.Stickers[matched_sticker]:apply(card, true)
        card.ability.possessed = true
        card.ability.active_possessed_key = matched_sticker
    end

    local st_name = (SMODS.Stickers[matched_sticker] and SMODS.Stickers[matched_sticker].loc_txt and SMODS.Stickers[matched_sticker].loc_txt.name) or "Boss Possessed"
    card_eval_status_text(card, 'extra', nil, nil, nil, {
        message = st_name .. '!',
        colour = G.C.PURPLE
    })
    play_sound('whoosh1', 0.8, 0.7)
    card:juice_up(0.4, 0.4)
end
