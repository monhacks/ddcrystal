	object_const_def
	const ROUTE32_POLICE_1_1
	const ROUTE32_POLICE_1_2
	const ROUTE32_POLICE_1_3

	const ROUTE32_POLICE_2_1
	const ROUTE32_POLICE_2_2
	const ROUTE32_POLICE_2_3
	const ROUTE32_POLICE_2_4
	const ROUTE32_POLICE_2_5

	const ROUTE32_POLICE_3_1
	const ROUTE32_POLICE_3_2
	const ROUTE32_POLICE_3_3
	const ROUTE32_POLICE_3_4

	const ROUTE32_POLICE_4_1
	const ROUTE32_POLICE_4_2
	const ROUTE32_POLICE_4_3
	const ROUTE32_POLICE_4_4
	
	const ROUTE32_FISHER1
	const ROUTE32_FISHER2
	const ROUTE32_FISHER3
	const ROUTE32_YOUNGSTER1
	const ROUTE32_YOUNGSTER2
	const ROUTE32_YOUNGSTER3
	const ROUTE32_LASS1
	const ROUTE32_COOLTRAINER_M
	const ROUTE32_YOUNGSTER4
	const ROUTE32_FISHER4
	const ROUTE32_POKE_BALL1
	const ROUTE32_FISHER5
	const ROUTE32_FRIEDA
	const ROUTE32_POKE_BALL2

Route32_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Frieda

.Frieda:
	readvar VAR_WEEKDAY
	ifequal FRIDAY, .FriedaAppears
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; ROUTE32_FRIEDA
	endcallback

.FriedaAppears:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; ROUTE32_FRIEDA
	endcallback


	faceplayer
	end

Route32CooltrainerMStopsYouLeftScript:
	applymovement ROUTE32_COOLTRAINER_M, Route32_OneStepLeftMovement
Route32CooltrainerMStopsYouScript:
	setlasttalked ROUTE32_COOLTRAINER_M
Route32CooltrainerMScript:
	faceplayer
	opentext
	writetext Route32CooltrainerMText_WaitUp
	waitbutton
	closetext
	pause 2
	faceobject PLAYER, ROUTE32_COOLTRAINER_M
	pause 2
	opentext
	writetext Route32CooltrainerMText_YouNerd
	waitbutton
	closetext

	readvar VAR_YCOORD
	ifless 10, .player_talked_to_guy

	applymovement ROUTE32_COOLTRAINER_M, Movement_Route32CooltrainerMWalkUp3
	sjump .Route32_EndMovement

.player_talked_to_guy:
	applymovement ROUTE32_COOLTRAINER_M, Movement_Route32CooltrainerMLeftThenWalkUp3
	applymovement ROUTE32_COOLTRAINER_M, Movement_Route32CooltrainerMLeft4

.Route32_EndMovement:
	disappear ROUTE32_COOLTRAINER_M
	end

Route32RoarTMGuyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM05_ROAR
	iftrue .AlreadyHaveRoar
	writetext Text_RoarIntro
	promptbutton
	verbosegiveitem TM_ROAR
	iffalse .Finish
	setevent EVENT_GOT_TM05_ROAR
.AlreadyHaveRoar:
	writetext Text_RoarOutro
	waitbutton
.Finish:
	closetext
	end

Route32WannaBuyASlowpokeTailTopScript:
	applymovement ROUTE32_FISHER4, Movement_Route32CooltrainerMWalkUp

Route32WannaBuyASlowpokeTailScript:
	turnobject ROUTE32_FISHER4, DOWN
	turnobject PLAYER, UP
	sjump _OfferToSellSlowpokeTail

SlowpokeTailSalesmanScript:
	faceplayer
_OfferToSellSlowpokeTail:
	setevent EVENT_ROUTE_32_SLOWPOKE_TAIL
	opentext
	writetext Text_MillionDollarSlowpokeTail
	yesorno
	iffalse .refused
	writetext Text_ThoughtKidsWereLoaded
	waitbutton
	closetext
	readvar VAR_YCOORD
	ifequal 70, .Route32_FisherSlowpokeTailWalksDown
	end

