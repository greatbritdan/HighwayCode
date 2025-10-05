-- JOKER MODIFICATIONS --
if SMODS.current_mod.config.enable_modifications then
    -- Change chad to Uncommon as too powerful
    SMODS.Joker:take_ownership("hanging_chad",{
        cost=6, rarity=2
    },true)
end

-- OBJECT TYPE FOR ALL SIGNS
SMODS.ObjectType({
	object_type = "ObjectType",
	key = "bhc_road_signs",
	default = "v_speedlimit",
	cards = {},
})

-- NEW COMMON JOKERS --
SMODS.Joker{
    key = "speedlimit",
    atlas = "jokers",
    pos = {x=1, y=0},
    pixel_size = {h=71},
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    pools = {bhc_road_signs=true},
    config = {extra={mult=0,mult_mod=4}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.mult,card.ability.extra.mult_mod}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return { mult=card.ability.extra.mult }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.current_round.hands_played > 1 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {message=localize("k_upgrade_ex"), colour=G.C.MULT}
            end
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="+"}, {ref_table="card.ability.extra", ref_value="mult", retrigger_type="mult"}},
            text_config = {colour=G.C.MULT}
        }
    end
}

SMODS.Joker{
    key = "minimumspeed",
    atlas = "jokers",
    pos = {x=8, y=0},
    pixel_size = {h=71},
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    pools = {bhc_road_signs=true},
    config = {extra={dollars=0,dollars_mod=2,dollars_max=10}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.dollars,card.ability.extra.dollars_mod,card.ability.extra.dollars_max}}
    end,
    calculate = function(self,card,context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.current_round.hands_played <= 1 then
                local previousdollars = card.ability.extra.dollars or 0
                card.ability.extra.dollars = math.min(card.ability.extra.dollars+card.ability.extra.dollars_mod, card.ability.extra.dollars_max)
                if card.ability.extra.dollars > previousdollars then
                    return {message=localize("k_upgrade_ex"), colour=G.C.MONEY}
                end
            else
                card.ability.extra.dollars = 0
                return {message=localize("k_reset"), colour=G.C.RED}
            end
        end
    end,
    calc_dollar_bonus = function(self,card)
        if card.ability.extra.dollars > 0 then
            return card.ability.extra.dollars
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="+$"}, {ref_table="card.ability.extra", ref_value="dollars"}},
            text_config = {colour=G.C.GOLD},
            reminder_text = {{ref_table="card.joker_display_values", ref_value="localized_text"}},
            calc_function = function(card)
                card.joker_display_values.localized_text = "("..localize("k_round")..")"
            end
        }
    end
}

SMODS.Joker{
    key = "roadnarrows",
    atlas = "jokers",
    pos = {x=3, y=0},
    pixel_size = {h=63},
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    pools = {bhc_road_signs=true},
    config = {extra={}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            if #context.scoring_hand > 1 and (context.other_card == context.scoring_hand[1] or context.other_card == context.scoring_hand[#context.scoring_hand]) then
                return {repetitions=1}
            elseif #context.scoring_hand == 1 then
                return {repetitions=2}
            end
        end
    end,
    joker_display_def = function(disp)
        return {
            retrigger_function = function(playing_card,scoring_hand,held_in_hand,joker_card)
                if held_in_hand then return 0 end
                if #scoring_hand > 1 then
                    local first_card = scoring_hand and disp.calculate_leftmost_card(scoring_hand)
                    local last_card = scoring_hand and #scoring_hand > 1 and disp.calculate_rightmost_card(scoring_hand)
                    return ((first_card and playing_card == first_card and disp.calculate_joker_triggers(joker_card) or 0)
                    + (last_card and playing_card == last_card and disp.calculate_joker_triggers(joker_card) or 0))
                elseif #scoring_hand == 1 then
                    return disp.calculate_joker_triggers(joker_card)*2
                end
            end
        }
    end
}

SMODS.Joker{
    key = "priorityoveroncoming",
    atlas = "jokers",
    pos = {x=5, y=0},
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    pools = {bhc_road_signs=true},
    config = {extra={mult=10}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.mult}}
    end,
    calculate = function(self,card,context)
        if context.before_scoring_cards then
            return {mult=card.ability.extra.mult}
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="+"}, {ref_table="card.ability.extra", ref_value="mult", retrigger_type="mult"}},
            text_config = {colour=G.C.MULT}
        }
    end
}

