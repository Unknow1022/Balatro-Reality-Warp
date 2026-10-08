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
        modifiers = {},
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
        modifiers = {},
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

local OUTSIDER_TRIALS_DATA = {
    {
        id = 'kyra',
        title = "KYRA'S WISH: POTION MASTERY",
        accent = HEX('00e5ff'),
        quote = "\"Show me your mastery of the brewing arts! Only potions can pave your path to Ante 6.\"",
        rules = {
            "Win Condition: Ante 6",
            "Consumables: Potions ONLY",
            "Jokers: Potion-related Jokers ONLY",
            "Starts with Kyra & Potion Brewer",
        },
        challenge_id = 'c_reality_warp_kyra_trial',
    },
    {
        id = 'ray',
        title = "RAY'S WISH: SPECTRAL RIFT",
        accent = HEX('818cf8'),
        quote = "\"The rift is unstable... only pure Spectral energies may be harnessed across the rifts!\"",
        rules = {
            "Consumables: Spectral cards ONLY",
            "Forbidden: The Soul & Warp Portal",
            "Tarots & Planets are strictly banned",
            "Starts with RayTracing",
        },
        challenge_id = 'c_reality_warp_ray_trial',
    },
    {
        id = 'charles',
        title = "CHARLES' WISH: HEART OF GOLD",
        accent = HEX('ef4444'),
        quote = "\"Every royal court must beat in unison. Turn every single card in your deck into a Heart!\"",
        rules = {
            "Goal: Convert 100% of your deck to Hearts",
            "Banned: Tarots converting to other suits",
            "Includes a freely movable progress HUD",
            "Starts with Charles",
        },
        challenge_id = 'c_reality_warp_charles_trial',
    },
    {
        id = 'mochi',
        title = "MOCHI'S WISH: WILD WONDERLAND",
        accent = HEX('e879f9'),
        quote = "\"Why be confined to one suit? Let adaptability run wild across your entire deck!\"",
        rules = {
            "Goal: Convert 100% of deck to Wild Cards",
            "Banned: All Tarot cards & Arcana packs",
            "Includes a freely movable progress HUD",
            "Starts with Mochi",
        },
        challenge_id = 'c_reality_warp_mochi_trial',
    },
}

G.UIDEF = G.UIDEF or {}

G.UIDEF.outsider_trials_tab = function(args)
    local trial_cards = {}
    for _, t in ipairs(OUTSIDER_TRIALS_DATA) do
        local rule_nodes = {}
        for _, r in ipairs(t.rules) do
            table.insert(rule_nodes, {
                n = G.UIT.R,
                config = { align = "cl", minh = 0.22 },
                nodes = {
                    { n = G.UIT.T, config = { text = "• " .. r, scale = 0.20, colour = G.C.UI.TEXT_LIGHT } }
                }
            })
        end

        local card_box = {
            n = G.UIT.C,
            config = {
                align = "cm",
                padding = 0.08,
                r = 0.12,
                colour = HEX('0f172a'),
                outline = 0.03,
                outline_colour = t.accent,
                shadow = true,
                minw = 5.2,
                minh = 2.45
            },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm", minh = 0.35 },
                    nodes = {
                        { n = G.UIT.T, config = { text = t.title, scale = 0.28, colour = t.accent, shadow = true } }
                    }
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm", minh = 0.40, maxw = 4.8 },
                    nodes = {
                        { n = G.UIT.T, config = { text = t.quote, scale = 0.20, colour = G.C.WHITE, shadow = false } }
                    }
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm", minh = 0.05 },
                    nodes = {}
                },
                {
                    n = G.UIT.C,
                    config = { align = "cl", padding = 0.02, minw = 4.8 },
                    nodes = rule_nodes
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm", minh = 0.06 },
                    nodes = {}
                },
                {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        padding = 0.04,
                        r = 0.08,
                        colour = G.C.GREEN,
                        hover = true,
                        shadow = true,
                        button = 'start_outsider_trial',
                        trial_id = t.id,
                        minw = 2.4,
                        minh = 0.38
                    },
                    nodes = {
                        { n = G.UIT.T, config = { text = "START TRIAL", scale = 0.26, colour = G.C.WHITE, shadow = true } }
                    }
                }
            }
        }
        table.insert(trial_cards, card_box)
    end

    local layout = {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.06, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.45 },
                nodes = {
                    { n = G.UIT.T, config = { text = "OUTSIDER JOKER TRIALS", scale = 0.45, colour = G.C.GOLD, shadow = true } }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.28 },
                nodes = {
                    { n = G.UIT.T, config = { text = "Fulfill the unique desires of the dimensional Outsiders", scale = 0.24, colour = G.C.UI.TEXT_LIGHT } }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    trial_cards[1],
                    { n = G.UIT.C, config = { minw = 0.2 }, nodes = {} },
                    trial_cards[2]
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    trial_cards[3],
                    { n = G.UIT.C, config = { minw = 0.2 }, nodes = {} },
                    trial_cards[4]
                }
            }
        }
    }
    return layout