.Route32_FisherSlowpokeTailWalksDown
	applymovement ROUTE32_FISHER4, Movement_Route32CooltrainerMReset1
	end

.refused
	writetext Text_RefusedToBuySlowpokeTail
	waitbutton
	closetext
	readvar VAR_YCOORD
	ifequal 70, .Route32_FisherSlowpokeTailWalksDown
	end

TrainerCamperRoland:
	trainer CAMPER, ROLAND, EVENT_BEAT_CAMPER_ROLAND, CamperRolandSeenText, CamperRolandBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperRolandAfterText
	waitbutton
	closetext
	end

TrainerFisherJustin:
	trainer FISHER, JUSTIN, EVENT_BEAT_FISHER_JUSTIN, FisherJustinSeenText, FisherJustinBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherJustinAfterText
	waitbutton
	closetext
	end

TrainerFisherRalph1:
	trainer FISHER, RALPH1, EVENT_BEAT_FISHER_RALPH, FisherRalph1SeenText, FisherRalph1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_FISHER_RALPH
	endifjustbattled
	opentext
	checkflag ENGINE_RALPH_READY_FOR_REMATCH
	iftrue .Rematch
	checkflag ENGINE_FISH_SWARM
	iftrue .Swarm
	checkcellnum PHONE_FISHER_RALPH
	iftrue .NumberAccepted
	checkevent EVENT_RALPH_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext FisherRalphAfterText
	promptbutton
	setevent EVENT_RALPH_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskAgain:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_FISHER_RALPH
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, FISHER, RALPH1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext FisherRalph1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_ECRUTEAK
	iftrue .LoadFight1
	loadtrainer FISHER, RALPH1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_RALPH_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer FISHER, RALPH2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_RALPH_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer FISHER, RALPH3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_RALPH_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer FISHER, RALPH4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_RALPH_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer FISHER, RALPH5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_RALPH_READY_FOR_REMATCH
	end

.Swarm:
	writetext FisherRalphSwarmText
	waitbutton
	closetext
	end

.AskNumber1:
	jumpstd AskNumber1MScript
	end

.AskNumber2:
	jumpstd AskNumber2MScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberMScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedMScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedMScript
	end

.PhoneFull:
	jumpstd PhoneFullMScript
	end

.RematchStd:
	jumpstd RematchMScript
	end

TrainerFisherHenry:
	trainer FISHER, HENRY, EVENT_BEAT_FISHER_HENRY, FisherHenrySeenText, FisherHenryBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherHenryAfterText
	waitbutton
	closetext
	end

TrainerPicnickerLiz1:
	trainer PICNICKER, LIZ1, EVENT_BEAT_PICNICKER_LIZ, PicnickerLiz1SeenText, PicnickerLiz1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_PICNICKER_LIZ
	endifjustbattled
	opentext
	checkflag ENGINE_LIZ_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_PICNICKER_LIZ
	iftrue .NumberAccepted
	checkevent EVENT_LIZ_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext PicnickerLiz1AfterText
	promptbutton
	setevent EVENT_LIZ_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskAgain:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_PICNICKER_LIZ
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, PICNICKER, LIZ1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext PicnickerLiz1BeatenText, 0
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight4
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_ECRUTEAK
	iftrue .LoadFight1
	loadtrainer PICNICKER, LIZ1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer PICNICKER, LIZ2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer PICNICKER, LIZ3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer PICNICKER, LIZ4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer PICNICKER, LIZ5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd AskNumber1FScript
	end

.AskNumber2:
	jumpstd AskNumber2FScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberFScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedFScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedFScript
	end

.PhoneFull:
	jumpstd PhoneFullFScript
	end

.RematchStd:
	jumpstd RematchFScript
	end

TrainerYoungsterAlbert:
	trainer YOUNGSTER, ALBERT, EVENT_BEAT_YOUNGSTER_ALBERT, YoungsterAlbertSeenText, YoungsterAlbertBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkitem HM_CUT
	iftrue .lockdown_announcement_was_made

	writetext YoungsterAlbertAfterText
	sjump .text_end

.lockdown_announcement_was_made
	writetext YoungsterAlbertAfterPostponedText
.text_end
	waitbutton
	closetext
	end

