	object_const_def
	const ROUTE12_FISHER1
	const ROUTE12_FISHER2
	const ROUTE12_FISHER3
	const ROUTE12_FISHER4
	const ROUTE12_POKE_BALL1
	const ROUTE12_POKE_BALL2
	const ROUTE12_TEACHER1
	const ROUTE12_YOUNGSTER1
	const ROUTE12_YOUNGSTER2
	const ROUTE12_SAILOR1

Route12_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .CheckMomCall
	
.CheckMomCall:
	checkevent EVENT_MOM_CALLED_ABOUT_VACCINATION_PASS
	iftrue .end

	setevent EVENT_MOM_CALLED_ABOUT_VACCINATION_PASS
	specialphonecall SPECIALCALL_VACCINE_PASSPORT

.end
	endcallback

TrainerFisherKyle:
	trainer FISHER, KYLE, EVENT_BEAT_FISHER_KYLE, FisherKyleSeenText, FisherKyleBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherKyleAfterBattleText

TrainerFisherMartin:
	trainer FISHER, MARTIN, EVENT_BEAT_FISHER_MARTIN, FisherMartinSeenText, FisherMartinBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherMartinAfterBattleText

TrainerFisherStephen:
	trainer FISHER, STEPHEN, EVENT_BEAT_FISHER_STEPHEN, FisherStephenSeenText, FisherStephenBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherStephenAfterBattleText

TrainerFisherBarney:
	trainer FISHER, BARNEY, EVENT_BEAT_FISHER_BARNEY, FisherBarneySeenText, FisherBarneyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherBarneyAfterBattleText

TrainerTeacherCecilia:
	trainer TEACHER, CECILIA, EVENT_BEAT_TEACHER_CECILIA, TeacherCeciliaSeenText, TeacherCeciliaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TeacherCeciliaAfterBattleText

TrainerSchoolboySawara:
	trainer SCHOOLBOY, SAWARA, EVENT_BEAT_SCHOOLBOY_SAWARA, SchoolboySawaraSeenText, SchoolboySawaraBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboySawaraAfterBattleText

TrainerSchoolboyGinko:
	trainer SCHOOLBOY, GINKO, EVENT_BEAT_SCHOOLBOY_GINKO, SchoolboyGinkoSeenText, SchoolboyGinkoBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboyGinkoSeenText

TrainerSailorClovis:
	trainer SAILOR, CLOVIS, EVENT_BEAT_SAILOR_CLOVIS, SailorClovisSeenText, SailorClovisBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorClovisAfterBattleText

TrainerSailorStrand:
	trainer SAILOR, STRAND, EVENT_BEAT_SAILOR_STRAND, SailorStrandSeenText, SailorStrandBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorStrandAfterBattleText

Route12Sign:
	jumptext Route12SignText

FishingSpotSign:
	jumptext FishingSpotSignText

Route12Calcium:
	itemball CALCIUM

Route12Nugget:
	itemball TOILET_PAPER

Route12FruitTree:
	fruittree FRUITTREE_ROUTE_12

Route12HiddenElixer:
	hiddenitem ELIXER, EVENT_ROUTE_12_HIDDEN_ELIXER

FisherMartinSeenText:
	text "Patience is the"
	line "key to both fish-"
	cont "ing and #MON."
	done

FisherMartinBeatenText:
	text "Gwaaah!"
	done

FisherMartinAfterBattleText:
	text "I'm too impatient"
	line "for fishing…"
	done

FisherStephenSeenText:
	text "I feel so content,"
	line "fishing while lis-"
	cont "tening to some"
	cont "tunes on my radio."
	done

FisherStephenBeatenText:
	text "My stupid radio"
	line "distracted me!"
	done

FisherStephenAfterBattleText:
	text "Have you checked"
	line "out KANTO's radio"

	para "programs? We get a"
	line "good variety here."
	done

FisherBarneySeenText:
	text "What's most impor-"
	line "tant in our every-"
	cont "day lives?"
	done

FisherBarneyBeatenText:
	text "The answer is"
	line "coming up next!"
	done

FisherBarneyAfterBattleText:
	text "I think electric-"
	line "ity is the most"

	para "important thing in"
	line "our daily lives."

	para "If it weren't,"
	line "people wouldn't"

	para "have made such a"
	line "fuss when the"

	para "POWER PLANT went"
	line "out of commission."
	done

FisherKyleSeenText:
	text "Do you remember?"
	done

FisherKyleBeatenText:
	text "You do remember?"
	done

FisherKyleAfterBattleText:
	text "The tug you feel"
	line "on the ROD when"

	para "you hook a #-"
	line "MON…"

	para "That's the best"
	line "feeling ever for"
	cont "an angler like me."
	done

TeacherCeciliaSeenText:
	text "Now that the stay-"
	line "at-home order is"
	cont "gone, it's time"
	cont "for field trips!"
	done

TeacherCeciliaBeatenText:
	text "… … …"
	done

TeacherCeciliaAfterBattleText:
	text "I like walking"
	line "around large"
	cont "bodies of water."
	done

SchoolboySawaraSeenText:
	text "I'm grateful to"
	line "my teacher for"
	cont "this trip!"
	done

SchoolboySawaraBeatenText:
	text "I'm still learning."
	done

SchoolboySawaraAfterBattleText:
	text "My brother GINKO…"

	para "He's weird since"
	line "the lockdown…"
	done

SchoolboyGinkoSeenText:
	text "RUN RUN RUN"
	line "RUN RUN RUN"
	done

SchoolboyGinkoBeatenText:
	text "*derp*"
	done

SailorClovisSeenText:
	text "I'm stuck here with"
	line "the S.S.AQUA."

	para "It's like a new"
	line "lockdown…"
	done

SailorClovisBeatenText:
	text "I just want to go"
	line "back to JOHTO…"
	done

SailorClovisAfterBattleText:
	text "Wait… Did I miss"
	line "the S.S.AQUA"
	cont "departure?"
	done

SailorStrandSeenText:
	text "Aaah, the horizon…"
	done

SailorStrandBeatenText:
	text "You're breaking my"
	line "peacefulness."
	done

SailorStrandAfterBattleText:
	text "I've visited many"
	line "places."

	para "Did you know the"
	line "pandemic barely"
	cont "hit the ONWA"
	cont "region?"
	done

Route12SignText:
	text "ROUTE 12"

	para "NORTH TO LAVENDER"
	line "TOWN"
	done

FishingSpotSignText:
	text "FISHING SPOT"
	done

Route12_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 65, ROUTE_12_SUPER_ROD_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 11, 51, BGEVENT_READ, Route12Sign
	bg_event 13,  9, BGEVENT_READ, FishingSpotSign
	bg_event 14, 23, BGEVENT_ITEM, Route12HiddenElixer

	def_object_events
	object_event  5, 23, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherMartin, -1
	object_event 14, 45, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherStephen, -1
	object_event  9, 70, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerFisherBarney, -1
	object_event  6,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherKyle, -1
	object_event  5, 77, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route12Calcium, EVENT_ROUTE_12_CALCIUM
	object_event  4, 86, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route12Nugget, EVENT_ROUTE_12_NUGGET
	object_event  5, 87, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route12FruitTree, -1
	object_event 12, 40, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerTeacherCecilia, -1
	object_event 15, 38, SPRITE_YOUNGSTER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSchoolboyGinko, -1
	object_event 15, 41, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerSchoolboySawara, -1
	object_event 10, 48, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSailorClovis, -1
	object_event 17,  9, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSailorStrand, -1