SMODS.Joker{
    key = "miniroandabout",
    atlas = "jokers",
    pos = {x=6, y=0},
    pixel_size = {h=63},
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    pools = {bhc_road_signs=true},
    config = {extra={}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    joker_display_def = function(disp)
        return {}
    end
}
-- Modify straight to allow wrapping if miniroandabout is in use
SMODS.PokerHandPart:take_ownership("_straight",{
    func = function(hand) return get_straight(hand, next(SMODS.find_card("j_four_fingers")) and 4 or 5, next(SMODS.find_card("j_shortcut")), next(SMODS.find_card("j_bhc_miniroandabout"))) end
},true)

SMODS.Joker{
    key = "giveway",
    atlas = "jokers",
    pos = {x=1, y=1},
    pixel_size = {h=63},
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    pools = {bhc_road_signs=true},
    config = {extra={mult=0,mult_mod=1}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.mult,card.ability.extra.mult_mod}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {mult=card.ability.extra.mult}
        end
        if context.setting_blind and not context.blueprint then
            local discards = G.GAME.current_round.discards_left
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(-discards,nil,true)
                    return true
                end
            }))
            if discards > 0 then
                card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_mod * discards)
                return {message=localize("k_upgrade_ex"), colour=G.C.MULT}
            else
                return nil, true
            end
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="+"}, {ref_table="card.ability.extra", ref_value="mult", retrigger_type="mult"}},
            text_config = {colour=G.C.MULT}
        }
    end
}

SMODS.Joker{
    key = "crossing",
    atlas = "jokers",
    pos = {x=3, y=1},
    pixel_size = {h=63},
    rarity = 1,
    blueprint_compat = false,
    cost = 4,
    pools = {bhc_road_signs=true},
    config = {extra={cardslots=1,boosterslots=2}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.cardslots,card.ability.extra.boosterslots}}
    end,
    add_to_deck = function(self,card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(-card.ability.extra.cardslots)
                SMODS.change_booster_limit(card.ability.extra.boosterslots)
                return true
            end
        }))
    end,
    remove_from_deck = function(self,card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.cardslots)
                SMODS.change_booster_limit(-card.ability.extra.boosterslots)
                return true
            end
        }))
    end,
    joker_display_def = function(disp)
        return {}
    end
}
-- Make booster packs be removed when selling the card
function SMODS.change_booster_limit(mod)
    G.GAME.modifiers.extra_boosters = (G.GAME.modifiers.extra_boosters or 0) + mod
    if mod < 0 and G.shop then
        for i = #G.shop_booster.cards, G.GAME.modifiers.extra_boosters+3, -1 do
            if G.shop_booster.cards[i] then
                G.shop_booster.cards[i]:remove()
            end
        end
    end
    if mod > 0 and G.shop then
        for i = 1, mod do
            SMODS.add_booster_to_shop()
        end
    end
end
G.FUNCS.can_reroll = function(e)
    if (((G.GAME.dollars-G.GAME.bankrupt_at) - G.GAME.current_round.reroll_cost < 0) and G.GAME.current_round.reroll_cost ~= 0) or G.GAME.shop.joker_max < 1 then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.GREEN
        e.config.button = "reroll_shop"
    end
end

