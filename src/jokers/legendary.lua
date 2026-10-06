
SMODS.Atlas {
    key = "reality_warp_legendary",
    path = "legendary_jokers.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'world_devourer',
    atlas = 'reality_warp_legendary',
    unlocked = false,
    unlock = { "Defeat {C:attention}10 Boss Blinds{}", "in a single run" },
    loc_txt = {
        name = 'World Devourer',
        text = {
            "Gains {X:mult,C:white}X1{} Mult",
            "for each {C:attention}blind{} defeated",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}"
        }
    },
    config = { extra = {
        xmult_per_blind = 1,
        blinds_defeated = 0,
        xmult = 1
    }},
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    no_particles = true,
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability.extra) or self.config.extra
        return { vars = { ex.xmult or 1 } }
    end,
    check_for_unlock = function(self, args)
        if (args and args.type == 'world_devourer') or (G.GAME and ((G.GAME.reality_warp_bosses_slain or 0) >= 10 or (G.GAME.round_resets and (G.GAME.round_resets.boss_defeats or 0) >= 10))) then
            return true
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local ex = card.ability.extra
            if (ex.xmult or 1) > 1 then
                return {
                    Xmult = ex.xmult,
                    card = card
                }
            end
        end

        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            local ex = card.ability.extra
            ex.blinds_defeated = (ex.blinds_defeated or 0) + 1
            ex.xmult = 1 + ex.blinds_defeated * (ex.xmult_per_blind or 1)
            return {
                message = 'X'..string.format('%.0f', ex.xmult)..'!',
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

local function get_next_paradox_joker()
    local pool = {}
    if G.P_CENTER_POOLS and G.P_CENTER_POOLS.Joker then
        for _, j in ipairs(G.P_CENTER_POOLS.Joker) do
            if j.key and j.key ~= 'j_reality_warp_living_paradox' then
                table.insert(pool, j.key)
            end
        end
    end
    if #pool > 0 then
        return pseudorandom_element(pool, pseudoseed('paradox_joker_next'))
    end
    return nil
end

SMODS.Joker {
    key = 'living_paradox',
    atlas = 'reality_warp_legendary',
    unlocked = false,
    unlock = { "Defeat a {C:attention}Boss Blind{}", "to discover this Joker" },
    loc_txt = {
        name = 'Living Paradox',
        text = {
            "Creates a {C:dark_edition}Negative{} {C:attention}#1#{}",
            "when {C:attention}Boss Blind{} is defeated",
            "{C:inactive}(Changes after each Boss Blind){}"
        }
    },
    config = { extra = { next_joker = nil } },
    rarity = 4,
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    no_particles = true,
    cost = 20,
    blueprint_compat = false,
    check_for_unlock = function(self, args)
        if (args and (args.type == 'defeat_blind' and G.GAME.blind and G.GAME.blind.boss)) or (G.GAME and G.GAME.reality_warp_boss_defeated) then
            return true
        end
    end,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability.extra) or self.config.extra
        if not ex.next_joker then
            ex.next_joker = get_next_paradox_joker()
        end
        local next_name = "Random"
        if ex.next_joker and G.P_CENTERS and G.P_CENTERS[ex.next_joker] then
            local center = G.P_CENTERS[ex.next_joker]
            next_name = (localize and localize{type = 'name_text', key = center.key, set = 'Joker'}) or center.name or ex.next_joker
        end
        return { vars = { next_name } }
    end,
    calculate = function(self, card, context)
        if not card.ability.extra.next_joker then
            card.ability.extra.next_joker = get_next_paradox_joker()
        end

        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            if G.GAME and G.GAME.blind and G.GAME.blind.boss then
                G.GAME.reality_warp_boss_defeated = true
                local chosen_key = card.ability.extra.next_joker or get_next_paradox_joker()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_j = SMODS.add_card { key = chosen_key, edition = 'e_negative', key_append = 'living_paradox' }
                        card:juice_up(0.5, 0.5)
                        return true
                    end
                }))
                card.ability.extra.next_joker = get_next_paradox_joker()
                return {
                    message = 'Paradox!',
                    colour = G.C.DARK_EDITION,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'star_chronicler',
    atlas = 'reality_warp_legendary',
    unlocked = false,
    unlock = { "Win a complete run", "{C:attention}(Defeat Ante 8+){}" },
    loc_txt = {
        name = 'Star Chronicler',
        text = {
            "Gains {X:mult,C:white}X#1#{} Mult for each",
            "{C:blue}Planet{} card discovered.",
            "{C:spectral}Black Holes{} double its current Mult",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
        }
    },
    config = { extra = {
        xmult_per_planet = 0.5,
        black_hole_mult = 1
    }},
    rarity = 4,
    pos = { x = 0, y = 2 },
    soul_pos = { x = 1, y = 2 },
    no_particles = true,
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability.extra) or self.config.extra
        local planet_count = 0
        if G.P_CENTER_POOLS and G.P_CENTER_POOLS.Planet then
            for _, p in ipairs(G.P_CENTER_POOLS.Planet) do
                if p.discovered then
                    planet_count = planet_count + 1
                end
            end
        end
        local base_xm = 1 + planet_count * (ex.xmult_per_planet or 0.5)
        local total_xm = base_xm * (ex.black_hole_mult or 1)
        return { vars = { ex.xmult_per_planet or 0.5, string.format('%.1f', total_xm) } }
    end,
    check_for_unlock = function(self, args)
        if (args and (args.type == 'win_game' or args.type == 'win_custom')) or (G.GAME and (G.GAME.reality_warp_run_won or G.GAME.won)) then
            return true
        end
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            local c = context.consumeable
            if c and (c.key == 'c_black_hole' or (c.ability and c.ability.name == 'Black Hole')) then
                card.ability.extra.black_hole_mult = (card.ability.extra.black_hole_mult or 1) * 2
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'X2 Mult!', colour = G.C.MULT })
            end
        end

        if context.joker_main then
            local ex = card.ability.extra
            local planet_count = 0
            if G.P_CENTER_POOLS and G.P_CENTER_POOLS.Planet then
                for _, p in ipairs(G.P_CENTER_POOLS.Planet) do
                    if p.discovered then
                        planet_count = planet_count + 1
                    end
                end
            end
            local base_xm = 1 + planet_count * (ex.xmult_per_planet or 0.5)
            local total_xm = base_xm * (ex.black_hole_mult or 1)
            if total_xm > 1 then
                return {
                    Xmult = total_xm,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'creepy_shadow',
    atlas = 'reality_warp_legendary',
    unlocked = true,
    discovered = true,
    loc_txt = {
        name = 'Creepy Shadow',
        text = {
            "At end of round, destroys a random {C:attention}Joker{}",
            "in possession (including {C:attention}Eternal{})",
            "and gains {X:mult,C:white}X#1#{} Mult per destroyed Joker.",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
        }
    },
    config = { extra = { x_mult_gain = 2, x_mult = 1 } },
    rarity = 4,
    pos = { x = 0, y = 3 },
    soul_pos = { x = 1, y = 3 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        return { vars = { ex.x_mult_gain or 2, ex.x_mult or 1 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and (card.ability.extra.x_mult or 1) > 1 then
            return {
                Xmult = card.ability.extra.x_mult,
                card = card
            }
        end
        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            local targets = {}
            if G.jokers and G.jokers.cards then
                for _, j in ipairs(G.jokers.cards) do
                    if j ~= card and not j.getting_sliced then
                        targets[#targets + 1] = j
                    end
                end
            end
            if #targets > 0 then
                local chosen = pseudorandom_element(targets, pseudoseed('creepy_shadow'))
                chosen.getting_sliced = true
                card.ability.extra.x_mult = (card.ability.extra.x_mult or 1) + (card.ability.extra.x_mult_gain or 2)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.8, 0.8)
                        chosen:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = 'Consumed! X' .. tostring(card.ability.extra.x_mult),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'ouroboros',
    atlas = 'reality_warp_legendary',
    unlocked = true,
    discovered = true,
    loc_txt = {
        name = 'Ouroboros',
        text = {
            "Each played card retriggers {C:attention}#1#{} times.",
            "Gains {X:mult,C:white}+X#2#{} Mult for every {C:attention}#1#{} retriggers",
            "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult){}"
        }
    },
    config = { extra = { retriggers = 3, x_mult = 1.0, x_mult_gain = 0.5 } },
    rarity = 4,
    pos = { x = 0, y = 4 },
    soul_pos = { x = 1, y = 4 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        return { vars = { ex.retriggers or 3, ex.x_mult_gain or 0.5, string.format('%.1f', ex.x_mult or 1.0) } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if not context.blueprint then
                card.ability.extra.x_mult = (card.ability.extra.x_mult or 1.0) + (card.ability.extra.x_mult_gain or 0.5)
            end
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.retriggers or 3,
                card = card
            }
        end

        if context.joker_main and (card.ability.extra.x_mult or 1.0) > 1.0 then
            return {
                Xmult = card.ability.extra.x_mult,
                card = card
            }
        end
    end
}

SMODS.Joker {
    key = 'chrono_weaver',
    atlas = 'reality_warp_legendary',
    unlocked = true,
    discovered = true,
    loc_txt = {
        name = 'Chrono Weaver',
        text = {
            "{C:green}#1# in #2#{} chance to disable {C:attention}Boss Blind{},",
            "{C:green}#1# in #3#{} chance to add {C:chips}+#4#{} Chips,",
            "{C:green}#1# in #5#{} chance to add {C:mult}+#6#{} Mult,",
            "{C:green}#1# in #7#{} chance to add {C:chips}+75%{} of Blind chip requirement"
        }
    },
    config = { extra = {
        boss_odds = 2,
        chip_odds = 3,
        chips = 15000,
        mult_odds = 5,
        mult = 20000,
        req_odds = 10,
        req_percent = 0.75
    }},
    rarity = 4,
    pos = { x = 0, y = 5 },
    soul_pos = { x = 1, y = 5 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        local num, den_boss = SMODS.get_probability_vars(card, 1, ex.boss_odds or 2, 'chrono_boss')
        local _, den_chips = SMODS.get_probability_vars(card, 1, ex.chip_odds or 3, 'chrono_chips')
        local _, den_mult = SMODS.get_probability_vars(card, 1, ex.mult_odds or 5, 'chrono_mult')
        local _, den_req = SMODS.get_probability_vars(card, 1, ex.req_odds or 10, 'chrono_req')
        return { vars = {
            num,
            den_boss,
            den_chips,
            ex.chips or 15000,
            den_mult,
            ex.mult or 20000,
            den_req
        } }
    end,
    calculate = function(self, card, context)
        if (context.setting_blind or context.first_hand_drawn) and not context.blueprint then
            if G.GAME and G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                if SMODS.pseudorandom_probability(card, 'chrono_boss', 1, card.ability.extra.boss_odds or 2) then
                    G.GAME.blind:disable()
                    play_sound('timpani')
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('ph_boss_disabled'),
                        colour = G.C.GREEN
                    })
                end
            end
        end

        if context.joker_main then
            local ex = card.ability.extra
            local total_chips = 0
            local total_mult = 0

            if SMODS.pseudorandom_probability(card, 'chrono_chips', 1, ex.chip_odds or 3) then
                total_chips = total_chips + (ex.chips or 15000)
            end

            if SMODS.pseudorandom_probability(card, 'chrono_mult', 1, ex.mult_odds or 5) then
                total_mult = total_mult + (ex.mult or 20000)
            end

            if SMODS.pseudorandom_probability(card, 'chrono_req', 1, ex.req_odds or 10) then
                local blind_req = (G.GAME.blind and G.GAME.blind.chips) or 0
                total_chips = total_chips + math.floor(blind_req * (ex.req_percent or 0.75))
            end

            if total_chips > 0 or total_mult > 0 then
                local ret = { card = card }
                if total_chips > 0 then ret.chips = total_chips end
                if total_mult > 0 then ret.mult = total_mult end
                return ret
            end
        end
    end
}

SMODS.Joker {
    key = 'philosopher',
    atlas = 'reality_warp_legendary',
    unlocked = true,
    discovered = true,
    loc_txt = {
        name = 'Philosopher',
        text = {
            "Gains {X:mult,C:white}+X#2#{} Mult whenever a",
            "{C:tarot}Tarot{}, {C:spectral}Spectral{}, or {C:planet}Planet{} card is used",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}"
        }
    },
    config = { extra = { x_mult = 1.0, x_mult_gain = 0.5 } },
    rarity = 4,
    pos = { x = 0, y = 6 },
    soul_pos = { x = 1, y = 6 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        return { vars = { string.format('%.1f', ex.x_mult or 1.0), ex.x_mult_gain or 0.5 } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            local c = context.consumeable
            local c_set = (c and c.ability and c.ability.set) or (c and c.config and c.config.center and c.config.center.set)
            if c_set == 'Tarot' or c_set == 'Spectral' or c_set == 'Planet' then
                card.ability.extra.x_mult = (card.ability.extra.x_mult or 1.0) + (card.ability.extra.x_mult_gain or 0.5)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = 'X' .. string.format('%.1f', card.ability.extra.x_mult) .. ' Mult!',
                    colour = G.C.MULT
                })
            end
        end

        if context.joker_main and (card.ability.extra.x_mult or 1.0) > 1.0 then
            return {
                Xmult = card.ability.extra.x_mult,
                card = card
            }
        end
    end
}

SMODS.Joker {
    key = 'void_monarch',
    atlas = 'reality_warp_legendary',
    unlocked = true,
    discovered = true,
    loc_txt = {
        name = 'Void Monarch',
        text = {
            "Gains {X:mult,C:white}+X#2#{} Mult whenever a {C:purple}Potion{} is used.",
            "Defeating a {C:attention}Boss Blind{} multiplies",
            "current Mult by {X:mult,C:white}X#3#{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}"
        }
    },
    config = { extra = { x_mult = 1.0, x_mult_potion_gain = 1.0, boss_mult = 1.5 } },
    rarity = 4,
    pos = { x = 0, y = 7 },
    soul_pos = { x = 1, y = 7 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        return { vars = { string.format('%.2f', ex.x_mult or 1.0), ex.x_mult_potion_gain or 1.0, ex.boss_mult or 1.5 } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            local c = context.consumeable
            local is_potion = (c and c.ability and c.ability.set == 'Potion')
                or (c and c.config and c.config.center and c.config.center.set == 'Potion')
            if is_potion then
                card.ability.extra.x_mult = (card.ability.extra.x_mult or 1.0) + (card.ability.extra.x_mult_potion_gain or 1.0)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = 'X' .. string.format('%.1f', card.ability.extra.x_mult) .. ' Mult!',
                    colour = G.C.MULT
                })
            end
        end

        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            if G.GAME and G.GAME.blind and G.GAME.blind.boss then
                card.ability.extra.x_mult = (card.ability.extra.x_mult or 1.0) * (card.ability.extra.boss_mult or 1.5)
                return {
                    message = 'X' .. string.format('%.2f', card.ability.extra.x_mult) .. '!',
                    colour = G.C.DARK_EDITION,
                    card = card
                }
            end
        end

        if context.joker_main and (card.ability.extra.x_mult or 1.0) > 1.0 then
            return {
                Xmult = card.ability.extra.x_mult,
                card = card
            }
        end
    end
}

if SMODS and SMODS.Sound then
    SMODS.Sound {
        key = 'dragster',
        path = 'dragster.ogg'
    }
end

local function play_dragster_sound()
    if G.AUDIO and G.AUDIO['reality_warp_dragster'] then
        play_sound('reality_warp_dragster')
    elseif G.AUDIO and G.AUDIO['dragster'] then
        play_sound('dragster')
    else
        pcall(play_sound, 'reality_warp_dragster')
    end
end

SMODS.Joker {
    key = 'top_fuel_dragster',
    atlas = 'reality_warp_legendary',
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 8 },
    soul_pos = {
        x = 1,
        y = 8,
        draw = function(card, scale_mod, rotate_mod)
            local ex = card.ability and card.ability.extra
            local in_collection = (card.area and (card.area.config and card.area.config.collection or card.area == G.your_collection))
                               or (card.params and (card.params.bypass_discovery_center or card.params.bypass_discovery_ui))
                               or (card.area and card.area ~= G.jokers)
                               or not (G.jokers and card.area == G.jokers)
            if (ex and ex.show_fire) or in_collection then
                if not card.children.floating_sprite then
                    local atlas = (card.atlas and G.ASSET_ATLAS and G.ASSET_ATLAS[card.atlas])
                               or (card.config and card.config.center and card.config.center.atlas and G.ASSET_ATLAS and G.ASSET_ATLAS[card.config.center.atlas])
                               or (G.ASSET_ATLAS and (G.ASSET_ATLAS['reality_warp_reality_warp_legendary'] or G.ASSET_ATLAS['reality_warp_legendary']))
                    if atlas then
                        card.children.floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, atlas, { x = 1, y = 8 })
                        card.children.floating_sprite.role.draw_major = card
                        card.children.floating_sprite.states.hover.can = false
                        card.children.floating_sprite.states.click.can = false
                    end
                end
                if card.children.floating_sprite then
                    card._flames_drawn_this_frame = G.TIMERS.REAL
                    scale_mod = scale_mod or (0.05 + 0.03 * math.sin(4.5 * G.TIMERS.REAL))
                    rotate_mod = rotate_mod or (0.02 * math.sin(2.5 * G.TIMERS.REAL))
                    card.hover_tilt = (card.hover_tilt or 1) * 1.2
                    card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
                    card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
                    card.hover_tilt = (card.hover_tilt or 1.2) / 1.2
                end
            end
        end
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = {
        countdown = 20,
        timer = 20,
        x_mult_perfect = 10,
        x_mult_normal = 5,
        active = false,
        perfect_launch = nil,
        show_fire = false,
        show_smoke = false,
        last_alert_sec = nil
    }},
    loc_txt = {
        name = 'Top Fuel Dragster',
        text = {
            "{C:attention}#1#s{} countdown begins each round.",
            "Play hand within {C:attention}0.1s{} of reaching {C:attention}0s{}",
            "for a {C:green}Perfect Launch{} of {X:mult,C:white}X#2#{} Mult.",
            "Gives {X:mult,C:white}X#3#{} Mult if mistimed.",
            "{C:inactive}(Status: #4#){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        local ex = (card and card.ability and card.ability.extra) or self.config.extra
        local t = ex.timer or 20
        local status_str = "Ready (20.0s)"
        if ex.active then
            if t > 0.05 then
                status_str = string.format("Staging: %.1fs", math.max(0, t))
            elseif t >= -0.10 then
                status_str = "LAUNCH! (0.0s)"
            else
                status_str = string.format("Late (+%.1fs)", math.abs(t))
            end
        elseif ex.perfect_launch == true then
            status_str = "PERFECT LAUNCH (X10)"
        elseif ex.perfect_launch == false then
            status_str = "Mistimed (X5)"
        end
        return { vars = { ex.countdown or 20, ex.x_mult_perfect or 10, ex.x_mult_normal or 5, status_str } }
    end,
    update = function(self, card, dt)
        if card.area and card.area == G.jokers and not card.debuff and G.STATE and G.STATE == G.STATES.SELECTING_HAND then
            local ex = card.ability and card.ability.extra
            if ex then
                local real_now = (love and love.timer and love.timer.getTime and love.timer.getTime()) or G.TIMERS.REAL or 0
                if not ex.active then
                    ex.active = true
                    ex.countdown = 20
                    ex.timer = 20
                    ex.start_time = real_now
                    ex.perfect_launch = nil
                    ex.show_fire = false
                    ex.show_smoke = false
                    ex.last_alert_sec = 25
                end

                local old_t = ex.timer or 20
                local elapsed = real_now - (ex.start_time or real_now)
                ex.timer = (ex.countdown or 20) - elapsed

                local spd = (G.SETTINGS and G.SETTINGS.GAMESPEED) or 1

                -- 10s halfway alert
                if old_t > 10 and ex.timer <= 10 and (not ex.last_alert_sec or ex.last_alert_sec > 10) then
                    ex.last_alert_sec = 10
                    play_sound('chips1', 0.8, 0.5)
                    card:juice_up(0.12, 0.1)
                    attention_text({
                        text = "10s (STAGE)",
                        scale = 0.55,
                        hold = 0.7 * spd,
                        backdrop_colour = G.C.BLUE,
                        colour = G.C.WHITE,
                        major = card,
                        align = 'bm',
                        offset = { x = 0, y = 0.35 }
                    })
                end

                -- 5s get ready alert
                if old_t > 5 and ex.timer <= 5 and (not ex.last_alert_sec or ex.last_alert_sec > 5) then
                    ex.last_alert_sec = 5
                    play_sound('chips1', 1.0, 0.6)
                    card:juice_up(0.16, 0.12)
                    attention_text({
                        text = "5s (GET READY)",
                        scale = 0.6,
                        hold = 0.7 * spd,
                        backdrop_colour = G.C.ORANGE,
                        colour = G.C.WHITE,
                        major = card,
                        align = 'bm',
                        offset = { x = 0, y = 0.35 }
                    })
                end

                -- Countdown alerts (3, 2, 1)
                for sec = 3, 1, -1 do
                    if old_t > sec and ex.timer <= sec and (not ex.last_alert_sec or ex.last_alert_sec > sec) then
                        ex.last_alert_sec = sec
                        play_sound('chips1', 0.9 + (4 - sec) * 0.25, 0.7)
                        card:juice_up(0.2, 0.15)
                        local col = (sec == 1) and G.C.RED or G.C.ORANGE
                        attention_text({
                            text = tostring(sec) .. "s",
                            scale = 0.6,
                            hold = 0.65 * spd,
                            backdrop_colour = col,
                            colour = G.C.WHITE,
                            major = card,
                            align = 'bm',
                            offset = { x = 0, y = 0.35 }
                        })
                        break
                    end
                end

                -- Launch signal right at 0.0s!
                if old_t > 0 and ex.timer <= 0 and (ex.last_alert_sec == nil or ex.last_alert_sec > 0) then
                    ex.last_alert_sec = 0
                    ex.show_fire = true
                    ex.show_smoke = false
                    play_sound('tarot1', 1.5, 0.8)
                    card:juice_up(0.4, 0.3)
                    attention_text({
                        text = "0s! LAUNCH!",
                        scale = 0.75,
                        hold = 0.8 * spd,
                        backdrop_colour = G.C.GREEN,
                        colour = G.C.WHITE,
                        major = card,
                        align = 'bm',
                        offset = { x = 0, y = 0.35 }
                    })
                end

                -- 0.1s window expiration: if more than 0.1s passes after launch, drop to normal
                if old_t >= -0.10 and ex.timer < -0.10 and (ex.last_alert_sec == nil or ex.last_alert_sec > -1) then
                    ex.last_alert_sec = -1
                    ex.show_fire = false
                    ex.show_smoke = true
                    play_sound('cardSlide1', 0.85, 0.7)
                    card:juice_up(0.15, 0.15)
                    attention_text({
                        text = "LATE (+0.1s)",
                        scale = 0.55,
                        hold = 0.7 * spd,
                        backdrop_colour = G.C.RED,
                        colour = G.C.WHITE,
                        major = card,
                        align = 'bm',
                        offset = { x = 0, y = 0.35 }
                    })
                end
            end
        end
    end,
    calculate = function(self, card, context)
        local ex = card.ability and card.ability.extra
        if not ex then return end

        if context.before and not context.blueprint then
            local t = ex.timer or 20
            -- Perfect launch: within 0.1s after 0.0s (with 0.05s early anticipation grace)
            if t <= 0.05 and t >= -0.10 then
                ex.perfect_launch = true
                ex.show_fire = true
                ex.show_smoke = false
                play_sound('tarot1', 1.6, 0.9)
                card:juice_up(0.5, 0.4)
                if Particles then
                    local p = Particles(card.T.x, card.T.y, card.T.w, card.T.h, {
                        timer = 0.02,
                        pulse_max = 24,
                        max = 0,
                        scale = 0.35,
                        speed = 1.5,
                        lifespan = 0.9,
                        attach = G.ROOM_ATTACH or card,
                        colours = { HEX('ffe040'), HEX('ff8010'), HEX('ff3000'), HEX('ffffff') },
                        fill = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.7,
                        func = function()
                            if p and p.fade then p:fade(0.3, 1) end
                            return true
                        end
                    }))
                end
            else
                ex.perfect_launch = false
                ex.show_fire = false
                ex.show_smoke = true
                play_sound('cardSlide1', 0.85, 0.8)
                card:juice_up(0.2, 0.2)
                if Particles then
                    local smoke = Particles(card.T.x, card.T.y, card.T.w, card.T.h, {
                        timer = 0.03,
                        pulse_max = 20,
                        max = 0,
                        scale = 0.5,
                        speed = 0.7,
                        lifespan = 1.1,
                        attach = G.ROOM_ATTACH or card,
                        colours = { HEX('e8e8e8'), HEX('cccccc'), HEX('999999'), HEX('666666') },
                        fill = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.8,
                        func = function()
                            if smoke and smoke.fade then smoke:fade(0.35, 1) end
                            return true
                        end
                    }))
                end
            end
            ex.active = false
        end

        if context.joker_main then
            if ex.perfect_launch then
                play_dragster_sound()
                return {
                    Xmult = ex.x_mult_perfect or 10,
                    card = card
                }
            else
                return {
                    message = 'X' .. tostring(ex.x_mult_normal or 5) .. ' Mult [Tire Smoke]',
                    colour = G.C.MULT,
                    Xmult = ex.x_mult_normal or 5,
                    card = card
                }
            end
        end

        if (context.after or context.end_of_round or context.setting_blind) and not context.blueprint then
            ex.timer = ex.countdown or 20
            ex.active = false
            ex.perfect_launch = nil
            ex.show_fire = false
            ex.show_smoke = false
            ex.last_alert_sec = nil
        end
    end
}

