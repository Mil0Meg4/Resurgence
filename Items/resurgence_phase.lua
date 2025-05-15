
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
                RSGC.unbound(v)
                v:set_edition({negative = true})
            end
        else
            RSGC.create_card("Joker", G.jokers, nil, nil, nil, nil, "j_joker",nil,nil,function(card)
                RSGC.unbound(card)
                card:set_edition({negative = true})
            end)
        end
		G.E_MANAGER:add_event(
		Event({func = function()
				save_run()
				return true
			end
		}))
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
					G.OVERLAY_TUTORIAL.Jimbo = G.OVERLAY_TUTORIAL.Jimbo or Card_Character(pos)
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