SMODS.Joker{
    key = "trafficlight",
    atlas = "jokers_trafficlight",
    pos = {x=0, y=0},
    pixel_size = {h=63},
    rarity = 1,
    blueprint_compat = false,
    cost = 8,
    pools = {bhc_road_signs=true},
    config = {extra={state=1}},
    loc_vars = function(self,info_queue,card)
        if card.ability.extra.state == 1 then info_queue[#info_queue+1] = {key="bhc_trafficlight_1", set="Other", vars={}} end
		if card.ability.extra.state == 2 then info_queue[#info_queue+1] = {key="bhc_trafficlight_2", set="Other", vars={}} end
		if card.ability.extra.state == 3 then info_queue[#info_queue+1] = {key="bhc_trafficlight_3", set="Other", vars={}} end
        local names = {localize("bhc_trafficlight_1"), localize("bhc_trafficlight_2"), localize("bhc_trafficlight_3")}
        return {vars={names[card.ability.extra.state]}}
    end,
    calculate = function(self,card,context)
        if context.after and not context.blueprint then
            card.ability.extra.state = (card.ability.extra.state or 1) + 1
            if card.ability.extra.state > 3 then card.ability.extra.state = 1 end
            G.E_MANAGER:add_event(Event({
				func = function() BHC_SetTrafficLight(card); card:juice_up(); return true end
			}))
            if card.ability.extra.state == 1 then return {message=localize("bhc_trafficlight_1"), color=G.C.RED, card=card} end
			if card.ability.extra.state == 2 then return {message=localize("bhc_trafficlight_2"), color=G.C.ORANGE, card=card} end
			if card.ability.extra.state == 3 then return {message=localize("bhc_trafficlight_3"), color=G.C.GREEN, card=card} end
        end
        if context.mod_probability and not context.blueprint then
            if card.ability.extra.state == 1 then return {numerator = context.numerator/2} end
            if card.ability.extra.state == 2 then return {numerator = context.numerator} end
            if card.ability.extra.state == 3 then return {numerator = context.numerator*4} end
        end
    end,
    add_to_deck = function(self,card)
		BHC_SetTrafficLight(card)
    end,
    set_sprites = function(self,card)
        if self.discovered or card.bypass_discovery_center then
            BHC_SetTrafficLight(card)
        end
    end,
    joker_display_def = function(disp)
        return {}
    end
}
function BHC_SetTrafficLight(card)
    if card.ability and card.ability.extra and card.ability.extra.state then
        card.children.center:set_sprite_pos({x=card.ability.extra.state-1,y=0})
    end
end

SMODS.Joker{
    key = "roadworks",
    atlas = "jokers",
    pos = {x=1, y=2},
    pixel_size = {h=63},
    rarity = 1,
    blueprint_compat = false,
    cost = 4,
    pools = {bhc_road_signs=true},
    config = {extra={}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    calculate = function(self,card,context)
    end,
    joker_display_def = function(disp)
        return {}
    end
}

SMODS.Joker{
    key = "junction",
    atlas = "jokers",
    pos = {x=8, y=1},
    pixel_size = {h=63},
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    pools = {bhc_road_signs=true},
    config = {extra={mult=0,mult_mod=3}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.mult,card.ability.extra.mult_mod}}
    end,
    update = function(self,card)
        card.ability.extra.mult = 0
        for k, v in pairs(G.GAME.hands) do
            if v.played == 0 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            end
        end
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {mult=card.ability.extra.mult}
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="+"}, {ref_table="card.ability.extra", ref_value="mult", retrigger_type="mult"}},
            text_config = {colour=G.C.MULT}
        }
    end
}