if SMODS and SMODS.DrawStep then
    SMODS.DrawStep {
        key = 'top_fuel_dragster_flames',
        order = 65,
        func = function(self)
            if self.config and self.config.center and (self.config.center.key == 'j_reality_warp_top_fuel_dragster' or self.config.center.key == 'top_fuel_dragster') then
                local ex = self.ability and self.ability.extra
                local in_collection = (self.area and (self.area.config and self.area.config.collection or self.area == G.your_collection))
                                   or (self.params and (self.params.bypass_discovery_center or self.params.bypass_discovery_ui))
                                   or (self.area and self.area ~= G.jokers)
                                   or not (G.jokers and self.area == G.jokers)
                if ((ex and ex.show_fire) or in_collection) and self._flames_drawn_this_frame ~= G.TIMERS.REAL then
                    if not self.children.floating_sprite then
                        local atlas = (self.atlas and G.ASSET_ATLAS and G.ASSET_ATLAS[self.atlas])
                                   or (self.config and self.config.center and self.config.center.atlas and G.ASSET_ATLAS and G.ASSET_ATLAS[self.config.center.atlas])
                                   or (G.ASSET_ATLAS and (G.ASSET_ATLAS['reality_warp_reality_warp_legendary'] or G.ASSET_ATLAS['reality_warp_legendary']))
                        if atlas then
                            self.children.floating_sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, atlas, { x = 1, y = 8 })
                            self.children.floating_sprite.role.draw_major = self
                            self.children.floating_sprite.states.hover.can = false
                            self.children.floating_sprite.states.click.can = false
                        end
                    end
                    if self.children.floating_sprite then
                        local scale_mod = 0.05 + 0.03 * math.sin(4.5 * G.TIMERS.REAL)
                        local rotate_mod = 0.02 * math.sin(2.5 * G.TIMERS.REAL)
                        self.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
                        self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
                    end
                end
            end
        end,
        conditions = { vortex = false, facing = 'front' }
    }
end

local _old_win = Game.win_run
if _old_win then
    Game.win_run = function(self, ...)
        if G.GAME then G.GAME.reality_warp_run_won = true end
        return _old_win(self, ...)
    end
end
