G.C.HIGHWAY = HEX("006C49")

SMODS.Atlas{key="modicon", px=32, py=32, path="modicon.png"}
SMODS.Atlas{key="jokers", px=71, py=95, path="jokers.png"}
SMODS.Atlas{key="jokers_trafficlight", px=71, py=95, path="jokers_trafficlight.png"}
SMODS.Atlas{key="consumables", px=71, py=95, path="consumables.png"}
SMODS.Atlas{key="othercards", px=71, py=95, path="othercards.png"}
SMODS.Atlas{key="sleeves", px=73, py=95, path="sleeves.png"}

SMODS.current_mod.optional_features = {}

-- JOKERS --
assert(SMODS.load_file("src/jokers.lua"))()

-- CONSUMABLES --
assert(SMODS.load_file("src/consumables.lua"))()

-- DECKS --
assert(SMODS.load_file("src/decks.lua"))()

-- ENHANCEMENTS --
SMODS.Enhancement {
    key = "doubleyellowline",
    atlas = "othercards",
    pos = {x=0, y=0},
    config = {h_dollars=-1},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.h_dollars}}
    end,
	update = function(self,card)
		card.ability.mult = 0
		card.ability.redline = nil
		if next(SMODS.find_card("j_bhc_roadworks")) then
			card.ability.mult = 10
			card.ability.redline = true
		end
	end
}
function BHC_IsDoubleYellowLine(card)
	if card.ability.name == "m_bhc_doubleyellowline" then return true end
	if next(SMODS.find_card("j_bhc_roadworks")) and card.ability.name == "m_bhc_doubleredline" then return true end
	return false
end

SMODS.Enhancement {
    key = "doubleredline",
    atlas = "othercards",
    pos = {x=4, y=0},
    config = {mult=10,redline=true},
    loc_vars = function(self,info_queue,card)
        return {vars={card.ability.mult}}
    end,
	update = function(self,card)
		card.ability.h_dollars = nil
		if next(SMODS.find_card("j_bhc_roadworks")) then
			card.ability.h_dollars = -1
		end
	end
}
function BHC_IsDoubleRedLine(card)
	if card.ability.name == "m_bhc_doubleredline" then return true end
	if next(SMODS.find_card("j_bhc_roadworks")) and card.ability.name == "m_bhc_doubleyellowline" then return true end
	return false
end

local original = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    if key == "redline" then
		G.E_MANAGER:add_event(Event({
			func = (function()
				scored_card:start_dissolve()
				return true
			end)
		}))
		delay(0.7)
        return true
    end
    return original(effect, scored_card, key, amount, from_edition)
end
table.insert(SMODS.other_calculation_keys, "redline")