TrainerYoungsterGordon:
	trainer YOUNGSTER, GORDON, EVENT_BEAT_YOUNGSTER_GORDON, YoungsterGordonSeenText, YoungsterGordonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterGordonAfterText
	waitbutton
	closetext
	end

TrainerBirdKeeperPeter:
	trainer BIRD_KEEPER, PETER, EVENT_BEAT_BIRD_KEEPER_PETER, BirdKeeperPeterSeenText, BirdKeeperPeterBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperPeterAfterText
	waitbutton
	closetext
	end

FriedaScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	iftrue .Friday
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, .NotFriday
	checkevent EVENT_MET_FRIEDA_OF_FRIDAY
	iftrue .MetFrieda
	writetext MeetFriedaText
	promptbutton
	setevent EVENT_MET_FRIEDA_OF_FRIDAY
.MetFrieda:
	writetext FriedaGivesGiftText
	promptbutton
	verbosegiveitem POISON_BARB
	iffalse .Done
	setevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	writetext FriedaGaveGiftText
	waitbutton
	closetext
	end

.Friday:
	writetext FriedaFridayText
	waitbutton
.Done:
	closetext
	end

.NotFriday:
	writetext FriedaNotFridayText
	waitbutton
	closetext
	end

Route32GreatBall:
	itemball GREAT_BALL

Route32Repel:
	itemball REPEL

Route32Sign:
	jumptext Route32SignText

Route32RuinsSign:
	jumptext Route32RuinsSignText

Route32UnionCaveSign:
	jumptext Route32UnionCaveSignText

Route32PokecenterSign:
	jumpstd PokecenterSignScript

Route32HiddenGreatBall:
	hiddenitem GREAT_BALL, EVENT_ROUTE_32_HIDDEN_GREAT_BALL

Route32HiddenSuperPotion:
	hiddenitem SUPER_POTION, EVENT_ROUTE_32_HIDDEN_SUPER_POTION

Route32_OneStepLeftMovement:
	step LEFT
	step_end

Movement_Route32CooltrainerMLeft4:
	step UP
	step LEFT
	step LEFT
Movement_Route32CooltrainerMLeftThenWalkUp3:
	step LEFT
Movement_Route32CooltrainerMWalkUp3:
	step UP
	step UP
Movement_Route32CooltrainerMWalkUp:
	step UP
	step_end

Movement_Route32CooltrainerMReset1:
	step DOWN
	step_end

Route32CooltrainerMText_WaitUp:
	text "Wait up!"
	done

Route32CooltrainerMText_YouNerd:
	text "You are wearing"
	line "a face mask!"

	para "Are you afraid of"
	line "the propaganda"

	para "they spread in"
	line "the news?"

	para "Hahaha!"
	line "You're so gullible!"
	
	para "Hahahaha!"
	line "YOU NERD!"

	para "I gotta go tell"
	line "my friends!"
	done

Text_MillionDollarSlowpokeTail:
	text "Haven't you heard"
	line "on TV?"

	para "It's the end of"
	line "the world!"

	para "You better taste"
	line "some SLOWPOKETAIL"
	
	para "before it's"
	line "too late."

	para "For you right now,"
	line "just ¥1,000,000!"

	para "You'll want this!"
	done

Text_ThoughtKidsWereLoaded:
	text "Tch! I thought"
	line "kids these days"
	cont "were loaded…"
	done

Text_RefusedToBuySlowpokeTail:
	text "I gotta work on my"
	line "selling pitch…"
	done

FisherJustinSeenText:
	text "Whoa!"

	para "You made me lose"
	line "that fish!"
	done

FisherJustinBeatenText:
	text "Sploosh!"
	done

FisherJustinAfterText:
	text "Calm, collected…"
	line "The essence of"

	para "fishing and #-"
	line "MON is the same."
	done

FisherRalph1SeenText:
	text "I'm really good at"
	line "both fishing and"
	cont "#MON."

	para "I'm not about to"
	line "lose to any kid!"
	done

FisherRalph1BeatenText:
	text "Tch! I tried to"
	line "rush things…"
	done

FisherRalphAfterText:
	text "Fishing is a life-"
	line "long passion."

	para "#MON are life-"
	line "long friends!"
	done