SMODS.Joker{
    key = "slipperyroad",
    atlas = "jokers",
    pos = {x=0, y=2},
    pixel_size = {h=63},
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    pools = {bhc_road_signs=true},
    config = {extra={one=1,tarot_odds=2,spectral_odds=8}},
    loc_vars = function(self,info_queue,card)
        local tarot_numerator, tarot_denominator = SMODS.get_probability_vars(card, card.ability.extra.one, card.ability.extra.tarot_odds, "bhc_slipperyroadtarot")
        local spectral_numerator, spectral_denominator = SMODS.get_probability_vars(card, card.ability.extra.one, card.ability.extra.spectral_odds, "bhc_slipperyroadspectral")
        return {vars={tarot_numerator,tarot_denominator,spectral_numerator,spectral_denominator}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and #context.full_hand == 5 and context.scoring_name == "High Card" then
            local create_tarot = SMODS.pseudorandom_probability(card, "bhc_slipperyroadtarot", card.ability.extra.one, card.ability.extra.tarot_odds)
            if create_tarot and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card{set="Tarot", key_append="bhc_slipperyroadtarot"}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                SMODS.calculate_effect({message=localize("k_plus_tarot"), colour=G.C.PURPLE}, context.blueprint_card or card)
            end

            local create_spectral = SMODS.pseudorandom_probability(card, "bhc_slipperyroadspectral", card.ability.extra.one, card.ability.extra.spectral_odds)
            if create_spectral and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set="Spectral", key_append="bhc_slipperyroadspectral"}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                SMODS.calculate_effect({message=localize("k_plus_spectral"), colour=G.C.SECONDARY_SET.Spectral}, context.blueprint_card or card)
            end

            return nil, true -- This is for Joker retrigger purposes
		end
    end,
    joker_display_def = function(disp)
        return {
            extra = {
                {{text="("}, {ref_table="card.joker_display_values", ref_value="spectralodds"}, {text=")"}},
                {{text="("}, {ref_table="card.joker_display_values", ref_value="tarotodds"}, {text=")"}},
            },
            extra_config = {colour=G.C.GREEN, scale=0.3},
            calc_function = function(card)
                local tarot_numerator, tarot_denominator = SMODS.get_probability_vars(card, card.ability.extra.one, card.ability.extra.tarot_odds, "bhc_slipperyroadtarot")
                card.joker_display_values.tarotodds = localize{type="variable", key="jdis_odds", vars={tarot_numerator,tarot_denominator}}
                local spectral_numerator, spectral_denominator = SMODS.get_probability_vars(card, card.ability.extra.one, card.ability.extra.spectral_odds, "bhc_slipperyroadspectral")
                card.joker_display_values.spectralodds = localize{type="variable", key="jdis_odds", vars={spectral_numerator,spectral_denominator}}
            end
        }
    end
}

SMODS.Joker{
    key = "dualcarriagewayends",
    atlas = "jokers",
    pos = {x=4, y=2},
    pixel_size = {h=71},
    rarity = 1,
    blueprint_compat = false,
    cost = 4,
    pools = {bhc_road_signs=true},
    config = {extra={}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    calculate = function(self,card,context)
        if context.before_scoring_cards and not context.blueprint then
            return {balance=true}
        end
    end,
    joker_display_def = function(disp)
        return {}
    end
}

-- NEW UNCOMMON JOKERS --
SMODS.Joker{
    key = "queueslikely",
    atlas = "jokers",
    pos = {x=9, y=1},
    pixel_size = {h=63},
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    pools = {bhc_road_signs=true},
    config = {extra={xmult=1,xmult_mod=0.25}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.xmult,card.ability.extra.xmult_mod}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {xmult = card.ability.extra.xmult}
        end
        if context.before and not context.blueprint then
            if #context.scoring_hand == 5 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {message=localize("k_upgrade_ex"), colour=G.C.MULT}
            else
                card.ability.extra.xmult = 1
                return {message=localize("k_reset")}
            end
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{border_nodes = {{text="X"}, {ref_table="card.ability.extra", ref_value="xmult", retrigger_type="exp"}}}},
        }
    end
}

SMODS.Joker{
    key = "onewayahead",
    atlas = "jokers",
    pos = {x=0, y=0},
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    pools = {bhc_road_signs=true},
    config = {extra={chips=0,chips_mod=10,lastscore=0}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.chips,card.ability.extra.chips_mod,card.ability.extra.lastscore}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {chips=card.ability.extra.chips}
        end
        if context.post_plasma_step and not context.blueprint then
            local lastlastscore = card.ability.extra.lastscore or 0
            card.ability.extra.lastscore = mult*hand_chips
            if card.ability.extra.lastscore > lastlastscore then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                return {message=localize("k_upgrade_ex"), colour=G.C.CHIPS}
            end
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="+"}, {ref_table="card.ability.extra", ref_value="chips", retrigger_type="mult"}},
            text_config = {colour=G.C.CHIPS},
            reminder_text = {{ref_table="card.ability.extra", ref_value="lastscore"}},
        }
    end
}

