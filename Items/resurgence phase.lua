
local orig_update = Game.update
function Game:update(dt)
	orig_update(self, dt)
	if G.GAME.resurging and not G.GAME.resurging_started then
		RSGC.resurgence_info("start")
        G:save_progress()
        G.GAME.resurging_started = true
	end
end

function RSGC.resurgence_start()
    if (not G.GAME.seeded and not G.GAME.challenge) or SMODS.config.seeded_unlocks then
        set_joker_win()
        set_deck_win()
        check_and_set_high_score('win_streak', G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt+1)
        check_and_set_high_score('current_streak', G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt+1)
        check_for_unlock({type = 'win_no_hand'})
        check_for_unlock({type = 'win_no'})
        check_for_unlock({type = 'win_custom'})
        check_for_unlock({type = 'win_deck'})
        check_for_unlock({type = 'win_stake'})
        check_for_unlock({type = 'win'})
        inc_career_stat('c_wins', 1)
    end

    set_profile_progress()

    if G.GAME.challenge then
        G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[G.GAME.challenge] = true
        set_challenge_unlock()
        check_for_unlock({type = 'win_challenge'})
        G:save_settings()
    end

    G.GAME.resurging = true
    G.GAME.resurging_started = false

    if (not G.GAME.seeded and not G.GAME.challenge) or SMODS.config.seeded_unlocks then
        G.PROFILES[G.SETTINGS.profile].stake = math.max(G.PROFILES[G.SETTINGS.profile].stake or 1, (G.GAME.stake or 1)+1)
    end
    G:save_progress()
    G.FILE_HANDLER.force = true
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            if not G.SETTINGS.paused then
                G.GAME.current_round.round_text = 'Resurgence Round '
                return true
            end
        end)
    }))
end

function RSGC.resurgence_info(_part)
  	local step = 1
	G.SETTINGS.paused = true
	if _part == "start" then
		step = RSGC.jimbotalk({
			text_key = "rsgc_intro_1",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = 0 } },
			step = step,
		})
        step = RSGC.jimbotalk({
			text_key = "rsgc_intro_2",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = 0 } },
            delay = 0.05,
			step = step,
		})
        step = RSGC.jimbotalk({
			text_key = "rsgc_intro_3",
			attach = { major = G.ROOM_ATTACH, type = "cm", offset = { x = 0, y = -2 } },
			step = step,
		})
		step = RSGC.jimbotalk({
			delay = 0.1,
			step = step,
            finish = true
		})
	end
    if _part == "end" then
        G.GAME.resurging = false
        G.SETTINGS.paused = false
        G.E_MANAGER:clear_queue("tutorial")
        G.OVERLAY_TUTORIAL.Jimbo:remove()
		if G.OVERLAY_TUTORIAL.content then
			G.OVERLAY_TUTORIAL.content:remove()
		end
        G.OVERLAY_TUTORIAL:remove()
        G.OVERLAY_TUTORIAL = nil

        if next(SMODS.find_card("j_joker")) then
            for k,v in pairs(SMODS.find_card("j_joker")) do
				v:set_edition({negative = true})
                RSGC.unbound(v,function()
					G.E_MANAGER:add_event(Event({trigger = 'after',func = function()
						save_run()
						return true
					end}))
				end)
                
            end
        else
            RSGC.create_card("Joker", G.jokers, nil, nil, nil, nil, "j_joker",nil,nil,function(card)
				card:set_edition({negative = true})
                RSGC.unbound(card,function()
					G.E_MANAGER:add_event(Event({trigger = 'after',func = function()
						save_run()
						return true
					end}))
				end)
            end)
        end
	end
end

