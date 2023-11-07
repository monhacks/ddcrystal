	object_const_def
	const PLAYERSHOUSE1F_MOM1
	const PLAYERSHOUSE1F_MOM2
	const PLAYERSHOUSE1F_MOM3
	const PLAYERSHOUSE1F_MOM4
	const PLAYERSHOUSE1F_POKEFAN_F
	const PLAYERSHOUSE1F_WALL

PlayersHouse1F_MapScripts:
	def_scene_scripts

	def_callbacks

MeetMomLeftScript:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

MeetMomRightScript:
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iftrue MeetMomScript.end

	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYER, LEFT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .OnRight
	applymovement PLAYERSHOUSE1F_MOM1, MomTurnsTowardPlayerMovement
	sjump MeetMomScript

.OnRight:
	applymovement PLAYERSHOUSE1F_MOM1, MomWalksToPlayerMovement
MeetMomScript:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	opentext
	writetext ElmsLookingForYouText
	promptbutton
	getstring STRING_BUFFER_4, PokegearName
	scall PlayersHouse1FReceiveItemStd
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	writetext MomGivesPokegearText
	promptbutton
	special SetDayOfWeek
.SetDayOfWeek:
	writetext IsItDSTText
	yesorno
	iffalse .WrongDay
	special InitialSetDSTFlag
	yesorno
	iffalse .SetDayOfWeek
	sjump .DayOfWeekDone

.WrongDay:
	special InitialClearDSTFlag
	yesorno
	iffalse .SetDayOfWeek
.DayOfWeekDone:
	writetext ComeHomeForDSTText
	yesorno
	iffalse .ExplainPhone
	sjump .KnowPhone

.KnowPhone:
	writetext KnowTheInstructionsText
	promptbutton
	sjump .FinishPhoneForReal

.ExplainPhone:
	writetext DontKnowTheInstructionsText
	promptbutton
	sjump .FinishPhone

.FinishPhone:
	writetext InstructionsNextText
	promptbutton
.FinishPhoneForReal:
	writetext CovidIntroText
	waitbutton
	closetext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .FromRight
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iffalse .FromLeft
	sjump .Finish

.FromRight:
	applymovement PLAYERSHOUSE1F_MOM1, MomTurnsBackMovement
	sjump .Finish

.FromLeft:
	applymovement PLAYERSHOUSE1F_MOM1, MomWalksBackMovement
	sjump .Finish

.Finish:
	special RestartMapMusic
	turnobject PLAYERSHOUSE1F_MOM1, LEFT
.end
	end

MeetMomTalkedScript:
	playmusic MUSIC_MOM
	sjump MeetMomScript

PokegearName:
	db "#GEAR@"

PlayersHouse1FReceiveItemStd:
	jumpstd ReceiveItemScript
	end

FakeMomMornScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; If the player has never ever left the house (new game).
	iftrue .quit
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse .quit
	checktime MORN
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM2
	sjump FakeMomScript
	end
.quit:
	opentext
	writetext SmellText
	promptbutton
	closetext
	end

FakeMomDayScript:
	checkevent EVENT_PLAYERS_HOUSE_MOM_1 ; If the player has never ever talked to Mom (new game).
	iffalse .meet
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; If the player has never ever left the house (new game).
	iftrue .firstMom
	checktime DAY
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM3
	sjump FakeMomScript
	end
.firstMom:
	setlasttalked PLAYERSHOUSE1F_MOM1
	sjump FakeMomScript
.meet
	setlasttalked PLAYERSHOUSE1F_MOM1
	sjump MomScript
	end
.quit:
	opentext
	writetext MomsSeatText
	promptbutton
	closetext
	end

FakeMomNiteScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3 ; If the player has never ever left the house (new game).
	iftrue .quit
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse .quit
	checktime NITE
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM4
	sjump FakeMomScript
	end
.quit:
	opentext
	writetext SmellText
	promptbutton
	closetext
	end

FakeMomScript:
	showemote EMOTE_QUESTION, LAST_TALKED, 15
	faceplayer
	opentext
	writetext SocialDistancingText
	promptbutton
	closetext
	readvar VAR_FACING
	ifequal DOWN, .down
	ifequal UP, .up
	ifequal LEFT, .left
	ifequal RIGHT, .right
	end

.left:
	applymovement PLAYER, RightBackStepMovement
	sjump .congrats
	end

.right:
	applymovement PLAYER, LeftBackStepMovement
	sjump .congrats
	end

.up:
	applymovement PLAYER, DownBackStepMovement
	sjump .congrats
	end

.down:
	applymovement PLAYER, UpBackStepMovement
	sjump .congrats
	end

.congrats:
	showemote EMOTE_HAPPY, LAST_TALKED, 20
	opentext 
	writetext NowWeCanTalkText
	waitbutton
	closetext
	pause 5
	sjump MomScript
	end

RightBackStepMovement:
	fix_facing
	step RIGHT
	remove_fixed_facing
	step_end

