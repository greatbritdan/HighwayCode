SMODS.Back{
    name = "Highstreet Deck",
    key = "highstreet",
    atlas = "othercards",
    pos = {x=1, y=0},
    config = {dollars=10},
    loc_vars = function(self,info_queue)
        return {vars={self.config.dollars}}
    end,
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_ability(G.P_CENTERS["m_bhc_doubleyellowline"])
                end
                return true
            end
        }))
    end
}
if CardSleeves then
    CardSleeves.Sleeve({
		key = "highstreet_sleeve",
		name = "Highstreet Sleeve",
		atlas = "sleeves",
		pos = {x=0, y=0},
		config = {},
		loc_vars = function(self)
			local key, vars
            if self.get_current_deck_key() == "b_bhc_highstreet" then
                key = self.key.."_alt"
                self.config = {dollars=10,mixtypes=true}
                vars = {self.config.dollars}
            else
                key = self.key
                self.config = {dollars=10}
                vars = {self.config.dollars}
            end
            return {key=key, vars=vars}
		end,
        apply = function(self)
            G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + self.config.dollars
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i = #G.playing_cards, 1, -1 do
                        if self.config.mixtypes then
                            if math.random() > 0.5 then
                                G.playing_cards[i]:set_ability(G.P_CENTERS["m_bhc_doubleredline"])
                            end
                        else
                            G.playing_cards[i]:set_ability(G.P_CENTERS["m_bhc_doubleyellowline"])
                        end
                    end
                    return true
                end
            }))
        end
	})
end

SMODS.Back{
    name = "A-Road Deck",
    key = "a_road",
    atlas = "othercards",
    pos = {x=2, y=0},
    config = {},
    loc_vars = function(self,info_queue)
        return {vars={}}
    end,
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card{set="Joker",key="j_bhc_otherdanger",edition="e_negative"}
                return true
            end
        }))
    end
}
if CardSleeves then
    CardSleeves.Sleeve({
		key = "a_road_sleeve",
		name = "A-Road Sleeve",
		atlas = "sleeves",
		pos = {x=1, y=0},
		config = {},
		loc_vars = function(self)
			local key, vars
            if self.get_current_deck_key() == "b_bhc_a_road" then
                key = self.key.."_alt"
                self.config = {instant=true}
                vars = {}
            else
                key = self.key
                self.config = {}
                vars = {}
            end
            return {key=key, vars=vars}
		end,
        apply = function(self, sleeve)
            if self.config.instant then return end
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card{set="Joker",key="j_bhc_otherdanger",edition="e_negative"}
                    return true
                end
            }))
        end,
        calculate = function(self, sleeve, context)
            if not sleeve.config.instant then return end
            local card = context.card
            if context.create_card and card and card.ability.set == "Joker" and card.ability.name == "j_bhc_otherdanger" then
                card.ability.extra.round = card.ability.extra.totalrounds
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
        end,
	})
end

SMODS.Back{
    name = "Motorway Deck",
    key = "motorway",
    atlas = "othercards",
    pos = {x=3, y=0},
    config = {ante_scaling=1.5},
    loc_vars = function(self,info_queue)
        return {vars={self.config.ante_scaling}}
    end,
    apply = function()
        G.GAME.current_round.roadsigndoubles = true
    end
}
if CardSleeves then
    CardSleeves.Sleeve({
		key = "motorway_sleeve",
		name = "Motorway Sleeve",
		atlas = "sleeves",
		pos = {x=2, y=0},
		config = {},
		loc_vars = function(self)
			local key, vars
            if self.get_current_deck_key() == "b_bhc_motorway" then
                key = self.key.."_alt"
                self.config = {quadruple=true,cost_scaling=1.5}
                vars = {self.config.cost_scaling}
            else
                key = self.key
                self.config = {ante_scaling=1.5}
                vars = {self.config.ante_scaling}
            end
            return {key=key, vars=vars}
		end,
        apply = function(self, sleeve)
            if self.config.quadruple then
                G.GAME.current_round.roadsignquadruples = true
                G.GAME.current_round.cost_scaling = self.config.cost_scaling
            else
                G.GAME.starting_params.ante_scaling = self.config.ante_scaling
                G.GAME.current_round.roadsigndoubles = true
            end
        end,
	})
end