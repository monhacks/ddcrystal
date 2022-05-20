	object_const_def
	const SEAFOAMGYM_BLAINE
	const SEAFOAMGYM_GYM_GUIDE

SeafoamGym_MapScripts:
	def_scene_scripts
	scene_script .DummyScene ; SCENE_DEFAULT

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .RaveParty

.DummyScene
	end

.RaveParty:
	clearevent EVENT_CINNABAR_RAVE_PARTY

	readvar VAR_WEEKDAY
	ifequal THURSDAY, .if_thursday
	ifequal FRIDAY, .if_friday
	endcallback

.if_thursday:
	readvar VAR_HOUR
	ifgreater 20, .DoRaveParty
	endcallback

.if_friday:
	readvar VAR_HOUR
	ifless 4, .DoRaveParty
	endcallback

.DoRaveParty:
	setevent EVENT_CINNABAR_RAVE_PARTY
	endcallback



SeafoamGymBlaineScript:
	faceplayer
	opentext
	checkflag ENGINE_VOLCANOBADGE
	iftrue .FightDone
	writetext BlaineIntroText

	setval WATER
	special CheckTypePresenceInParty
	iftrue .refuse_battle
	setval GROUND
	special CheckTypePresenceInParty
	iftrue .refuse_battle
	setval ROCK
	special CheckTypePresenceInParty
	iftrue .refuse_battle

	promptbutton
	writetext BlaineIntroEndText
	waitbutton
	closetext

	winlosstext BlaineWinLossText, 0
	loadtrainer BLAINE, BLAINE1
	startbattle
	iftrue .ReturnAfterBattle
	appear SEAFOAMGYM_GYM_GUIDE
.ReturnAfterBattle:
	reloadmapafterbattle
	setevent EVENT_BEAT_BLAINE
	opentext
	writetext ReceivedVolcanoBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_VOLCANOBADGE
	writetext BlaineAfterBattleText
	waitbutton
	closetext
	end

.refuse_battle:
	waitbutton
	closetext
	showemote EMOTE_SHOCK, SEAFOAMGYM_BLAINE, 15
	pause 5
	opentext
	writetext BlaineRefusesBattleText
	promptbutton
	farwritetext GymGuideRefusesEntranceEndText
	waitbutton
	closetext
	end

.FightDone:
	writetext BlaineFightDoneText
	waitbutton
	closetext
	end

SeafoamGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_SEAFOAM_GYM_GUIDE_ONCE
	iftrue .TalkedToSeafoamGymGuideScript
	writetext SeafoamGymGuideWinText
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_SEAFOAM_GYM_GUIDE_ONCE
	end

.TalkedToSeafoamGymGuideScript:
	writetext SeafoamGymGuideWinText2
	waitbutton
	closetext
	end

BlaineIntroText:
	text "BLAINE: Waaah!"

	para "The eruption may"
	line "have burned down"

	para "my GYM, but it"
	line "also made my"

	para "fiery will burn"
	line "stronger!"

	para "So I'm back in"
	line "business as a GYM"
	cont "LEADER, baby!"

	para "What doesn't kill"
	line "me makes me"
	cont "stronger, which is"

	para "why I decided to"
	line "dominate this"

	para "volcano by calling"
	line "it home."

	para "Waaah!"

	para "The intense heat"
	line "of the surrounding"
	
	para "lava is the per-"
	line "fect playground"

	para "for my FIRE brea-"
	line "thing #MON."
	done

BlaineIntroEndText:
	text "I accept your"
	line "challenge."

	para "Let this battle"
	line "determine which"

	para "one of us has the"
	line "most ardent will"
	cont "to win!"

	para "Wah ah haha!"
	done

BlaineRefusesBattleText:
	text "Someone should"
	line "have had told you…"

	para "You can't battle"
	line "in my GYM with"

	para "neither WATER,"
	line "GROUND, nor ROCK"
	cont "type #MON."
	done

BlaineWinLossText:
	text "BLAINE: Awesome."
	line "I've burned out…"

	para "You've earned"
	line "VOLCANOBADGE!"
	done

ReceivedVolcanoBadgeText:
	text "<PLAYER> received"
	line "VOLCANOBADGE."
	done

BlaineAfterBattleText:
	text "BLAINE: I did lose"
	line "this time, but I'm"

	para "going to win the"
	line "next time."

	para "When I rebuild my"
	line "CINNABAR GYM,"

	para "we'll have to have"
	line "a rematch."
	done

BlaineFightDoneText:
	text "BLAINE: My fire"
	line "#MON will be"

	para "even stronger."
	line "Just you watch!"
	done

SeafoamGymGuideWinText:
	text "Yo!"

	para "… Huh? It's over"
	line "already?"

	para "Sorry, sorry!"

	para "CINNABAR GYM was"
	line "gone, so I didn't"

	para "know where to find"
	line "you."

	para "The battle must've"
	line "been intense!"

	para "From the outside"
	line "it felt like the"

	para "volcano was about"
	line "to erupt again!"

	para "Oh boy did I"
	line "miss something!"
	done

SeafoamGymGuideWinText2:
	text "A #MON GYM can"
	line "be anywhere as"

	para "long as the GYM"
	line "LEADER is there."

	para "There's no need"
	line "for a building."
	done

SeafoamGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  5, CINNABAR_ISLAND, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_BLAINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, SeafoamGymBlaineScript, EVENT_CINNABAR_RAVE_PARTY
	object_event  6,  5, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SeafoamGymGuideScript, EVENT_SEAFOAM_GYM_GYM_GUIDE
