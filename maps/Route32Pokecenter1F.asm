	object_const_def
	const ROUTE32POKECENTER1F_NURSE
	const ROUTE32POKECENTER1F_FISHING_GURU
	const ROUTE32POKECENTER1F_COOLTRAINER_F

Route32Pokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Route32Pokecenter1F_AntiSoftLock

.Route32Pokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

Route32Pokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

Route32Pokecenter1FFishingGuruScript:
	checkitem OLD_ROD
	iftrue .GotOldRod

	faceplayer
	opentext
	writetext Route32Pokecenter1FFishingGuruText_Question
	yesorno
	iffalse .Refused
	writetext Route32Pokecenter1FFishingGuruText_Yes
	promptbutton
	verbosegiveitem OLD_ROD
	writetext Route32Pokecenter1FFishingGuruText_GiveOldRod
	waitbutton
	closetext
	end

.Refused:
	writetext Route32Pokecenter1FFishingGuruText_No
	waitbutton
	closetext
	end

.GotOldRod:
	jumptextfaceplayer Route32Pokecenter1FFishingGuruText_After

Route32Pokecenter1FCooltrainerFScript:
	jumptextfaceplayer Route32Pokecenter1FCooltrainerFText

Route32Pokecenter1FFishingGuruText_Question:
	text "This is a great"
	line "fishing spot."

	para "You saw people"
	line "fishing? How"
	cont "about you?"

	para "Would you like one"
	line "of my RODS?"
	done

Route32Pokecenter1FFishingGuruText_Yes:
	text "Heh, that's good"
	line "to hear."

	para "Now you're an"
	line "angler too!"
	done

Route32Pokecenter1FFishingGuruText_GiveOldRod:
	text "Fishing is great!"

	para "If there's water,"
	line "be it the sea or a"

	para "stream, try out"
	line "your ROD."
	done

Route32Pokecenter1FFishingGuruText_No:
	text "Oh. That's rather"
	line "disappointing…"
	done

Route32Pokecenter1FFishingGuruText_After:
	text "Yo, kid. How are"
	line "they biting?"
	done

Route32Pokecenter1FCooltrainerFText:
	text "What should I make"
	line "my #MON hold?"

	para "Maybe an item that"
	line "increases ATTACK"
	cont "power…"
	done

Route32Pokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ROUTE_32, 1
	warp_event  4,  7, ROUTE_32, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route32Pokecenter1FNurseScript, -1
	object_event  1,  4, SPRITE_FISHING_GURU, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route32Pokecenter1FFishingGuruScript, -1
	object_event  6,  2, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route32Pokecenter1FCooltrainerFScript, -1