FisherRalphSwarmText:
	text "One, two, three…"
	line "Muahahaha, what a"

	para "great haul!"
	line "I'm done! Go ahead"

	para "and catch as many"
	line "as you can, kid!"
	done

Route32UnusedFisher1SeenText: ; unreferenced
	text "I keep catching"
	line "the same #MON…"

	para "Maybe a battle"
	line "will turn things"
	cont "around for me."
	done

Route32UnusedFisher1BeatenText: ; unreferenced
	text "Nothing ever goes"
	line "right for me now…"
	done

Route32UnusedFisher1AfterText: ; unreferenced
	text "How come the guy"
	line "next to me catches"
	cont "good #MON?"
	done

Route32UnusedFisher2SeenText: ; unreferenced
	text "Heh, I'm on a roll"
	line "today. How about a"
	cont "battle, kid?"
	done

Route32UnusedFisher2BeatenText: ; unreferenced
	text "Oof. I wasn't"
	line "lucky that time."
	done

Route32UnusedFisher2AfterText: ; unreferenced
	text "You have to have a"
	line "good ROD if you"

	para "want to catch good"
	line "#MON."
	done

FisherHenrySeenText:
	text "My #MON?"
	line "Freshly caught!"
	done

FisherHenryBeatenText:
	text "SPLASH?"
	done

FisherHenryAfterText:
	text "Freshly caught"
	line "#MON are no"

	para "match for properly"
	line "raised ones."
	done

YoungsterAlbertSeenText:
	text "I love sports!"
	line "Let's spar!"
	done

YoungsterAlbertBeatenText:
	text "You're strong!"
	done

YoungsterAlbertAfterText:
	text "I bought tickets"
	line "for the #ATHLON"
	cont "that'll take place"
	cont "in GOLDENROD CITY"
	cont "in a few months!"
	done

YoungsterAlbertAfterPostponedText:
	text "The #ATHLON has"
	line "been postponed"
	cont "indefinitely."
	cont "I'm devastated."
	done

YoungsterGordonSeenText:
	text "I found some good"
	line "#MON in the"
	cont "grass!"

	para "I think they'll do"
	line "it for me!"
	done

YoungsterGordonBeatenText:
	text "Darn. I thought I"
	line "could win."
	done

YoungsterGordonAfterText:
	text "The grass is full"
	line "of clingy things."
	done

CamperRolandSeenText:
	text "That glance…"
	line "It's intriguing."
	done

CamperRolandBeatenText:
	text "Hmmm. This is"
	line "disappointing."
	done

CamperRolandAfterText:
	text "If you don't want"
	line "to battle, just"
	cont "avoid eye contact."
	done

PicnickerLiz1SeenText:
	text "Uh-huh. Yeah, and"
	line "you know…"

	para "Pardon? Battle?"
	line "I'm on the phone."

	para "Oh, all right. But"
	line "make it fast."
	done

PicnickerLiz1BeatenText:
	text "Oh! I've got to"
	line "relieve my anger!"
	done

PicnickerLiz1AfterText:
	text "I was having a"
	line "nice chat too."
	done

BirdKeeperPeterSeenText:
	text "Have you beaten"
	line "FALKNER from"
	cont "VIOLET CITY?"
	done

BirdKeeperPeterBeatenText:
	text "I know what my"
	line "weaknesses are."
	done

BirdKeeperPeterAfterText:
	text "I should train"
	line "again at the GYM"
	cont "in VIOLET CITY."
	done

Route32UnusedText: ; unreferenced
	text "The fishermen"
	line "yelled at me for"
	cont "bugging them…"
	done

Text_RoarIntro:
	text "WROOOOAR!"
	line "PEOPLE RUN WHEN I"

	para "ROAR! BUT YOU"
	line "CAME LOOKING!"

	para "THAT PLEASES ME!"
	line "NOW TAKE THIS!"
	done

Text_RoarOutro:
	text "WROOOAR!"
	line "IT'S ROAR!"

	para "EVEN #MON RUN"
	line "FROM A GOOD ROAR!"
	done

