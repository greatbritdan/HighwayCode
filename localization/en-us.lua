return {
    descriptions = {
        Back={
            b_bhc_highstreet = {
                name = "Highstreet Deck",
                text = {
                    "Start with a Deck full of",
                    "{C:attention,T:m_bhc_doubleyellowline}Double Yellow Line{} cards",
                    "Start with an extra {C:money}$#1#",
                }
            },
            b_bhc_a_road = {
                name = "A-Road Deck",
                text = {
                    "Start with a {C:dark_edition}Negative{}",
                    "{C:attention,T:j_bhc_otherdanger}Other Danger{} Joker"
                }
            },
            b_bhc_motorway = {
                name = "Motorway Deck",
                text = {
                    "All {C:attention}Road Sign{} jokers",
                    "values are doubled",
                    "{C:red}X#1#{} base Blind size",
                }
            },
        },
        Sleeve = {
            sleeve_bhc_highstreet_sleeve = {
                name = "Highstreet Sleeve",
                text = {
                    "Start with a Deck full of",
                    "{C:attention,T:m_bhc_doubleyellowline}Double Yellow Line{} cards",
                    "Start with an extra {C:money}$#1#",
                }
            },
            sleeve_bhc_highstreet_sleeve_alt = {
                name = "Highstreet Sleeve",
                text = {
                    "Half of the deck is converted into",
                    "{C:attention,T:m_bhc_doubleredline}Double Red Line{} cards",
                    "Start with an extra {C:money}$#1#",
                }
            },
            sleeve_bhc_a_road_sleeve = {
                name = "A-Road Sleeve",
                text = {
                    "Start with a {C:dark_edition}Negative{}",
                    "{C:attention,T:j_bhc_otherdanger}Other Danger{} Joker"
                }
            },
            sleeve_bhc_a_road_sleeve_alt = {
                name = "A-Road Sleeve",
                text = {
                    "{C:attention,T:j_bhc_otherdanger}Other Danger{} Joker",
                    "is instantly activated"
                }
            },
            sleeve_bhc_motorway_sleeve = {
                name = "Motorway Sleeve",
                text = {
                    "All {C:attention}Road Sign{} jokers",
                    "values are doubled",
                    "{C:red}X#1#{} base Blind size",
                }
            },
            sleeve_bhc_motorway_sleeve_alt = {
                name = "Motorway Sleeve",
                text = {
                    "All {C:attention}Road Sign{} jokers",
                    "values are doubled again",
                    "{C:money}X#1#{} base Shop prices",
                }
            },
        },
        Blind={},
        Joker={
            j_bhc_speedlimit = {
                name = "Speed Limit",
                text = {
                    "This Joker gains {C:red}+#2#{} Mult if {C:attention}Blind{}",
                    "is defeated in more than one hand",
                    "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)",
                },
            },
            j_bhc_minimumspeed = {
                name = "Minimum Speed",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "Payout increases by {C:money}$#2#{}",
                    "if {C:attention}Blind{} is defeated in only",
                    "one hand, resets if more than",
                    "one hand is used",
                    "{C:inactive}(Max of {C:money}$#3#{C:inactive})",
                },
            },
            j_bhc_roadnarrows = {
                name = "Road Narrows",
                text = {
                    "Retrigger {C:attention}first{} and",
                    "{C:attention}last{} played card",
                    "{C:inactive}(If one card played, retrigger twice)",
                },
            },
            j_bhc_priorityoveroncoming = {
                name = "Priority Over Oncoming Traffic",
                text = {
                    "{C:mult}+#1#{} Mult before",
                    "played cards are scored"
                },
            },
            j_bhc_giveprioritytooncoming = {
                name = "Give Priority To Oncoming Traffic",
                text = {
                    "{X:mult,C:white} X#1# {} Mult before",
                    "played cards are scored",
                    "{X:mult,C:white} X#2# {} Mult after",
                    "played cards are scored",
                },
            },
            j_bhc_miniroandabout = {
                name = "Mini Roundabout",
                text = {
                    "{C:attention}Straights{} can be made with",
                    "an {C:attention}Ace{} in the middle",
                    "{C:inactive}(ex: Q-K-A-2-3)",
                },
            },
            j_bhc_giveway = {
                name = "Give Way",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:mult}+#2#{} Mult for each {C:red}Discard{}",
                    "{C:attention}lose all discards",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                },
            },
            j_bhc_crossing = {
                name = "Crossing",
                text = {
                    "{C:attention}-#1#{} card slots",
                    "{C:attention}+#2#{} booster packs",
                    "available in shop",
                },
            },
            j_bhc_trafficlight = {
                name = "Traffic Light",
                text = {
                    "Effect changes after",
                    "each hand played",
                    "{C:inactive}(Currently #1#){}"
                }
            },
            j_bhc_congestioncharge = {
                name = "Congestion Charge",
                text = {
                    "Every played",
                    "{C:attention}Double Yellow Line card{}",
                    "permanently gains {C:chips}+#1#{}",
                    "Chips when scored",
                },
            },
            j_bhc_speedcamera = {
                name = "Speed Camera",
                text = {
                    "If scoring hand only contains",
                    "{C:attention}Double Red Line cards{}",
                    "add a {C:red}Red seal{} to a",
                    "random scored card"
                },
            },
            j_bhc_nostopping = {
                name = "No Stopping",
                text = {
                    "Create a {C:dark_edition}Negative{}",
                    "{C:planet}Planet{} card for your most",
                    "played {C:attention}poker hand{} at end of shop",
                    "if no {C:green}Rerolls{} are used"
                }
            },
            j_bhc_junction = {
                name = "Junction",
                text = {
                    "{C:mult}+#2#{} Mult for",
                    "each unused {C:attention}poker hand{}",
                    "{C:attention}(Including hidden hands)",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                },
            },
            j_bhc_slipperyroad = {
                name = "Slippery Road",
                text = {
                    "If played hand is a {C:attention}High Card",
                    "and contains exactly {C:attention}5{} cards",
                    "{C:green}#1# in #2#{} chance",
                    "to create a {C:tarot}Tarot{} card",
                    "{C:green}#3# in #4#{} chance",
                    "to create a {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)",
                },
            },
            j_bhc_dualcarriagewayends = {
                name = "Dual Carriageway Ends",
                text = {
                    "Balance {C:chips}Chips{} and {C:mult}Mult{}",
                    "before played cards are scored"
                },
            },
            j_bhc_nouturns = {
                name = "No U Turns",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:chips}-#2#{} Chips for",
                    "each card sold"
                },
            },
            j_bhc_noentry =  {
                name = "No Entry",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "Gains {X:mult,C:white} X#2# {} Mult for each",
                    "card played in the {C:attention}first hand{}",
                    "and then {C:red}discards{} them",
                    "Resets at the end of the round",
                }
            },
            j_bhc_twowaytraffic = {
                name = "Two Way Traffic",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "Gains {C:chips}+#2#{} Chips for each",
                    "dollar earned at the",
                    "end of the round",
                },
            },
            j_bhc_onewayahead = {
                name = "One Way Ahead",
                text = {
                    "If {C:attention}Total Score{} is higher than",
                    "your last score, gain {C:chips}+#2#{} Chips",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                    "{C:inactive}(Last Score was {C:attention}#3#{C:inactive})"
                },
            },
            j_bhc_nationalspeedlimit = {
                name = "National Speed Limit",
                text = {
                    "This Joker gains {X:mult,C:white} X#2# {} Mult",
                    "for each {C:attention}Road Sign{} {C:attention}sold{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
            },
            j_bhc_nothroughroad = {
                name = "No Through Road",
                text = {
                    "Sell this card during a",
                    "{C:attention}Blind{} to reset all",
                    "{C:blue}Hands{} and {C:red}Discards{}",
                },
            },
            j_bhc_segregatedroute = {
                name = "Segregated Route",
                text = {
                    "Earn an extra {C:money}$#1#{}",
                    "for each unused {C:blue}Hand{}",
                }
            },
            j_bhc_queueslikely = {
                name = "Queues Likely",
                text = {
                    "This Joker gains {X:mult,C:white} X#2# {} Mult",
                    "per {C:attention}consecutive{} hand played",
                    "with exactly {C:attention}5 scoring{} cards",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
            },
            j_bhc_roadworks = {
                name = "Roadworks",
                text = {
                    "{C:attention}Double Yellow Line cards{} and",
                    "{C:attention}Double Red Line cards{}",
                    "are treated as the same card",
                },
            },
            j_bhc_passeitherway = {
                name = "Pass Either Way",
                text = {
                    "If played hand is a {C:attention}Pair{}",
                    "and only contains two cards",
                    "convert the {C:attention}left{} card",
                    "into the {C:attention}right{} card",
                    "{C:inactive}(Drag to rearrange)",
                },
            },
            j_bhc_otherdanger = {
                name = "Other Danger",
                text = {
                    "After {C:attention}#1#{} rounds,",
                    "sell this card to create a",
                    "random {C:dark_edition}Negative{} {C:attention}Road Sign{}",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)",
                },
            },
            j_bhc_stop = {
                name = "Stop",
                text = {
                    "{C:green}Reroll{} cost no",
                    "longer scales"
                },
            },
            j_bhc_roundabout = {
                name = "Roundabout",
                text = {
                    "{C:green}#1# in #2#{} chance",
                    "played cards are returned",
                    "to hand after scoring"
                },
            },
            j_bhc_unevenroad = {
                name = "Uneven Road",
                text = {
                    "If your remaining {C:red}Discards{}",
                    "are {C:attention}#1#{}, retrigger all",
                    "played cards {C:attention}#2#{} times",
                    "{C:inactive}(Switches to #3# after next hand)",
                },
            },
            j_bhc_blanksign = {
                name = "Blank Sign",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "create {C:attention}#1# Road Sign{C:attention} jokers",
                    "{C:inactive}(Must have room)",
                    "{C:dark_edition}(Can create duplicates)",
                },
            },
            -- UNUSED --
            j_bhc_oldotherdanger = {
                name = "Other Danger",
                text = {
                    "Retrigger all played cards",
                    "once for each {C:attention}Road Sign{}",
                    "{C:inactive}(Not including this card)",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive} Retrigger(s))"
                },
            },
            j_bhc_unnammed = {
                name = "Unnammed",
                text = {
                    "{C:green}Rerolling{} the shop",
                    "also rerolls {C:attention}Booster{} packs.",
                    "{C:green}Reroll{} cost scales by +$2"
                },
            },
        },
        Enhanced={
            m_bhc_doubleyellowline = {
                name = "Double Yellow Line Card",
                text = {
                    "Immune from being {C:attention}debuffed{}",
                    "{C:money}$#1#{} if held in hand"
                },
            },
            m_bhc_doubleredline = {
                name = "Double Red Line Card",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "Destroyed if held in hand",
                    "at end of round"
                },
            },
        },
        Tag={},
        Other={
            bhc_trafficlight_1 = {name="Stop!", text={"All Probabilities are {C:red}Halved{}","{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}0.5 in 3{C:inactive})"}},
            bhc_trafficlight_2 = {name="Prepare!", text={"All Probabilities are {C:orange}Unchanged{}","{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}1 in 3{C:inactive})"}},
            bhc_trafficlight_3 = {name="Go!", text={"All Probabilities are {C:green}Quadrupled{}","{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}4 in 3{C:inactive})"}},
        },
        Voucher={},
        Tarot={
            c_bhc_congestion={
                name="Congestion",
                text={
                    "Enhances {C:attention}#1#{} selected cards",
                    "into {C:attention}Double Yellow Line Cards",
                },
            },
            c_bhc_prosecution={
                name="Prosecution",
                text={
                    "Enhances {C:attention}#1#{} selected cards",
                    "into {C:attention}Double Red Line Cards",
                },
            },
            
        },
        Planet={},
        Spectral={},
        TagCard={}
    },
    misc = {
        poker_hands = {},
        poker_hand_descriptions = {},
        challenge_names = {
            c_bhc_roadtrip = "Road Trip"
        },
        v_text = {
            ch_c_just_road_signs={
                "No {C:attention}vanilla{} jokers appear in the shop"
            },
        },
        labels = {},
        dictionary = {
            k_bhc_smartass = "Smartass.",
            k_bhc_created = "Created!",
            k_bhc_destroyed = "Destroyed!",
            k_bhc_stamped = "Stamped!",
            k_bhc_return = "Return!",
            k_bhc_noentry = "No Entry!",
            bhc_trafficlight_1 = "Stop!",
            bhc_trafficlight_2 = "Prepare!",
            bhc_trafficlight_3 = "Go!",
            k_bhc_even = "Even!",
            k_bhc_odd = "Odd!",

            k_bhc_configsettings = "Settings!",
            k_bhc_configenablevanilla = "Enable Vanilla Modifications"
        }
    },
}