SMODS.Joker{
    key = "giveprioritytooncoming",
    atlas = "jokers",
    pos = {x=5, y=2},
    pixel_size = {h=71},
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    pools = {bhc_road_signs=true},
    config = {extra={xmultbefore=0.5,xmultafter=4}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.xmultbefore,card.ability.extra.xmultafter}}
    end,
    calculate = function(self,card,context)
        if context.before_scoring_cards then
            return {xmult=card.ability.extra.xmultbefore}
        end
        if context.after_scoring_cards then
            return {xmult=card.ability.extra.xmultafter}
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{border_nodes = {{text="X"}, {ref_table="card.ability.extra", ref_value="xmultafter", retrigger_type="exp"}}}},
            reminder_text = {{text="(X"},{ref_table="card.ability.extra", ref_value="xmultbefore"},{text=" Before)"}},
        }
    end
}

SMODS.Joker{
    key = "nationalspeedlimit",
    atlas = "jokers",
    pos = {x=4, y=0},
    pixel_size = {h=71},
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    pools = {bhc_road_signs=true},
    config = {extra={xmult=1,xmult_mod=0.25}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.xmult,card.ability.extra.xmult_mod}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {xmult = card.ability.extra.xmult}
        end 
        if context.selling_card and (context.card ~= card) and not context.blueprint then
            if string.find(context.card.ability.name, "j_bhc") then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {message=localize("k_upgrade_ex")}
            end
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{border_nodes = {{text="X"}, {ref_table="card.ability.extra", ref_value="xmult", retrigger_type="exp"}}}},
        }
    end
}

SMODS.Joker{
    key = "speedcamera",
    atlas = "jokers",
    pos = {x=6, y=1},
    pixel_size = {h=58},
    rarity = 2,
    blueprint_compat = false,
    cost = 7,
    pools = {bhc_road_signs=true},
    config = {extra={}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    calculate = function(self,card,context)
        if context.before and not context.blueprint then
			local passed, valid = true, {}
			for _, pcard in ipairs(context.scoring_hand) do
				if BHC_IsDoubleRedLine(pcard) then
                    if not pcard.seal then table.insert(valid, pcard) end
                else
                    passed = false
				end
				if not passed then break end
			end
			if passed and #valid > 0 then
				local randomcard = pseudorandom_element(valid,pseudoseed("bhc_speedcameraseal"))
				G.E_MANAGER:add_event(Event({
                    func = function() randomcard:set_seal("Red",nil,true); randomcard:juice_up(); return true end
                }))
				return {message=localize("k_bhc_stamped"), colour=G.C.ORANGE, card=card}
			end
		end
    end,
    joker_display_def = function(disp)
        return {}
    end
}

SMODS.Joker{
    key = "congestioncharge",
    atlas = "jokers",
    pos = {x=0, y=1},
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    pools = {bhc_road_signs=true},
    config = {extra={bonus=10}},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS["m_bhc_doubleyellowline"]
        return {vars={card.ability.extra.bonus}}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and BHC_IsDoubleYellowLine(context.other_card) then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.bonus
            return {message=localize("k_upgrade_ex"), colour=G.C.CHIPS}
        end
    end,
    joker_display_def = function(disp)
        return {}
    end
}

SMODS.Joker{
    key = "nothroughroad",
    atlas = "jokers",
    pos = {x=7, y=0},
    pixel_size = {h=71},
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    cost = 6,
    pools = {bhc_road_signs=true},
    config = {extra={}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    calculate = function(self,card,context)
        if context.selling_self then
            local easehands = G.GAME.round_resets.hands - G.GAME.current_round.hands_left
            local easediscards = G.GAME.round_resets.discards - G.GAME.current_round.discards_left
            ease_hands_played(easehands)
            ease_discard(easediscards)
        end
    end,
    joker_display_def = function(disp)
        return {}
    end
}

SMODS.Joker{
    key = "segregatedroute",
    atlas = "jokers",
    pos = {x=4, y=1},
    pixel_size = {h=71},
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
    pools = {bhc_road_signs=true},
    config = {extra={dollars=1}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.dollars}}
    end,
    add_to_deck = function(self,card)
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + card.ability.extra.dollars
    end,
    remove_from_deck = function(self,card)
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 2) - card.ability.extra.dollars
    end,
    joker_display_def = function(disp)
        return {}
    end
}