LeftBackStepMovement:
	fix_facing
	step LEFT
	remove_fixed_facing
	step_end

DownBackStepMovement:
	fix_facing
	step DOWN
	remove_fixed_facing
	step_end

UpBackStepMovement:
	fix_facing
	step UP
	remove_fixed_facing
	step_end

FakeNeighborScript:
	checkevent EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
	iftrue .quit
	setlasttalked PLAYERSHOUSE1F_POKEFAN_F
	sjump NeighborScript
	end
.quit:
	opentext
	writetext PlayerSeatText
	promptbutton
	closetext
	readvar VAR_FACING
	ifequal DOWN, .down
	ifequal UP, .up
	ifequal LEFT, .left
	ifequal RIGHT, .right
	end

.left:
	applymovement PLAYER, LeftStepMovement
	sjump .watch_tv
	end

.right:
	applymovement PLAYER, RightStepMovement
	sjump .watch_tv
	end

.up:
	applymovement PLAYER, UpStepMovement
	sjump .watch_tv
	end

.down:
	applymovement PLAYER, DownStepMovement
	sjump .watch_tv
	end

.watch_tv:
	callstd TVScript
	end

RightStepMovement:
	step RIGHT
	turn_head UP
	step_end

LeftStepMovement:
	step LEFT
	turn_head UP
	step_end

DownStepMovement:
	step DOWN
	turn_head UP
	step_end

UpStepMovement:
	step UP
	step_end

WallScript:
	opentext
	writetext SocialDistancingText
	promptbutton
	closetext
	end

MomScript:
	faceplayer
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse MeetMomTalkedScript
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue .FirstTimeBanking
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .BankOfMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .GaveMysteryEgg
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .GotAPokemon
	writetext HurryUpElmIsWaitingText
	waitbutton
	closetext
	end

.GotAPokemon:
	writetext SoWhatWasProfElmsErrandText
	waitbutton
	closetext
	end

.FirstTimeBanking:
	writetext ImBehindYouText
	waitbutton
	closetext
	end

.GaveMysteryEgg:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	;setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special BankOfMom
	waitbutton
	closetext
	end

NeighborScript:
	faceplayer
	opentext
	checktime MORN
	iftrue .MornScript
	checktime DAY
	iftrue .DayScript
	checktime NITE
	iftrue .NiteScript

.MornScript:
	writetext NeighborMornIntroText
	promptbutton
	sjump .Main

.DayScript:
	writetext NeighborDayIntroText
	promptbutton
	sjump .Main

.NiteScript:
	writetext NeighborNiteIntroText
	promptbutton
	sjump .Main

.Main:
	writetext NeighborText
	waitbutton
	closetext
	end

PlayersHouse1FStoveScript:
	jumptext PlayersHouse1FStoveText

PlayersHouse1FSinkScript:
	jumptext PlayersHouse1FSinkText

PlayersHouse1FFridgeScript:
	checkflag ENGINE_TOOK_DRINK_FROM_FRIDGE
	iftrue .AlreadyTookDrinkToday
	checkevent EVENT_GOT_HM05_FLASH
	iffalse .DrinksOnTheHouse
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .EmptyFridge
	checkmoney MOMS_MONEY, 150
	ifequal HAVE_LESS, .EmptyFridge
.DrinksOnTheHouse:
	opentext
	writetext PlayersHouse1FFridgeText
	yesorno
	iftrue .TakeFreshWater
	writetext AskLemonadeFridgeText
	yesorno
	iftrue .TakeLemonade
	closetext
	end

.EmptyFridge:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	jumptext EmptyFridgeText

.TakeFreshWater:
	checkevent EVENT_GOT_HM05_FLASH
	iffalse .FridgeFreeFreshWater
	takemoney MOMS_MONEY, 50
.FridgeFreeFreshWater:
	setflag ENGINE_TOOK_DRINK_FROM_FRIDGE
	verbosegiveitem FRESH_WATER
	closetext
	end

.TakeLemonade:
	checkevent EVENT_GOT_HM05_FLASH
	iffalse .FridgeFreeLemonade
	takemoney MOMS_MONEY, 150
.FridgeFreeLemonade:
	setflag ENGINE_TOOK_DRINK_FROM_FRIDGE
	verbosegiveitem LEMONADE
	closetext
	end

.AlreadyTookDrinkToday:
	jumptext OtherDrinkIsForMomText

MomTurnsTowardPlayerMovement:
	turn_head RIGHT
	step_end

MomWalksToPlayerMovement:
	slow_step RIGHT
	step_end

MomTurnsBackMovement:
	turn_head LEFT
	step_end

MomWalksBackMovement:
	slow_step LEFT
	step_end

SmellText:
	text "Smells good!"
	line "Mom's a good cook!"
	done

PlayerSeatText:
	text "This is my seat"
	line "at the table."

	para "It has the best"
	line "view on the TV!"
	done

MomsSeatText:
	text "Mom's seat has"
	line "lovely cushions."
	done