-- CHALLENGE --
SMODS.Challenge{
    key = "roadtrip",
    rules = {
        custom = {
			{id="just_road_signs"}
		},
        modifiers = {}
    },
    jokers = {},
    restrictions = {
        banned_cards = {
			{id="j_joker"},
			{id="j_greedy_joker"},
			{id="j_lusty_joker"},
			{id="j_wrathful_joker"},
			{id="j_gluttenous_joker"},
			{id="j_jolly"},
			{id="j_zany"},
			{id="j_mad"},
			{id="j_crazy"},
			{id="j_droll"},
			{id="j_sly"},
			{id="j_wily"},
			{id="j_clever"},
			{id="j_devious"},
			{id="j_crafty"},
			{id="j_half"},
			{id="j_stencil"},
			{id="j_four_fingers"},
			{id="j_mime"},
			{id="j_credit_card"},
			{id="j_ceremonial"},
			{id="j_banner"},
			{id="j_mystic_summit"},
			{id="j_marble"},
			{id="j_loyalty_card"},
			{id="j_8_ball"},
			{id="j_misprint"},
			{id="j_dusk"},
			{id="j_raised_fist"},
			{id="j_chaos"},
			{id="j_fibonacci"},
			{id="j_steel_joker"},
			{id="j_scary_face"},
			{id="j_abstract"},
			{id="j_delayed_grat"},
			{id="j_hack"},
			{id="j_pareidolia"},
			{id="j_gros_michel"},
			{id="j_even_steven"},
			{id="j_odd_todd"},
			{id="j_scholar"},
			{id="j_business"},
			{id="j_supernova"},
			{id="j_ride_the_bus"},
			{id="j_space"},
			{id="j_egg"},
			{id="j_burglar"},
			{id="j_blackboard"},
			{id="j_runner"},
			{id="j_ice_cream"},
			{id="j_dna"},
			{id="j_splash"},
			{id="j_blue_joker"},
			{id="j_sixth_sense"},
			{id="j_constellation"},
			{id="j_hiker"},
			{id="j_faceless"},
			{id="j_green_joker"},
			{id="j_superposition"},
			{id="j_todo_list"},
			{id="j_cavendish"},
			{id="j_card_sharp"},
			{id="j_red_card"},
			{id="j_madness"},
			{id="j_square"},
			{id="j_seance"},
			{id="j_riff_raff"},
			{id="j_vampire"},
			{id="j_shortcut"},
			{id="j_hologram"},
			{id="j_vagabond"},
			{id="j_baron"},
			{id="j_cloud_9"},
			{id="j_rocket"},
			{id="j_obelisk"},
			{id="j_midas_mask"},
			{id="j_luchador"},
			{id="j_photograph"},
			{id="j_gift"},
			{id="j_turtle_bean"},
			{id="j_erosion"},
			{id="j_reserved_parking"},
			{id="j_mail"},
			{id="j_to_the_moon"},
			{id="j_hallucination"},
			{id="j_fortune_teller"},
			{id="j_juggler"},
			{id="j_drunkard"},
			{id="j_stone"},
			{id="j_golden"},
			{id="j_lucky_cat"},
			{id="j_baseball"},
			{id="j_bull"},
			{id="j_diet_cola"},
			{id="j_trading"},
			{id="j_flash"},
			{id="j_popcorn"},
			{id="j_trousers"},
			{id="j_ancient"},
			{id="j_ramen"},
			{id="j_walkie_talkie"},
			{id="j_selzer"},
			{id="j_castle"},
			{id="j_smiley"},
			{id="j_campfire"},
			{id="j_ticket"},
			{id="j_mr_bones"},
			{id="j_acrobat"},
			{id="j_sock_and_buskin"},
			{id="j_swashbuckler"},
			{id="j_troubadour"},
			{id="j_certificate"},
			{id="j_smeared"},
			{id="j_throwback"},
			{id="j_hanging_chad"},
			{id="j_rough_gem"},
			{id="j_bloodstone"},
			{id="j_arrowhead"},
			{id="j_onyx_agate"},
			{id="j_glass"},
			{id="j_ring_master"},
			{id="j_flower_pot"},
			{id="j_blueprint"},
			{id="j_wee"},
			{id="j_merry_andy"},
			{id="j_oops"},
			{id="j_idol"},
			{id="j_seeing_double"},
			{id="j_matador"},
			{id="j_hit_the_road"},
			{id="j_duo"},
			{id="j_trio"},
			{id="j_family"},
			{id="j_order"},
			{id="j_tribe"},
			{id="j_stuntman"},
			{id="j_invisible"},
			{id="j_brainstorm"},
			{id="j_satellite"},
			{id="j_shoot_the_moon"},
			{id="j_drivers_license"},
			{id="j_cartomancer"},
			{id="j_astronomer"},
			{id="j_burnt"},
			{id="j_bootstraps"},
			{id="j_caino"},
			{id="j_triboulet"},
			{id="j_yorick"},
			{id="j_chicot"},
			{id="j_perkeo"}
		},
        banned_tags = {},
        banned_other = {}
    }
}

-- CONFIG TAB --
local config_data = SMODS.current_mod.config or {}
function ConfigTab()
    local nodes = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = "Settings!",
							colours = { G.C.WHITE },
							shadow = true, rotate = true, bump = true,
							scale = 0.7,
						}),
					},
				},
			},
		},
	}

    local left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	local right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	local config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
    nodes[#nodes + 1] = config
    nodes[#nodes + 1] = create_toggle({
		label = "Enable Vanilla Modifications",
		active_colour = G.C.RED,
		ref_table = config_data,
		ref_value = "enable_modifications",
	})

    return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = nodes,
	}
end
SMODS.current_mod.config_tab = ConfigTab