SMODS.Joker{
    key = "nostopping",
    atlas = "jokers",
    pos = {x=5, y=1},
    pixel_size = {h=69},
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    pools = {bhc_road_signs=true},
    config = {extra={rerolls=0}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    calculate = function(self,card,context)
        if context.ending_shop and G.GAME.current_round.bhc_nostopping_rerolls == 0 then
            -- Get most played hand
            local _handname, _played, _order = "High Card", -1, 100
            for k, v in pairs(G.GAME.hands) do
                if v.played > _played or (v.played == _played and _order > v.order) then
                    _played = v.played
                    _handname = k
                end
            end
            -- Find a planet card with that hand type
            local _planet = nil
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == _handname then
                    _planet = v.key
                end
            end
            if _planet then
                G.E_MANAGER:add_event(Event({
                    func = function() SMODS.add_card({key=_planet,edition="e_negative"}); return true end
                }))
                return {message=localize("k_bhc_created")}
            end
        end
    end,
    joker_display_def = function(disp)
        return {}
    end
}
function SMODS.current_mod.reset_game_globals(run_start)
    G.GAME.current_round.bhc_nostopping_rerolls = 0
end

SMODS.Joker{
    key = "nouturns",
    atlas = "jokers",
    pos = {x=3, y=2},
    pixel_size = {h=63},
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    pools = {bhc_road_signs=true},
    config = {extra={chips=200,chips_mod=25}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.chips,card.ability.extra.chips_mod}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {chips=card.ability.extra.chips}
        end
        if context.selling_card and (context.card ~= card) and not context.blueprint then
            if card.ability.extra.chips-card.ability.extra.chips_mod <= 0 then
                SMODS.destroy_cards(card,nil,nil,true)
                return {message=localize("k_bhc_destroyed"), colour=G.C.CHIPS}
            else
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chips_mod
                return {message=localize{type="variable", key="a_chips_minus", vars={card.ability.extra.chips_mod}}, colour=G.C.CHIPS}
            end
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="+"}, {ref_table="card.ability.extra", ref_value="chips", retrigger_type="mult"}},
            text_config = {colour=G.C.CHIPS},
        }
    end
}

SMODS.Joker{
    key = "noentry",
    atlas = "jokers",
    pos = {x=2, y=2},
    pixel_size = {h=71},
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    pools = {bhc_road_signs=true},
    config = {extra={xmult=0.25,xmult_mod=0.75}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.xmult,card.ability.extra.xmult_mod}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {xmult=card.ability.extra.xmult}
        end
        if context.debuff_hand and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            return {debuff=true, debuff_text=localize("k_bhc_noentry"), debuff_source=card}
        end
        if context.debuffed_hand and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + (card.ability.extra.xmult_mod * #context.full_hand)
            return {message=localize{type="variable", key="a_xmult", vars={card.ability.extra.xmult}}}
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.xmult = 0.25
            return {message=localize("k_reset"), colour=G.C.RED}
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{border_nodes = {{text="X"}, {ref_table="card.ability.extra", ref_value="xmult", retrigger_type="exp"}}}},
        }
    end
}

SMODS.Joker{
    key = "twowaytraffic",
    atlas = "jokers",
    pos = {x=7, y=2},
    pixel_size = {h=63},
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    pools = {bhc_road_signs=true},
    config = {extra={chips=0,chips_mod=2}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.chips,card.ability.extra.chips_mod}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {chips=card.ability.extra.chips}
        end
        if context.cash_out and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + (context.dollars * card.ability.extra.chips_mod)
            return {message=localize("k_upgrade_ex"), colour=G.C.CHIPS}
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="+"}, {ref_table="card.ability.extra", ref_value="chips", retrigger_type="mult"}},
            text_config = {colour=G.C.CHIPS},
        }
    end
}

