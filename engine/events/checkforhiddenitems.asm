CheckForHiddenItems:
	ld a, -1
	ld [wItemFinderDistance], a
; Checks to see if there are hidden items on the screen that have not yet been found.  If it finds one, returns carry.
	call GetMapScriptsBank
	ld [wCurMapScriptBank], a
; Get the coordinate of the bottom right corner of the screen, and load it in wBottomRightYCoord/wBottomRightXCoord.
	ld a, [wXCoord]
	add SCREEN_WIDTH / 4
	ld [wBottomRightXCoord], a
	ld a, [wYCoord]
	add SCREEN_HEIGHT / 4
	ld [wBottomRightYCoord], a
; Get the pointer for the first bg_event in the map...
	ld hl, wCurMapBGEventsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
; ... before even checking to see if there are any BG events on this map.
	ld a, [wCurMapBGEventCount]
	and a
	jr z, .nobgeventitems
; For i = 1:wCurMapBGEventCount...
.loop
; Store the counter in wRemainingBGEventCount, and store the bg_event pointer in the stack.
	ld [wRemainingBGEventCount], a
	push hl
; Get the Y coordinate of the BG event.
	call .GetFarByte
	ld e, a
; Is the Y coordinate of the BG event on the screen?  If not, go to the next BG event.
	ld a, [wBottomRightYCoord]
	sub e
	jr c, .next
	cp SCREEN_HEIGHT / 2
	jr nc, .next
; Is the X coordinate of the BG event on the screen?  If not, go to the next BG event.
	call .GetFarByte
	ld d, a
	ld a, [wBottomRightXCoord]
	sub d
	jr c, .next
	cp SCREEN_WIDTH / 2
	jr nc, .next
; Is this BG event a hidden item?  If not, go to the next BG event.
	call .GetFarByte
	cp BGEVENT_ITEM
	jr nz, .next
; Has this item already been found?  If not, set off the Itemfinder.
	ld a, [wCurMapScriptBank]
	call GetFarWord
	ld a, [wCurMapScriptBank]
	call GetFarWord
	push de ; We save the items coords.
	ld d, h
	ld e, l
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	pop de
	and a
	jr z, .itemnearby

.next
; Restore the bg_event pointer and increment it by the length of a bg_event.
	pop hl
	ld bc, BG_EVENT_SIZE
	add hl, bc
; Restore the BG event counter and decrement it.  If it hits zero, there are no hidden items in range.
	ld a, [wRemainingBGEventCount]
	dec a
	jr nz, .loop

; If the distance isn't -1, it means we have found an item.
	ld a, [wItemFinderDistance]
	cp -1
	jr nz, .itemnearby_no_pop

.nobgeventitems
	xor a
	ret

.itemnearby
	; Measure the distance to the item.
	ld a, [wXCoord]
	sub d
	bit 7, a
	jr z, .x_is_positive

	cpl
	inc a
.x_is_positive
	ld d, a

	ld a, [wYCoord]
	sub e
	bit 7, a
	jr z, .y_is_positive

	cpl
	inc a
.y_is_positive
	add d ; We add both X and Y distances...
	ld d, a ; ...then save the result into D.
	ld a, [wItemFinderDistance] ; Default value is -1 which means 255.
	cp d ; D is always positive, and has a max value of 9.
	jr c, .min_distance_saved

	ld a, d
	ld [wItemFinderDistance], a
.min_distance_saved
	; If the distance is > 1, then we look for a closer item.
	cp 2
	jr nc, .next

	pop hl
.itemnearby_no_pop
	scf
	ret

.GetFarByte:
	ld a, [wCurMapScriptBank]
	call GetFarByte
	inc hl
	ret
