	object_const_def
	const VIRIDIANNICKNAMESPEECHHOUSE_POKEFAN_M
	const VIRIDIANNICKNAMESPEECHHOUSE_TWIN
	const VIRIDIANNICKNAMESPEECHHOUSE_PRIMEAPE
	const VIRIDIANNICKNAMESPEECHHOUSE_SCARF_THE_FURRET

ViridianNicknameSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianNicknameSpeechHousePokefanMScript:
	faceplayer
	opentext
	writetext ViridianNicknameSpeechHousePokefanMText
	waitbutton
	closetext
	turnobject VIRIDIANNICKNAMESPEECHHOUSE_POKEFAN_M, UP
	end

ViridianNicknameSpeechHouseTwinScript:
	checkevent EVENT_LANA_GAVE_VOUCHER
	iftrue .voucher_given

	checkevent EVENT_CROWD_IN_VACCINATION_CENTER
	iftrue .before_center_opening

	faceplayer
	opentext

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .go

	checkevent EVENT_LANAS_FURRET_WAS_RETURNED
	iftrue .give_voucher

	checkevent EVENT_LANAS_FURRET_GIVEN_TO_PLAYER
	iftrue .check_on_scarf
	
	writetext ViridianNicknameSpeechHouseTwin_AskForVaccineText
	yesorno
	iffalse .refused

	readvar VAR_PARTYCOUNT
	ifgreater 5, .party_full

	givepoke FURRET, 37, BERRY, TRUE, .mon_name, .mon_OT_name
	disappear VIRIDIANNICKNAMESPEECHHOUSE_SCARF_THE_FURRET ; Sets EVENT_LANAS_FURRET_GIVEN_TO_PLAYER.
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.go
	writetext ViridianNicknameSpeechHouseTwin_GoText
	sjump .text_end

.before_center_opening
	jumptextfaceplayer ViridianNicknameSpeechHouseTwin_BeforeOpeningText

.voucher_given
	jumptextfaceplayer ViridianNicknameSpeechHouseTwin_VoucherGivenText

.party_full
	farwritetext MountMortarB1FKiyoFullPartyText
	sjump .text_end

.refused
	writetext ViridianNicknameSpeechHouseTwin_RefusesText
.text_end
	waitbutton
.close_text
	closetext
	end

.check_on_scarf
	writetext ViridianNicknameSpeechHouseTwin_CheckingOnFurretText
	waitbutton
	farwritetext GoldenrodCityMoveTutorMoveText
	callasm SelectScarfTheVaccinatedFurret
	ifequal -1, .cancelled_check
	ifequal 1, .mission_accomplished
	ifequal 3, .not_vaccinated

.wrong_pokemon
	writetext ViridianNicknameSpeechHouseTwin_WrongPokemonText
	promptbutton
.cancelled_check
	writetext ViridianNicknameSpeechHouseTwin_CancelledCheckText
	sjump .text_end

.not_vaccinated
	writetext ViridianNicknameSpeechHouseTwin_NotVaccinatedYetText
	sjump .text_end

.no_room_for_item
	farwritetext BeverlyPackFullText
	sjump .text_end

.mission_accomplished
	callasm DepositCurPartyMon
	appear VIRIDIANNICKNAMESPEECHHOUSE_SCARF_THE_FURRET
	reloadmappart
	writetext ViridianNicknameSpeechHouseTwin_ThanksText
	promptbutton
	setevent EVENT_LANAS_FURRET_WAS_RETURNED
.give_voucher
	writetext ViridianNicknameSpeechHouseTwin_GiveVoucherText
	promptbutton
	verbosegiveitem VOUCHER
	iffalse .no_room_for_item

	setevent EVENT_LANA_GAVE_VOUCHER
	sjump .close_text

.mon_name:
	db "SCARF@"

.mon_OT_name:
	db "LANA@"

ViridianPrimeapeScript:
	opentext
	writetext ViridianPrimeapeText
	cry PRIMEAPE
	waitbutton
	closetext
	end

ViridianScarfScript:
	opentext
	writetext ViridianScarfText
	cry FURRET
	waitbutton
	closetext
	end

ViridianNicknameSpeechHousePokefanMText:
	text "Trust me--no one"
	line "in this family"
	
	para "will get injected"
	line "with the poison"
	cont "they call vaccine."

	para "We're no test"
	line "subjects!"
	done

ViridianNicknameSpeechHouseTwin_BeforeOpeningText:
	text "A #MON"
	line "vaccination center"
	
	para "is about to open"
	line "in SAFFRON CITY."

	para "When it does, pay"
	line "me a visit."
	done

ViridianNicknameSpeechHouseTwin_AskForVaccineText:
	text "My dad is a pure"
	line "antivaxxer breed."

	para "He won't take me"
	line "to SAFFRON CITY,"
	
	para "so I can't get my"
	line "FURRET vaccinated…"

	para "Could you get my"
	line "#MON vaccinated"
	cont "discreetly?"
	done

ViridianNicknameSpeechHouseTwin_RefusesText:
	text "You're my only way"
	line "out of this"
	cont "prison. I'm"
	cont "begging you…"
	done

ViridianNicknameSpeechHouseTwin_GoText:
	text "Now go before"
	line "daddy notices!"
	done

ViridianNicknameSpeechHouseTwin_CheckingOnFurretText:
	text "How is it going"
	line "with SCARF's"
	cont "vaccination?"
	cont "Can I get it back?"
	done

ViridianNicknameSpeechHouseTwin_CancelledCheckText:
	text "Where's my FURRET?"
	done

ViridianNicknameSpeechHouseTwin_WrongPokemonText:
	text "Hey this isn't"
	line "my FURRET!"
	done

ViridianNicknameSpeechHouseTwin_NotVaccinatedYetText:
	text "It's not vaccinated"
	line "yet. Please do it"
	cont "for me…"
	done

ViridianNicknameSpeechHouseTwin_ThanksText:
	text "I'm so relieved!"
	line "Thanks!"
	done

ViridianNicknameSpeechHouseTwin_GiveVoucherText:
	text "As I can't go to"
	line "SAFFRON CITY, I"
	cont "can't redeem this"
	cont "VOUCHER."
	
	para "I can't let it"
	line "go to waste."
	cont "You deserve it."
	done

ViridianNicknameSpeechHouseTwin_VoucherGivenText:
	text "Thanks for doing"
	line "your part against"
	cont "COVID, soldier."

	para "Hopefully SCARF"
	line "never gets sick."
	done

ViridianPrimeapeText:
	text "JAPE PAUL: Pooool!"
	done

ViridianScarfText:
	text "SCARF: FUUUUUU-"
	done

ViridianNicknameSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, VIRIDIAN_CITY, 2
	warp_event  3,  7, VIRIDIAN_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianNicknameSpeechHousePokefanMScript, -1
	object_event  5,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ViridianNicknameSpeechHouseTwinScript, -1
	object_event  5,  2, SPRITE_PRIMEAPE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ViridianPrimeapeScript, -1
	object_event  6,  3, SPRITE_FURRET, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ViridianScarfScript, EVENT_LANAS_FURRET_GIVEN_TO_PLAYER