end

G.FUNCS.start_outsider_trial = function(e)
    local tid = (e and e.config and e.config.trial_id) or 'kyra'
    local challenge_id = 'c_reality_warp_' .. tid .. '_trial'

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

function create_outsider_trial_hud(text_title, count, total, percent, is_complete, col)
    local cur_pos_x = (G.HUD_outsider_trial and G.HUD_outsider_trial.T and G.HUD_outsider_trial.T.x) or (G.ROOM.T.w * 0.5 - 1.3)
    local cur_pos_y = (G.HUD_outsider_trial and G.HUD_outsider_trial.T and G.HUD_outsider_trial.T.y) or 0.35

    if G.HUD_outsider_trial and not G.HUD_outsider_trial.REMOVED then
        G.HUD_outsider_trial:remove()
        G.HUD_outsider_trial = nil
    end

    local status_text = tostring(count) .. " / " .. tostring(total) .. " (" .. string.format("%.1f", percent) .. "%)"
    if is_complete then
        status_text = "COMPLETE! " .. tostring(count) .. "/" .. tostring(total)
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
                    padding = 0.08,
                    r = 0.12,
                    colour = HEX('0f172a'),
                    outline = 0.03,
                    outline_colour = is_complete and G.C.GOLD or col,
                    shadow = true,
                    minw = 2.6,
                    minh = 0.90
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = {
                            { n = G.UIT.T, config = { text = text_title, scale = 0.28, colour = col, shadow = true } }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = { align = "cm", padding = 0.02 },
                        nodes = {
                            { n = G.UIT.T, config = { text = status_text, scale = 0.32, colour = is_complete and G.C.GOLD or G.C.WHITE, shadow = true } }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = {
                            { n = G.UIT.T, config = { text = "[DRAG TO MOVE]", scale = 0.18, colour = G.C.GREY } }
                        }
                    }
                }
            }
        }
    }

    local hud = UIBox{
        definition = t,
        config = {
            align = "cm",
            offset = { x = 0, y = 0 }
        }
    }
    hud.T.x = cur_pos_x
    hud.T.y = cur_pos_y
    hud.VT.x = cur_pos_x
    hud.VT.y = cur_pos_y
    hud.states.drag.can = true

    function hud:drag()
        self.states.drag.is = true
        if G.CONTROLLER and G.CONTROLLER.cursor_position then
            local cx = G.CONTROLLER.cursor_position.x / (G.TILESCALE * G.TILESIZE)
            local cy = G.CONTROLLER.cursor_position.y / (G.TILESCALE * G.TILESIZE)
            local ox = (self.click_offset and self.click_offset.x) or (self.T.w * 0.5)
            local oy = (self.click_offset and self.click_offset.y) or (self.T.h * 0.5)
            self.T.x = cx - ox
            self.T.y = cy - oy
            self.VT.x = self.T.x
            self.VT.y = self.T.y
        end
    end

    function hud:stop_drag()
        Node.stop_drag(self)
        self.states.drag.is = false
    end

    G.HUD_outsider_trial = hud
    G.HUD_outsider_trial._last_val = count
    G.HUD_outsider_trial._last_total = total