-- NEW RARE JOKERS --
SMODS.Joker{
    key = "passeitherway",
    atlas = "jokers",
    pos = {x=2, y=0},
    pixel_size = {h=71},
    rarity = 3,
    blueprint_compat = false,
    cost = 8,
    pools = {bhc_road_signs=true},
    config = {extra={}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    calculate = function(self,card,context)
        if context.before and #context.full_hand == 2 and not context.blueprint then
            if context.full_hand[1]:get_id() == context.full_hand[2]:get_id() then
                local new_card = context.full_hand[1]
                copy_card(context.full_hand[2], new_card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        new_card:juice_up()
                        return true
                    end
                }))
                return {message=localize("k_copied_ex"), colour=G.C.ORANGE}
            end
        end
    end,
    joker_display_def = function(disp)
        return {
            reminder_text = {{text="("}, {ref_table="card.joker_display_values", ref_value="localized_text", colour=G.C.ORANGE}, {text=")"}},
            calc_function = function(card)
                card.joker_display_values.localized_text = localize("Pair","poker_hands")
            end
        }
    end
}

SMODS.Joker{
    key = "otherdanger",
    atlas = "jokers",
    pos = {x=9, y=0},
    pixel_size = {h=63},
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 10,
    pools = {bhc_road_signs=true},
    config = {extra={round=0,totalrounds=3}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.totalrounds,card.ability.extra.round}}
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.round >= card.ability.extra.totalrounds) and not context.blueprint then
            local key = pseudorandom_element(G.P_CENTER_POOLS["bhc_road_signs"], pseudoseed("bhc_otherdangercard")).key
            SMODS.add_card{set="Joker",key=key,edition="e_negative",allow_duplicates=true}
            return {message=localize("k_bhc_created")}
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.round = card.ability.extra.round + 1
            if card.ability.extra.round == card.ability.extra.totalrounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.round < card.ability.extra.totalrounds) and (card.ability.extra.round.."/"..card.ability.extra.totalrounds) or localize("k_active_ex"),
                colour = G.C.FILTER
            }
        end
    end,
    joker_display_def = function(disp)
        return {
            reminder_text = {{text="("}, {ref_table="card.joker_display_values", ref_value="active"}, {text=")"}},
            calc_function = function(card)
                card.joker_display_values.active = card.ability.extra.round >= card.ability.extra.totalrounds and localize("k_active") or (card.ability.extra.round.."/"..card.ability.extra.totalrounds)
            end
        }
    end
}

SMODS.Joker{
    key = "stop",
    atlas = "jokers",
    pos = {x=2, y=1},
    pixel_size = {h=71},
    rarity = 3,
    blueprint_compat = false,
    cost = 8,
    pools = {bhc_road_signs=true},
    config = {extra={}},
    loc_vars = function(self,info_queue,card)
        return {vars={}}
    end,
    joker_display_def = function(disp)
        return {}
    end
}
function calculate_reroll_cost(skip_increment)
    if G.GAME.current_round.free_rerolls < 0 then G.GAME.current_round.free_rerolls = 0 end
    if G.GAME.current_round.free_rerolls > 0 then G.GAME.current_round.reroll_cost = 0; return end
    G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase or 0
    local extra = next(SMODS.find_card("j_bhc_roadworks")) and 2 or 1
    if (not skip_increment) and (not next(SMODS.find_card("j_bhc_stop"))) then G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase + extra end
    G.GAME.current_round.reroll_cost = (G.GAME.round_resets.temp_reroll_cost or G.GAME.round_resets.reroll_cost) + G.GAME.current_round.reroll_cost_increase
end