function RSGC.jimbotalk(args)
	local eased_color = copy_table(RSGC.C.VAMPIRICA)
    eased_color[4] = 0
    ease_value(eased_color, 4, 0.5, nil, nil, true)
	G.OVERLAY_TUTORIAL = G.OVERLAY_TUTORIAL
		or UIBox({
			definition = {
				n = G.UIT.ROOT,
				config = { align = "cm", padding = 32.05, r = 0.1, colour = eased_color, emboss = 0.05 },
				nodes = {},
			},
			config = {
				align = "cm",
				offset = { x = 0, y = 3.2 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
			},
		})
	G.OVERLAY_TUTORIAL.step = G.OVERLAY_TUTORIAL.step or 1
	G.OVERLAY_TUTORIAL.step_complete = false
	local row_dollars_chips = G.HUD and G.HUD:get_UIE_by_ID("row_dollars_chips") or G.ROOM_ATTACH
	local align = args.align or "tm"
	local step = args.step or 1
	local attach = args.attach or { major = row_dollars_chips, type = "tm", offset = { x = 0, y = -0.5 } }
	local pos = args.pos or { x = attach.major.T.x + attach.major.T.w / 2, y = attach.major.T.y + attach.major.T.h / 2 }
	local button = args.button or { button = localize("b_next"), func = "tut_next" }
	local highlight = {}
    G.E_MANAGER:add_event(
		Event({
			trigger = "after",
			delay = args.delay or 0.3,
			func = function()
                if args.finish then 
                    RSGC.resurgence_info("end")
                    return true
                end
				if G.OVERLAY_TUTORIAL and G.OVERLAY_TUTORIAL.step == step and not G.OVERLAY_TUTORIAL.step_complete then
					G.CONTROLLER.interrupt.focus = true
					G.OVERLAY_TUTORIAL.Jimbo = G.OVERLAY_TUTORIAL.Jimbo or RSGC_Card_Character(pos)
					highlight[#highlight + 1] = G.OVERLAY_TUTORIAL.Jimbo
					if args.text_key then
						G.OVERLAY_TUTORIAL.Jimbo:add_speech_bubble(args.text_key, align, args.loc_vars)
					end
					G.OVERLAY_TUTORIAL.Jimbo:set_alignment(attach)
					if args.hard_set then
						G.OVERLAY_TUTORIAL.Jimbo:hard_set_VT()
					end
					G.OVERLAY_TUTORIAL.button_listen = nil
					if G.OVERLAY_TUTORIAL.content then
						G.OVERLAY_TUTORIAL.content:remove()
					end
					if args.content then
						G.OVERLAY_TUTORIAL.content = UIBox({
							definition = args.content(),
							config = {
								align = args.content_config and args.content_config.align or "cm",
								offset = args.content_config and args.content_config.offset or { x = 0, y = 0 },
								major = args.content_config and args.content_config.major or G.OVERLAY_TUTORIAL.Jimbo,
								bond = "Weak",
							},
						})
						highlight[#highlight + 1] = G.OVERLAY_TUTORIAL.content
					end
					if args.button_listen then
						G.OVERLAY_TUTORIAL.button_listen = args.button_listen
					end
					if not args.no_button then
						G.OVERLAY_TUTORIAL.Jimbo:add_button(
							button.button,
							button.func,
							button.colour,
							button.update_func,
							true
						)
					end
					G.OVERLAY_TUTORIAL.Jimbo:say_stuff(2 * #(G.localization.misc.tutorial[args.text_key] or {}) + 1)
					if args.snap_to then
						G.E_MANAGER:add_event(
							Event({
								trigger = "immediate",
								blocking = false,
								blockable = false,
								func = function()
									if
										G.OVERLAY_TUTORIAL
										and G.OVERLAY_TUTORIAL.Jimbo
										and not G.OVERLAY_TUTORIAL.Jimbo.talking
									then
										local _snap_to = args.snap_to()
										if _snap_to then
											G.CONTROLLER.interrupt.focus = false
											G.CONTROLLER:snap_to({ node = args.snap_to() })
										end
										return true
									end
								end,
							}),
							"tutorial"
						)
					end
					if highlight then
						G.OVERLAY_TUTORIAL.highlights = highlight
					end
					G.OVERLAY_TUTORIAL.step_complete = true
				end
				return not G.OVERLAY_TUTORIAL or G.OVERLAY_TUTORIAL.step > step or G.OVERLAY_TUTORIAL.skip_steps
			end,
		}),
		"tutorial"
	)
	return step + 1
end

--class
RSGC_Card_Character = Moveable:extend()

--class methods
function RSGC_Card_Character:init(args)
    Moveable.init(self,args.x or 1, args.y or 1, args.w or G.CARD_W*1.1, args.h or G.CARD_H*1.1)

    self.states.collide.can = false

    self.children = {}
    self.config = {args = args}
    self.children.card = Card(self.T.x, self.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, args.center or G.P_CENTERS.j_joker, {bypass_discovery_center = true})
    self.children.card.states.visible = false
    self.children.card:start_materialize({G.C.BLUE, G.C.WHITE, G.C.RED})
    self.children.card:set_alignment{
        major = self, type = 'cm', offset = {x=0, y=0}
    }
    self.children.card.jimbo = self
    self.children.card.states.collide.can = true
    self.children.card.states.focus.can = false
    self.children.card.states.hover.can = true
    self.children.card.states.drag.can = false
    self.children.card.hover = Node.hover

    self.children.particles = Particles(0, 0, 0,0, {
        timer = 0.03,
        scale = 0.3,
        speed = 1.2,
        lifespan = 2,
        attach = self,
        colours = {G.C.RED, G.C.BLUE, G.C.ORANGE},
        fill = true
    })
    self.children.particles.static_rotation = true
    self.children.particles:set_role{
        role_type = 'Minor',
        xy_bond = 'Weak',
        r_bond = 'Strong',
        major = self,
    }

    if getmetatable(self) == RSGC_Card_Character then 
        table.insert(G.I.CARD, self)
    end
end

function RSGC_Card_Character:move(dt)
    Moveable.move(self, dt)
end

function RSGC_Card_Character:hard_set_VT()
    self:align_to_major()
    Moveable.hard_set_VT(self)
    self:align()
    self.children.card:hard_set_VT()
end

function RSGC_Card_Character:align()
    if self.children.card then
        self.children.card.T.x = self.T.x + (self.T.w - self.children.card.T.w)/2
        self.children.card.T.y = self.T.y + (self.T.h - self.children.card.T.h)/2
    end    
end

function RSGC_Card_Character:add_button(button, func, colour, update_func, snap_to, yoff)
    if self.children.button then self.children.button:remove() end
    self.config.button_align = {align="bm", offset = {x=0,y=yoff or 0.3},major = self, parent = self}
    self.children.button = UIBox{
        definition = create_UIBox_character_button({button = button, func = func, colour = colour, update_func = update_func, maxw = 3}),
        config = self.config.button_align 
    }
    if snap_to then G.CONTROLLER:snap_to{node = self.children.button} end
end

function RSGC_Card_Character:add_speech_bubble(text_key, align, loc_vars)
    if self.children.speech_bubble then self.children.speech_bubble:remove() end
    self.config.speech_bubble_align = {align=align or 'bm', offset = {x=0,y=0},parent = self}
    self.children.speech_bubble = 
    UIBox{
        definition = G.UIDEF.speech_bubble(text_key, loc_vars),
        config = self.config.speech_bubble_align
    }
    self.children.speech_bubble:set_role{
        role_type = 'Minor',
        xy_bond = 'Weak',
        r_bond = 'Strong',
        major = self,
    }
    self.children.speech_bubble.states.visible = false
end

function RSGC_Card_Character:remove_button()
    if self.children.button then self.children.button:remove(); self.children.button = nil end
end

function RSGC_Card_Character:remove_speech_bubble()
    if self.children.speech_bubble then self.children.speech_bubble:remove(); self.children.speech_bubble = nil end
end

function RSGC_Card_Character:say_stuff(n, not_first)
    self.talking = true
    if not not_first then 
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if self.children.speech_bubble then self.children.speech_bubble.states.visible = true end
                self:say_stuff(n, true)
              return true
            end
        }))
    else
        if n <= 0 then self.talking = false; return end
        local new_said = math.random(1, 11)
        while new_said == self.last_said do 
            new_said = math.random(1, 11)
        end
        self.last_said = new_said
        play_sound('voice'..math.random(1, 11), G.SPEEDFACTOR*(math.random()*0.2+1), 0.5)
        self.children.card:juice_up()
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            blockable = false, blocking = false,
            delay = 0.13,
            func = function()
                self:say_stuff(n-1, true)
            return true
            end
        }), 'tutorial')
    end
end

function RSGC_Card_Character:draw(dt)
    if self.highlight then
        self.children.highlight:draw()
        self.highlight:draw()
        if self.highlight.draw_children then self.highlight:draw_children() end
    end 
    if self.children.particles then
        self.children.particles:draw()
    end
    if self.children.speech_bubble then
        self.children.speech_bubble:draw()
    end
    if self.children.button and not self.talking then
        self.children.button:draw()
    end
    if self.children.card then
        self.children.card:draw()
    end
    add_to_drawhash(self)
    self:draw_boundingrect()
end

function RSGC_Card_Character:remove()
    G.jimboed = nil
    remove_all(self.children)
    for k, v in pairs(G.I.CARD) do
        if v == self then
            table.remove(G.I.CARD, k)
        end
    end
    Moveable.remove(self)
end