end

if Game and Game.update then
    local orig_game_update_trials = Game.update
    function Game:update(dt)
        orig_game_update_trials(self, dt)
        if G.STAGE == G.STAGES.RUN and G.playing_cards and #G.playing_cards > 0 then
            if G.GAME and G.GAME.challenge == 'c_reality_warp_charles_trial' then
                local hearts_count = 0
                local total_cards = #G.playing_cards
                for _, c in ipairs(G.playing_cards) do
                    if c:is_suit('Hearts') then
                        hearts_count = hearts_count + 1
                    end
                end
                local pct = (total_cards > 0) and (hearts_count / total_cards * 100) or 0
                local is_comp = (hearts_count == total_cards and total_cards > 0)
                if not G.HUD_outsider_trial or G.HUD_outsider_trial.REMOVED or G.HUD_outsider_trial._last_val ~= hearts_count or G.HUD_outsider_trial._last_total ~= total_cards then
                    create_outsider_trial_hud("♥ CHARLES' HEARTS QUEST", hearts_count, total_cards, pct, is_comp, G.C.RED)
                end
            elseif G.GAME and G.GAME.challenge == 'c_reality_warp_mochi_trial' then
                local wild_count = 0
                local total_cards = #G.playing_cards
                for _, c in ipairs(G.playing_cards) do
                    if (is_wild_card and is_wild_card(c)) or (c.config and c.config.center == G.P_CENTERS.m_wild) then
                        wild_count = wild_count + 1
                    end
                end
                local pct = (total_cards > 0) and (wild_count / total_cards * 100) or 0
                local is_comp = (wild_count == total_cards and total_cards > 0)
                if not G.HUD_outsider_trial or G.HUD_outsider_trial.REMOVED or G.HUD_outsider_trial._last_val ~= wild_count or G.HUD_outsider_trial._last_total ~= total_cards then
                    create_outsider_trial_hud("★ MOCHI'S WILD QUEST", wild_count, total_cards, pct, is_comp, HEX('e879f9'))
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

if Card and Card.can_use_consumeable then
    local orig_can_use_consumeable = Card.can_use_consumeable
    function Card:can_use_consumeable(any_state, skip_check)
        if G.GAME and G.GAME.challenge == 'c_reality_warp_kyra_trial' then
            local set = (self.ability and self.ability.set) or (self.config and self.config.center and self.config.center.set)
            if set ~= 'Potion' then
                return false
            end
        end
        if G.GAME and G.GAME.challenge == 'c_reality_warp_ray_trial' then
            local set = (self.ability and self.ability.set) or (self.config and self.config.center and self.config.center.set)
            local k = (self.config and self.config.center and self.config.center.key) or ''
            if set ~= 'Spectral' or k == 'c_soul' or k == 'c_reality_warp_warp_portal' or k == 'c_warp_portal' then
                return false
            end
        end
        return orig_can_use_consumeable(self, any_state, skip_check)
    end
end

if create_card then
    local orig_create_card_trials = create_card
    function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
        if G.GAME and G.GAME.challenge == 'c_reality_warp_kyra_trial' then
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
        if G.GAME and G.GAME.challenge == 'c_reality_warp_ray_trial' then
            if _type == 'Consumeables' or _type == 'Tarot' or _type == 'Planet' or _type == 'Potion' then
                _type = 'Spectral'
            end
            if forced_key == 'c_soul' or forced_key == 'c_reality_warp_warp_portal' or forced_key == 'c_warp_portal' then
                forced_key = 'c_ankh'
            end
        end
        return orig_create_card_trials(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    end
end