SMODS.Joker{
    key = "roundabout",
    atlas = "jokers",
    pos = {x=7, y=1},
    pixel_size = {h=63},
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
    pools = {bhc_road_signs=true},
    config = {extra={one=1,odds=4}},
    loc_vars = function(self,info_queue,card)
        local numerator, denominator = SMODS.get_probability_vars(card,card.ability.extra.one,card.ability.extra.odds,"bhc_roundabout")
        return {vars={numerator, denominator}}
    end,
    calculate = function(self,card,context)
        if context.return_to_hand and (not G.GAME.bhc_returntohand) and SMODS.pseudorandom_probability(card,"bhc_roundabout",card.ability.extra.one,card.ability.extra.odds) then
            G.GAME.bhc_returntohand = true
            return {message=localize("k_bhc_return")}
        end
    end,
    joker_display_def = function(disp)
        return {
            extra = {{{text="("}, {ref_table="card.joker_display_values", ref_value="odds"}, {text=")"}}},
            extra_config = {colour=G.C.GREEN, scale=0.3},
            calc_function = function(card)
                local numerator, denominator = SMODS.get_probability_vars(card,card.ability.extra.one,card.ability.extra.odds,"bhc_roundabout")
                card.joker_display_values.odds = localize{type="variable", key="jdis_odds", vars={numerator,denominator}}
            end
        }
    end
}
G.FUNCS.draw_from_play_to_hand_bhc = function()
    local play_count = #G.play.cards
    local it = 1
    for _,v in ipairs(G.play.cards) do
        if (not v.shattered) and (not v.destroyed) then
            draw_card(G.play, G.hand, it*100/play_count, "down", true, v)
            it = it + 1
        end
    end
end

SMODS.Joker{
    key = "unevenroad",
    atlas = "jokers",
    pos = {x=6, y=2},
    pixel_size = {h=63},
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    pools = {bhc_road_signs=true},
    config = {extra={state="even",repetitionseven=2,repetitionsodd=3}},
    loc_vars = function(self,info_queue,card)
        if card.ability.extra.state == "even" then
            return {vars={card.ability.extra.state,card.ability.extra.repetitionseven,"odd"}}
        else
            return {vars={card.ability.extra.state,card.ability.extra.repetitionsodd,"even"}}
        end
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if (card.ability.extra.state == "even" and G.GAME.current_round.discards_left % 2 == 0) then
                return {repetitions=card.ability.extra.repetitionseven}
            elseif (card.ability.extra.state == "odd" and G.GAME.current_round.discards_left % 2 == 1) then
                return {repetitions=card.ability.extra.repetitionsodd}
            end
            return nil, true
        end
        if context.after and not context.blueprint then
            card.ability.extra.state = (card.ability.extra.state == "even") and "odd" or "even"
            return {message=localize("k_bhc_"..card.ability.extra.state)}
        end
    end,
    joker_display_def = function(disp)
        return {
            text = {{text="Total: "},{ref_table="card.joker_display_values", ref_value="text", colour=G.C.RED}},
            reminder_text = {{text="("},{ref_table="card.ability.extra", ref_value="state"},{text=")"}},
            calc_function = function(card)
                card.joker_display_values.text = tostring(G.GAME.current_round.discards_left)
            end,
            retrigger_function = function(playing_card,scoring_hand,held_in_hand,joker_card)
                if held_in_hand then return 0 end
                if (joker_card.ability.extra.state == "even" and G.GAME.current_round.discards_left % 2 == 0) then
                    return disp.calculate_joker_triggers(joker_card) * joker_card.ability.extra.repetitionseven
                elseif (joker_card.ability.extra.state == "odd" and G.GAME.current_round.discards_left % 2 == 1) then
                    return disp.calculate_joker_triggers(joker_card) * joker_card.ability.extra.repetitionsodd
                end
            end
        }
    end
}

-- NEW LEGENDARY JOKER --
SMODS.Joker{
    key = "blanksign",
    atlas = "jokers",
    pos = {x=8, y=2},
    soul_pos = {x=9,y=2},
    rarity = 4,
    blueprint_compat = false,
    cost = 20,
    pools = {bhc_road_signs=true},
    config = {extra={creates=2}},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.creates}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.creates, G.jokers.config.card_limit-(#G.jokers.cards+G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        local key = pseudorandom_element(G.P_CENTER_POOLS["bhc_road_signs"], pseudoseed("bhc_blanksigncard")).key
                        SMODS.add_card{set="Joker",key=key,allow_duplicates=true}
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {message=localize("k_plus_joker"), colour=G.C.DARK_EDITION}
        end
    end,
    joker_display_def = function(disp)
        return {}
    end
}