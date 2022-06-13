	object_const_def
	const CELADONCAFE_SUPER_NERD
	const CELADONCAFE_FISHER1
	const CELADONCAFE_FISHER2
	const CELADONCAFE_FISHER3
	const CELADONCAFE_TEACHER

CeladonCafe_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonCafeChef:
	faceplayer
	opentext
	writetext ChefText_Eatathon
	waitbutton
	closetext
	end

CeladonCafeFisher1:
	opentext
	writetext Fisher1Text_Snarfle
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher1Text_Concentration
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER1, LEFT
	end

CeladonCafeFisher2:
	opentext
	writetext Fisher2Text_GulpChew
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher2Text_Quantity
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER2, RIGHT
	end

CeladonCafeFisher3:
	opentext
	writetext Fisher3Text_MunchMunch
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher3Text_GoldenrodIsBest
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER3, RIGHT
	end

CeladonCafeTeacher:
	checkitem COIN_CASE
	iftrue .HasCoinCase
	opentext
	writetext TeacherText_CrunchCrunch
	waitbutton
	closetext
	faceplayer
	opentext
	writetext TeacherText_NoCoinCase
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, LEFT
	end

.HasCoinCase:
	opentext
	writetext TeacherText_KeepEating
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, RIGHT
	opentext
	writetext TeacherText_MoreChef
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, LEFT
	end

EatathonContestPoster:
	jumptext EatathonContestPosterText

CeladonCafeTrashcan:
	jumptext FoundLeftoversText
	end

ChefText_Eatathon:
	text "Hi!"

	para "We're full at the"
	line "moment, please"
	cont "wait outside."

	done

Fisher1Text_Snarfle:
	text "…Snarfle, chew…"
	done

Fisher1Text_Concentration:
	text "I can't cook so"
	line "I've been eating"
	cont "frozen meals dur-"
	cont "ing the several"
	cont "months of the"
	cont "lockdown."
	
	para "I've been missing"
	line "restaurants so"
	cont "much!"

	done

Fisher2Text_GulpChew:
	text "…Gulp… Chew…"
	done

Fisher2Text_Quantity:
	text "Don't talk to me,"
	line "I'm not wearing"
	cont "a face mask!"
	done

Fisher3Text_MunchMunch:
	text "Munch, munch…"
	done

Fisher3Text_GoldenrodIsBest:
	text "I forgot that I"
	line "lost the sense of"
	cont "taste and smell…"

	para "This is so"
	line "frustrating!"

	para "Eating was every-"
	line "thing to me…"
	done

TeacherText_CrunchCrunch:
	text "Crunch… Crunch…"
	done

TeacherText_NoCoinCase:
	text "Nobody here will"
	line "give you a COIN"

	para "CASE. You should"
	line "look in JOHTO."
	done

TeacherText_KeepEating:
	text "Crunch… Crunch…"

	para "I can keep eating!"
	done

TeacherText_MoreChef:
	text "More, CHEF!"
	done

EatathonContestPosterText:
	text "SANITARY RULES:"

	para "- Wait in the"
	line "entrance and wait"
	cont "for your vacci-"
	cont "nation pass check."

	para "- Wear your face"
	line "mask at all times"
	cont "unless you are"
	cont "seated."

	para "- Wash your hands"
	line "when entering."

	para "- Tables have been"
	line "spaced out. Do"
	cont "not move them."

	para "- We are allowed"
	line "a fourth of our"
	cont "maximum capacity."
	cont "Sorry for the"
	cont "inconvenience."

	para "- Leave one seat"
	line "free between you"
	cont "and the next"
	cont "person, and don't"
	cont "seat in front of"
	cont "someone else."
	
	para "- No paper menu:"
	line "scan the code with" 
	cont "your #GEAR to"
	cont "access the digital"
	cont "menu."

	para "- After using the"
	line "toilets, clean"
	cont "everything with"
	cont "the provided"
	cont "cleaning wipes."

	para "- Cash payment"
	line "prohibited. Only"
	cont "contactless pay-"
	cont "ments accepted."

	done

FoundLeftoversText:
	text "<PLAYER> found"
	line "NOTHING!"

	para "This trashcan is"
	line "super duper clean."

	para "This restaurant"
	line "looks to be very"
	cont "serious about the"
	cont "sanitary protocol."
	done

CeladonCafe_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  7, CELADON_CITY, 9
	warp_event  7,  7, CELADON_CITY, 9

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_READ, EatathonContestPoster
	bg_event  7,  1, BGEVENT_READ, CeladonCafeTrashcan

	def_object_events
	object_event  9,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CeladonCafeChef, -1
	object_event  4,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher1, -1
	object_event  1,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher2, -1
	object_event  1,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher3, -1
	object_event  4,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeTeacher, -1
