	object_const_def
	const SEAFOAMW1F_BOULDER1
	const SEAFOAMW1F_BOULDER2
	const SEAFOAMW1F_BOULDER3
	const SEAFOAMW1F_BOULDER4

SeafoamW1F_MapScripts:
	def_scene_scripts

	def_callbacks 
	callback MAPCALLBACK_OBJECTS, .ClearRocks

.ClearRocks:
	clearevent EVENT_BROCK_BACK_IN_GYM

	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .endcallback

	setevent EVENT_CINNABAR_ROCKS_CLEARED
	readmem wKantoAddLevel
	addval 1
	writemem wKantoAddLevel
.endcallback
	endcallback

SeafoamW1FBoulder:
	jumpstd StrengthBoulderScript

SeafoamW1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 43, SEAFOAM_B1F, 1
	warp_event  3, 45, ROUTE_20, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5, 42, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamW1FBoulder, -1
	object_event  4, 43, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamW1FBoulder, -1
	object_event  4, 44, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamW1FBoulder, -1
	object_event  5, 45, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamW1FBoulder, -1