MeetFriedaText:
	text "FRIEDA: Yahoo!"
	line "It's Friday!"

	para "I'm FRIEDA of"
	line "Friday!"

	para "Nice to meet you!"
	done

FriedaGivesGiftText:
	text "Here's a POISON"
	line "BARB for you!"
	done

FriedaGaveGiftText:
	text "FRIEDA: Give it to"
	line "a #MON that has"
	cont "poison-type moves."

	para "Oh!"

	para "It's wicked!"

	para "You'll be shocked"
	line "how good it makes"
	cont "poison moves!"
	done

FriedaFridayText:
	text "FRIEDA: Hiya! What"
	line "day do you like?"

	para "I love Friday. No"
	line "doubt about it!"

	para "Don't you think"
	line "it's great too?"
	done

FriedaNotFridayText:
	text "FRIEDA: Isn't it"
	line "Friday today?"

	para "It's so boring"
	line "when it's not!"
	done

Route32SignText:
	text "ROUTE 32"

	para "VIOLET CITY -"
	line "AZALEA TOWN"
	done

Route32RuinsSignText:
	text "RUINS OF ALPH"
	line "EAST ENTRANCE"
	done

Route32UnionCaveSignText:
	text "UNION CAVE"
	line "AHEAD"
	done

Route32_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 73, ROUTE_32_POKECENTER_1F, 1
	warp_event  4,  2, ROUTE_32_RUINS_OF_ALPH_GATE, 3
	warp_event  4,  3, ROUTE_32_RUINS_OF_ALPH_GATE, 4
	warp_event  6, 79, UNION_CAVE_1F, 4

	def_coord_events
	coord_event 18, 10, CE_EVENT_FLAG_CLEARED, EVENT_GOT_MOCKED_ON_ROUTE_32, Route32CooltrainerMStopsYouLeftScript
	coord_event 19, 10, CE_EVENT_FLAG_CLEARED, EVENT_GOT_MOCKED_ON_ROUTE_32, Route32CooltrainerMStopsYouScript
	coord_event  6, 70, CE_EVENT_FLAG_CLEARED, EVENT_ROUTE_32_SLOWPOKE_TAIL, Route32WannaBuyASlowpokeTailTopScript
	coord_event  6, 71, CE_EVENT_FLAG_CLEARED, EVENT_ROUTE_32_SLOWPOKE_TAIL, Route32WannaBuyASlowpokeTailScript

	def_bg_events
	bg_event 13,  5, BGEVENT_READ, Route32Sign
	bg_event  9,  1, BGEVENT_READ, Route32RuinsSign
	bg_event 10, 84, BGEVENT_READ, Route32UnionCaveSign
	bg_event 12, 73, BGEVENT_READ, Route32PokecenterSign
	bg_event 12, 67, BGEVENT_ITEM, Route32HiddenGreatBall
	bg_event 11, 40, BGEVENT_ITEM, Route32HiddenSuperPotion

	def_object_events
	object_event  2, 47, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 11, 51, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event  5, 33, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	
	object_event 12, 22, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  3, 60, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  5, 68, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  7, 83, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 19, 13, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1

	object_event  9, 74, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 18, 10, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1
	object_event 11, 12, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 11, 47, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_Y, 0, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event  0, 54, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1
	object_event 11, 77, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 1, 2, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  5, 38, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 14,  5, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 3, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event  8, 49, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherJustin, -1
	object_event 12, 56, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherRalph1, -1
	object_event  6, 48, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherHenry, -1
	object_event 12, 22, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterAlbert, -1
	object_event  4, 63, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterGordon, -1
	object_event  3, 45, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerCamperRoland, -1
	object_event 10, 30, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerPicnickerLiz1, -1
	object_event 19,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, Route32CooltrainerMScript, EVENT_GOT_MOCKED_ON_ROUTE_32
	object_event 11, 82, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperPeter, -1
	object_event  6, 69, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeTailSalesmanScript, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  6, 53, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route32GreatBall, EVENT_ROUTE_32_GREAT_BALL
	object_event 15, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, Route32RoarTMGuyScript, -1
	object_event 12, 67, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, FriedaScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  3, 30, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route32Repel, EVENT_ROUTE_32_REPEL