SocialDistancingText:
	text "<PLAYER> remember"
	line "to keep 1 step of"
	cont "social distancing."
	done

ElmsLookingForYouText:
	text "Oh, <PLAYER>…! Our"
	line "neighbor, PROF."

	para "ELM, was looking"
	line "for you."

	para "He said he wanted"
	line "you to do some-"
	cont "thing for him."

	para "Oh! I almost for-"
	line "got! Your #MON"

	para "GEAR is back from"
	line "the repair shop."

	para "Here you go!"
	done

MomGivesPokegearText:
	text "#MON GEAR, or"
	line "just #GEAR."

	para "It's essential if"
	line "you want to be a"
	cont "good trainer."

	para "Oh, the day of the"
	line "week isn't set."

	para "You mustn't forget"
	line "that!"
	done

IsItDSTText:
	text "Is it Daylight"
	line "Saving Time now?"
	done

ComeHomeForDSTText:
	text "Come home to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time."

	para "By the way, do you"
	line "know how to use"
	cont "the PHONE?"
	done

KnowTheInstructionsText:
	text "Great!"
	done

DontKnowTheInstructionsText:
	text "I'll read the"
	line "instructions."

	para "Turn the #GEAR"
	line "on and select the"
	cont "PHONE icon."
	done

InstructionsNextText:
	text "Phone numbers are"
	line "stored in memory."

	para "Just choose a name"
	line "you want to call."

	para "Gee, isn't that"
	line "convenient?"
	done

CovidIntroText:
	text "One last thing!"
	line "They are talking"
	cont "about a new virus"
	cont "in the news."

	para "Doctors on TV"
	line "recommended to"
	cont "stay 1 step away"
	cont "when talking to"
	cont "someone."

	para "Now people may not"
	line "want to talk to"
	cont "you if you do not"
	cont "respect this rule."

	para "Be careful"
	line "out there!"
	done

HurryUpElmIsWaitingText:
	text "PROF.ELM is wait-"
	line "ing for you."

	para "Hurry up, baby!"
	done

SoWhatWasProfElmsErrandText:
	text "So, what was PROF."
	line "ELM's errand?"

	para "…"

	para "That does sound"
	line "challenging."

	para "But, you should be"
	line "proud that people"
	cont "rely on you."
	done

ImBehindYouText:
	text "<PLAYER>, do it!"

	para "I'm behind you all"
	line "the way!"
	done

NeighborMornIntroText:
	text "Good morning,"
	line "<PLAY_G>!"

	para "I'm visiting!"
	done

NeighborDayIntroText:
	text "Hello, <PLAY_G>!"
	line "I'm visiting!"
	done

NeighborNiteIntroText:
	text "Good evening,"
	line "<PLAY_G>!"

	para "I'm visiting!"
	done

NeighborText:
	text "Have you heard?"
	line "Some people caught"

	para "a virus never seen"
	line "before."

	para "Nothing to worry"
	line "about, I'm sure"
	cont "we will be fine!"
	done

PlayersHouse1FStoveText:
	text "Mom's specialty!"

	para "CIANWOOD WHIRL"
	line "MAKIS!"
	done

PlayersHouse1FSinkText:
	text "The sink is spot-"
	line "less. MOM likes it"
	cont "clean."
	done

EmptyFridgeText:
	text "It's empty…"

	para "Maybe MOM doesn't"
	line "have enough money"
	cont "to do groceries?"
	done

PlayersHouse1FFridgeText:
	text "Let's see what's"
	line "in the fridge…"

	para "FRESH WATER and"
	line "tasty MILK TEA!"

	para "Take the FRESH"
	line "WATER?"
	done

AskLemonadeFridgeText:
	text "Take the MILK"
	line "TEA?"
	done

OtherDrinkIsForMomText:
	text "The other drink"
	line "is for MOM."
	done

NowWeCanTalkText:
	text "Perfect!"
	line "Now we can talk!"
	done

PlayersHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  7, NEW_BARK_TOWN, 2
	warp_event  7,  7, NEW_BARK_TOWN, 2
	warp_event  9,  0, PLAYERS_HOUSE_2F, 1

	def_coord_events
	coord_event  8,  4, CE_SCENE_ID, SCENE_ALWAYS, MeetMomLeftScript
	coord_event  9,  4, CE_SCENE_ID, SCENE_ALWAYS, MeetMomRightScript

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PlayersHouse1FStoveScript
	bg_event  1,  1, BGEVENT_READ, PlayersHouse1FSinkScript
	bg_event  2,  1, BGEVENT_READ, PlayersHouse1FFridgeScript
	bg_event  2,  2, BGEVENT_READ, FakeMomMornScript
	bg_event  7,  4, BGEVENT_READ, FakeMomDayScript
	bg_event  0,  2, BGEVENT_READ, FakeMomNiteScript
	bg_event  4,  4, BGEVENT_READ, FakeNeighborScript

	def_object_events
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_1
	object_event  2,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  0,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, NITE, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  4,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, NeighborScript, EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
