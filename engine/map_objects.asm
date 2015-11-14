
INCLUDE "engine/facings.asm"

SpriteMovementData:: ; 4273
	; function, facing, ?, ?, ?, ?
	db SPRITEMOVEFN_00,                    DOWN,  $01, $02, $00, $00 ; 00
	db SPRITEMOVEFN_STANDING,              DOWN,  $01, $0c, $00, $00 ; 01
	db SPRITEMOVEFN_RANDOM_WALK_XY,        DOWN,  $01, $00, $00, $00 ; 02
	db SPRITEMOVEFN_SLOW_RANDOM_SPIN,      DOWN,  $01, $00, $00, $00 ; 03
	db SPRITEMOVEFN_RANDOM_WALK_Y,         DOWN,  $01, $00, $00, $00 ; 04
	db SPRITEMOVEFN_RANDOM_WALK_X,         DOWN,  $01, $00, $00, $00 ; 05
	db SPRITEMOVEFN_STANDING,              DOWN,  $01, $00, $00, $00 ; 06
	db SPRITEMOVEFN_STANDING,              UP,    $01, $00, $00, $00 ; 07
	db SPRITEMOVEFN_STANDING,              LEFT,  $01, $00, $00, $00 ; 08
	db SPRITEMOVEFN_STANDING,              RIGHT, $01, $00, $00, $00 ; 09
	db SPRITEMOVEFN_FAST_RANDOM_SPIN,      DOWN,  $01, $00, $00, $00 ; 0a
	db SPRITEMOVEFN_OBEY_DPAD,             DOWN,  $01, $02, $00, $00 ; 0b
	db SPRITEMOVEFN_08,                    DOWN,  $01, $00, $00, $00 ; 0c
	db SPRITEMOVEFN_09,                    DOWN,  $01, $00, $00, $00 ; 0d
	db SPRITEMOVEFN_0A,                    DOWN,  $01, $00, $00, $00 ; 0e
	db SPRITEMOVEFN_0B,                    DOWN,  $01, $00, $00, $00 ; 0f
	db SPRITEMOVEFN_0C,                    DOWN,  $01, $00, $00, $00 ; 10
	db SPRITEMOVEFN_0D,                    DOWN,  $01, $00, $00, $00 ; 11
	db SPRITEMOVEFN_0E,                    DOWN,  $01, $00, $00, $00 ; 12
	db SPRITEMOVEFN_FOLLOW,                DOWN,  $01, $02, $00, $00 ; 13
	db SPRITEMOVEFN_SCRIPTED,              DOWN,  $01, $02, $00, $00 ; 14
	db SPRITEMOVEFN_BIG_SNORLAX,           DOWN,  $09, $2e, $01, $c0 ; 15
	db SPRITEMOVEFN_BOUNCE,                DOWN,  $0a, $2e, $00, $00 ; 16
	db SPRITEMOVEFN_STANDING,              DOWN,  $01, $0c, $00, $00 ; 17
	db SPRITEMOVEFN_STANDING,              DOWN,  $01, $2e, $10, $00 ; 18
	db SPRITEMOVEFN_STRENGTH,              DOWN,  $01, $2e, $00, $40 ; 19
	db SPRITEMOVEFN_FOLLOWNOTEXACT,        DOWN,  $01, $02, $00, $00 ; 1a
	db SPRITEMOVEFN_SHADOW,                DOWN,  $00, $8e, $01, $00 ; 1b
	db SPRITEMOVEFN_EMOTE,                 DOWN,  $08, $8e, $02, $00 ; 1c
	db SPRITEMOVEFN_SCREENSHAKE,           DOWN,  $00, $82, $00, $00 ; 1d
	db SPRITEMOVEFN_SPIN_COUNTERCLOCKWISE, LEFT,  $01, $00, $00, $00 ; 1e
	db SPRITEMOVEFN_SPIN_CLOCKWISE,        RIGHT, $01, $00, $00, $00 ; 1f
	db SPRITEMOVEFN_STRENGTH,              DOWN,  $0c, $2e, $01, $c0 ; 20
	db SPRITEMOVEFN_STRENGTH,              DOWN,  $0d, $2e, $01, $c0 ; 21
	db SPRITEMOVEFN_BOULDERDUST,           DOWN,  $0e, $8e, $01, $00 ; 22
	db SPRITEMOVEFN_GRASS,                 DOWN,  $0f, $8e, $02, $00 ; 23
	db SPRITEMOVEFN_RANDOM_WALK_XY,        DOWN,  $01, $00, $00, $20 ; 24
	db SPRITEMOVEFN_00,                    DOWN,  $01, $00, $00, $00 ; 25
; 4357


Function4357:: ; 4357
	push bc
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	push af
	ld h, b
	ld l, c
	ld bc, OBJECT_STRUCT_LENGTH
	xor a
	call ByteFill
	pop af
	cp -1
	jr z, .ok
	bit 7, a
	jr nz, .ok
	call GetMapObject
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld [hl], -1

.ok
	pop bc
	ret
; 437b

Function437b: ; 437b
	call Function4386
	ret c
	call Function43f3
	call Function4427
	ret
; 4386

Function4386: ; 4386
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 6, [hl]
	ld a, [XCoord]
	ld e, a
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .ok
	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .ok
	ld a, [YCoord]
	ld e, a
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .ok
	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .ok
	jr .yes

.ok
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 6, [hl]
	ld a, [XCoord]
	ld e, a
	ld hl, OBJECT_INIT_X
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .ok2
	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .ok2
	ld a, [YCoord]
	ld e, a
	ld hl, OBJECT_INIT_Y
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .ok2
	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .ok2

.yes
	and a
	ret

.ok2
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 1, [hl]
	jr nz, .yes2
	call Function4357
	scf
	ret

.yes2
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 6, [hl]
	and a
	ret
; 43f3

Function43f3: ; 43f3
	ld hl, OBJECT_09
	add hl, bc
	ld a, [hl]
	and a
	jr z, .zero

	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 5, [hl]
	jr nz, .bit5

	cp OBJECT_09_VALUE_01
	jr z, .one
	jr .ok

.zero
	call Function47bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 5, [hl]
	jr nz, .bit5

.one
	call Function47dd
	ld hl, OBJECT_09
	add hl, bc
	ld a, [hl]
	and a
	ret z
	cp OBJECT_09_VALUE_01
	ret z

.ok
	ld hl, Pointers4b45
	rst JumpTable
	ret

.bit5
	ret
; 4427

Function4427: ; 4427
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 0, [hl]
	jr nz, Function44a3

	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 6, [hl]
	jr nz, Function44a3

	bit 5, [hl]
	jr nz, Function4448

	ld de, Pointers445f
	jr Function444d
; 4440

Function4440: ; 4440
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 0, [hl]
	jr nz, Function44a3
	; fallthrough
; 4448

Function4448: ; 4448
	ld de, Pointers445f + 2
	jr Function444d
; 444d

Function444d: ; 444d
; call [4 * ObjectStructs[ObjInd, OBJECT_ACTION] + de]
	ld hl, OBJECT_ACTION
	add hl, bc
	ld a, [hl]
	ld l, a
	ld h, 0
rept 2
	add hl,hl
endr
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	ret
; 445f

Pointers445f: ; 445f
	dw Function44a3 ; 00
	dw Function44a3 ; 01 (00)
	dw Function44b5 ; 02 (01)
	dw Function44aa ; 03 (02)
	dw Function44c1 ; 04 (03)
	dw Function44aa ; 05 (04)
	dw Function4508 ; 06 (05)
	dw Function44aa ; 07 (06)
	dw Function4529 ; 08 (07)
	dw Function44aa ; 09 (08)
	dw Function4539 ; 0a (09)
	dw Function44a3 ; 0b (0a)
	dw Function456e ; 0c (0b)
	dw Function456e ; 0d (0c)
	dw Function457b ; 0e (0d)
	dw Function44a3 ; 0f (0e)
	dw Function4582 ; 10 (0f)
	dw Function4582 ; 11 (10)
	dw Function4589 ; 12 (11)
	dw Function4589 ; 13 (12)
	dw Function4590 ; 14 (13)
	dw Function45a4 ; 15 (14)
	dw Function45ab ; 16 (15)
	dw Function44aa ; 17 (16)
	dw Function45be ; 18 (17)
	dw Function45be ; 19 (18)
	dw Function45c5 ; 1a (19)
	dw Function45c5 ; 1b (1a)
	dw Function45da ; 1c (1b)
	dw Function44a3 ; 1d (1c)
	dw Function45ed ; 1e (1d)
	dw Function44a3 ; 1f (1e)
	dw Function44e4 ; 20 (1f)
	dw Function44aa ; 21 (20)
; 44a3

Function44a3: ; 44a3
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], -1
	ret
; 44aa

Function44aa: ; 44aa
	call GetSpriteDirection
	or 0 ; useless
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 44b5

Function44b5: ; 44b5
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	and 1
	jr nz, Function44c1
	jp Function44aa
; 44c1

Function44c1: ; 44c1
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 3, [hl]
	jp nz, Function44aa
	ld hl, OBJECT_12
	add hl, bc
	ld a, [hl]
	inc a
	and %00001111
	ld [hl], a
	rrca
	rrca
	and %00000011
	ld d, a
	call GetSpriteDirection
	or 0
	or d
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 44e4

Function44e4: ; 44e4
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 3, [hl]
	jp nz, Function44aa
	ld hl, OBJECT_12
	add hl, bc
	ld a, [hl]
	add 2
	and %00001111
	ld [hl], a
	rrca
	rrca
	and %00000011
	ld d, a
	call GetSpriteDirection
	or 0
	or d
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 4508

Function4508: ; 4508
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 3, [hl]
	jp nz, Function44aa
	ld hl, OBJECT_12
	add hl, bc
	inc [hl]
	ld a, [hl]
	rrca
	rrca
	rrca
	and %00000011
	ld d, a
	call GetSpriteDirection
	or 0
	or d
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 4529

Function4529: ; 4529
	call Function453f
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	or 0
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 4539

Function4539: ; 4539
	call Function453f
	jp Function44a3
; 453f

Function453f: ; 453f
	ld hl, OBJECT_12
	add hl, bc
	ld a, [hl]
	and %11110000
	ld e, a
	ld a, [hl]
	inc a
	and %00001111
	ld d, a
	cp 4
	jr c, .ok
	ld d, 0
	ld a, e
	add $10
	and %00110000
	ld e, a

.ok
	ld a, d
	or e
	ld [hl], a
	swap e
	ld d, 0
	ld hl, .Directions
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ret
; 456a

.Directions ; 456a
	db DOWN << 2, RIGHT << 2, UP << 2, LEFT << 2
; 456e

Function456e: ; 456e
	call GetSpriteDirection
	rrca
	rrca
	add $10
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 457b

Function457b: ; 457b
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], $15
	ret
; 4582

Function4582: ; 4582
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], $14
	ret
; 4589

Function4589: ; 4589
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], $17
	ret
; 4590

Function4590: ; 4590
	ld hl, OBJECT_12
	add hl, bc
	ld a, [hl]
	inc a
	and %00001111
	ld [hl], a
	and %00001000
	jr z, Function45a4
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], $4
	ret
; 45a4

Function45a4: ; 45a4
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], 0
	ret
; 45ab

Function45ab: ; 45ab
	ld hl, OBJECT_12
	add hl, bc
	ld a, [hl]
	inc a
	ld [hl], a
	and %00001100
	rrca
	rrca
	add $18
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 45be

Function45be: ; 45be
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], $16
	ret
; 45c5

Function45c5: ; 45c5
	ld a, [VariableSprites + SPRITE_BIG_DOLL - SPRITE_VARS]
	ld d, $17
	cp SPRITE_BIG_SNORLAX
	jr z, .ok
	cp SPRITE_BIG_LAPRAS
	jr z, .ok
	ld d, $16

.ok
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], d
	ret
; 45da

Function45da: ; 45da
	ld hl, OBJECT_12
	add hl, bc
	inc [hl]
	ld a, [hl]

	ld hl, OBJECT_FACING_STEP
	add hl, bc
	and 2
	ld a, $1c
	jr z, .ok
	inc a
.ok
	ld [hl], a
	ret
; 45ed

Function45ed: ; 45ed
	ld hl, OBJECT_12
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	and 4
	ld a, $1e
	jr z, .ok
	inc a

.ok
	ld [hl], a
	ret
; 4600

Function4600: ; 4600

	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld [hl], a

	call Function4661
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld a, [hl]

	call Function4679
	ret
; 462a

Function462a: ; 462a

	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld [hl], a

	ret
; 463f

Function463f: ; 463f
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 3, [hl]
	jr z, .ok
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld a, [hl]
	call Function4661

.ok
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld a, [hl]
	call Function4679
	ret c
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	call Function4679
	ret
; 4661

Function4661: ; 4661
	call CheckSuperTallGrassTile
	jr z, .set
	call Function1875
	jr c, .reset

.set
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 3, [hl]
	ret

.reset
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 3, [hl]
	ret
; 4679

Function4679: ; 4679
	and a
	ret
; 467b

Function467b: ; 467b
	xor a
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
rept 3
	ld [hli], a
endr
	ld [hl], a ; OBJECT_30
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret
; 4690

Function4690: ; 4690
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit FIXED_FACING, [hl]
	jr nz, GetCurTile

rept 2
	add a
endr
	and %00001100
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
GetCurTile: ; 46a6

	call GetStepVector

	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld a, d
	call GetStepVectorSign
	ld hl, OBJECT_MAP_X
	add hl, bc
	add [hl]
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld [hl], a
	ld d, a

	ld a, e
	call GetStepVectorSign
	ld hl, OBJECT_MAP_Y
	add hl, bc
	add [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld [hl], a
	ld e, a

	push bc
	call GetCoordTile
	pop bc

	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld [hl], a

	ret
; 46d7

AddStepVector: ; 46d7

	call GetStepVector

	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a

	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a

	ret
; 46e9

GetStepVector: ; 46e9
; Return (x, y, duration, speed) in (d, e, a, h).
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00001111
rept 2
	add a
endr
	ld l, a
	ld h, 0
	ld de, StepVectors
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ret
; 4700

StepVectors: ; 4700
; x,  y, duration, speed
	; slow
	db  0,  1, 16, 1
	db  0, -1, 16, 1
	db -1,  0, 16, 1
	db  1,  0, 16, 1
	; normal
	db  0,  2,  8, 2
	db  0, -2,  8, 2
	db -2,  0,  8, 2
	db  2,  0,  8, 2
	; fast
	db  0,  4,  4, 4
	db  0, -4,  4, 4
	db -4,  0,  4, 4
	db  4,  0,  4, 4
; 4730

GetStepVectorSign: ; 4730
	add a
	ret z  ; 0 or 128

	ld a, 1
	ret nc ; 1 - 127

	ld a, -1
	ret    ; 129 - 255
; 4738

Function4738: ; 4738
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00000011
	ld [wd151], a
	call AddStepVector
	ld a, [wd14e]
	add d
	ld [wd14e], a
	ld a, [wd14f]
	add e
	ld [wd14f], a
	ld hl, wd150
	set 5, [hl]
	ret
; 4759

Function4759: ; 4759
	push bc
	ld e, a
	ld d, 0
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	call GetMapObject
	add hl, de
	ld a, [hl]
	pop bc
	ret
; 4769

RestoreDefaultMovement: ; 4769
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .ok
	push bc
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	pop bc
	ret

.ok
	ld a, 6
	ret
; 4780

ClearObjectMovementByteIndex: ; 4780
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld [hl], 0
	ret
; 4787

IncrementObjectMovementByteIndex: ; 4787
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	inc [hl]
	ret
; 478d

DecrementObjectMovementByteIndex: ; 478d
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	dec [hl]
	ret
; 4793

JumptoObjectMovementByteIndex: ; 4793
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld a, [hl]
	pop hl
	rst JumpTable
	ret
; 479b

ClearObjectStructField28: ; 479b
	ld hl, OBJECT_28
	add hl, bc
	ld [hl], 0
	ret
; 47a2

IncrementObjectStructField28: ; 47a2
	ld hl, OBJECT_28
	add hl, bc
	inc [hl]
	ret
; 47a8

Object28AnonymousJumptable: ; 47a8
; anonymous jumptable
	ld hl, OBJECT_28
	add hl, bc
	ld a, [hl]
	pop hl
	rst JumpTable
	ret
; 47b0

GetValueObjectStructField28: ; 47b0
	ld hl, OBJECT_28
	add hl, bc
	ld a, [hl]
	ret
; 47b6

SetValueObjectStructField28: ; 47b6
	ld hl, OBJECT_28
	add hl, bc
	ld [hl], a
	ret
; 47bc

Function47bc: ; 47bc
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	call GetCoordTile
	pop bc
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld [hl], a
	call Function4600
	call Function467b
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 47dd

Function47dd: ; 47dd
	call ClearObjectStructField28
	call GetSpriteMovementFunction
	ld a, [hl]
	ld hl, .Pointers
	rst JumpTable
	ret
; 47e9

.Pointers ; 47e9
	dw .Null_00 ; 00
	dw .RandomWalkY ; 01
	dw .RandomWalkX ; 02
	dw .RandomWalkXY ; 03
	dw .RandomSpin1 ; 04
	dw .RandomSpin2 ; 05
	dw .Standing ; 06
	dw .ObeyDPad ; 07
	dw .Movement08 ; 08
	dw .Movement09 ; 09
	dw .Movement0a ; 0a
	dw .Movement0b ; 0b
	dw .Movement0c ; 0c
	dw .Movement0d ; 0d
	dw .Movement0e ; 0e
	dw .Follow ; 0f
	dw .Script ; 10
	dw .Strength ; 11
	dw .FollowNotExact ; 12
	dw .Movement13 ; 13
	dw .Movement14 ; 14
	dw .MovementBigStanding ; 15
	dw .MovementBouncing ; 16
	dw .Movement17 ; 17
	dw .MovementSpinClockwise ; 18
	dw .MovementSpinCounterclockwise ; 19
	dw .Movement1a ; 1a
	dw .Movement1b ; 1b
; 4821

.Null_00: ; 4821
	ret
; 4822

.RandomWalkY: ; 4822
	call Random
	ld a, [hRandomAdd]
	and %00000001
	jp .RandomWalkContinue
; 482c

.RandomWalkX: ; 482c
	call Random
	ld a, [hRandomAdd]
	and %00000001
	or  %00000010
	jp .RandomWalkContinue
; 4838

.RandomWalkXY: ; 4838
	call Random
	ld a, [hRandomAdd]
	and %00000011
	jp .RandomWalkContinue
; 4842

.RandomSpin1: ; 4842
	call Random
	ld a, [hRandomAdd]
	and %00001100
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	jp RandomStepDuration_Slow
; 4851

.RandomSpin2: ; 4851
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %00001100
	ld d, a
	call Random
	ld a, [hRandomAdd]
	and %00001100
	cp d
	jr nz, .keep
	xor %00001100

.keep
	ld [hl], a
	jp RandomStepDuration_Fast
; 4869

.Standing: ; 4869
	call Function462a
	call Function467b
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 1
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_05
	ret
; 487c

.ObeyDPad: ; 487c
	ld hl, Function5000
	jp HandleMovementData
; 4882

.Movement08: ; 4882
	ld hl, Function5015
	jp HandleMovementData
; 4888

.Movement09: ; 4888
	ld hl, Function5026
	jp HandleMovementData
; 488e

.Movement0a: ; 488e
	jp Function5037
; 4891

.Movement0b: ; 4891
	jp Function5037
; 4894

.Movement0c: ; 4894
	jp Function5037
; 4897

.Movement0d: ; 4897
	ld hl, Function5000
	jp HandleMovementData
; 489d

.Movement0e: ; 489d
	jp Function5037
; 48a0

.Follow: ; 48a0
	ld hl, Function54e6
	jp HandleMovementData
; 48a6

.Script: ; 48a6
	ld hl, Function500e
	jp HandleMovementData
; 48ac

.Strength: ; 48ac
	call JumptoObjectMovementByteIndex
	dw .Strength_Start
	dw .Strength_Stop
; 48b3

.Strength_Start: ; 48b3
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld a, [hl]
	call CheckPitTile
	jr z, .on_pit

	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 2, [hl]
	res 2, [hl]
	jr z, .ok

	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	and %00000011
	or 0
	call Function4690
	call Function6ec1
	jr c, .ok2

	ld de, SFX_STRENGTH
	call PlaySFX
	call SpawnStrengthBoulderDust
	call Function463f
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_0F
	ret

.ok2
	call Function462a

.ok
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

.on_pit
	call IncrementObjectMovementByteIndex
	; fallthrough
; 48f8

.Strength_Stop: ; 48f8
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret
; 48ff

.FollowNotExact: ; 48ff
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]

	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]

	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]

	push bc
	call GetObjectStruct
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .standing

	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .equal
	jr c, .less
	ld a, 3
	jr .done

.less
	ld a, 2
	jr .done

.equal
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr z, .standing
	jr c, .less2
	ld a, 0
	jr .done

.less2
	ld a, 1

.done
	ld d, a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00001100
	or d
	pop bc
	jp NormalStep

.standing
	pop bc
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 1
	ret
; 4958

.MovementBigStanding: ; 4958
	call Function467b
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 9
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_04
	ret
; 496e

.MovementBouncing: ; 496e
	call Function467b
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 10
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_04
	ret
; 4984

.MovementSpinCounterclockwise: ; 4984
	call JumptoObjectMovementByteIndex
	dw .MovementSpinInit
	dw .MovementSpinRepeat
	dw .MovementSpinTurnLeft
; 498d

.MovementSpinClockwise: ; 498d
	call JumptoObjectMovementByteIndex
	dw .MovementSpinInit
	dw .MovementSpinRepeat
	dw .MovementSpinTurnRight
; 4996

.MovementSpinInit: ; 4996
	call Function467b
	call IncrementObjectMovementByteIndex
	; fallthrough
; 499c

.MovementSpinRepeat: ; 499c
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 1
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	ld a, 16
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_03
	call IncrementObjectMovementByteIndex
	ret
; 49b8

.MovementSpinTurnLeft: ; 49b8
	ld de, .DirectionData_Counterclockwise
	call .MovementSpinNextFacing
	jr .MovementSpinCounterclockwise
; 49c0

.DirectionData_Counterclockwise ; 49c0
	db RIGHT << 2, LEFT << 2, DOWN << 2, UP << 2
; 49c4

.MovementSpinTurnRight: ; 49c4
	ld de, .DirectionData_Clockwise
	call .MovementSpinNextFacing
	jr .MovementSpinClockwise
; 49cc

.DirectionData_Clockwise ; 49cc
	db LEFT << 2, RIGHT << 2, UP << 2, DOWN << 2
; 49d0

.MovementSpinNextFacing: ; 49d0
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %00001100
	rrca
	rrca
	push hl
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	pop hl
	ld [hl], a
	call DecrementObjectMovementByteIndex
	ret
; 49e5

.Movement13: ; 49e5
	call ._Movement13_14_1a_1b
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], $7
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	inc a
	add a
	add 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	and 3
	ld d, $e
	cp DOWN
	jr z, .ok_13
	cp UP
	jr z, .ok_13
	ld d, $c

.ok_13
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_13
	ret
; 4a21

.Movement14: ; 4a21
	call Function467b
	call ._Movement13_14_1a_1b
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 8
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], $f0
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_13
	ret
; 4a46

.Movement1a: ; 4a46
	call Function467b
	call ._Movement13_14_1a_1b
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], $e
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	inc a
	add a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	and %00000011
	ld e, a
	ld d, 0
	ld hl, .data_4a81
rept 2
	add hl,de
endr
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_13
	ret
; 4a81

.data_4a81  ; 4a81
	;   x,  y
	db  0, -4
	db  0,  8
	db  6,  2
	db -6,  2
; 4a89

.Movement1b: ; 4a89
	call Function467b
	call ._Movement13_14_1a_1b
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], $f
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	add -1
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_13
	ret
; 4aa8

._Movement13_14_1a_1b: ; 4aa8
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	push bc
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ld hl, OBJECT_29
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret
; 4abc

.Movement17: ; 4abc
	call Function467b
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	call ._Movement17
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_30
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_15
	ret
; 4ade

._Movement17: ; 4ade
	ld d, a
	and %00111111
	ld e, a
	ld a, d
	rlca
	rlca
	and %00000011
	ld d, a
	inc d
	ld a, 1
.loop
	dec d
	ret z
	add a
	jr .loop
; 4af0

.RandomWalkContinue: ; 4af0
	call Function4690
	call Function6ec1
	jr c, Function4b17
	call Function463f
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 2
	ld hl, wd4cf
	ld a, [hMapObjectIndexBuffer]
	cp [hl]
	jr z, .load_6
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_07
	ret

.load_6
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_06
	ret

Function4b17: ; 4b17
	call Function467b
	call Function462a
	; fallthrough
; 4b1d

RandomStepDuration_Slow: ; 4b1d
	call Random
	ld a, [hRandomAdd]
	and %01111111
	jr SetRandomStepDuration
; 4b26

RandomStepDuration_Fast: ; 4b26
	call Random
	ld a, [hRandomAdd]
	and %00011111
	; fallthrough
; 4b2d

SetRandomStepDuration: ; 4b2d
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 1
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_03
	ret
; 4b45

Pointers4b45: ; 4b45
; These pointers use OBJECT_09.  See constants/sprite_constants.asm
	dw Function47bc ; 00
	dw Function47dd ; 01
	dw Function4e2b ; 02
	dw Function4ddd ; 03
	dw Function4e21 ; 04
	dw Function4e0c ; 05
	dw Function4e56 ; 06
	dw Function4e47 ; 07
	dw Function4b86 ; 08
	dw Function4bbf ; 09
	dw Function4e83 ; 0a
	dw Function4dff ; 0b
	dw Function4c18 ; 0c
	dw Function4c89 ; 0d
	dw Function4d14 ; 0e
	dw Function4ecd ; 0f
	dw Function4d7e ; 10
	dw Function4daf ; 11
	dw Function4dc8 ; 12
	dw Function4f04 ; 13
	dw Function4f33 ; 14
	dw Function4f33 ; 15
	dw Function4f77 ; 16
	dw Function4f7a ; 17
	dw Function4df0 ; 18
	dw Function4f83 ; 19
; 4b79

Function4b79: ; 4b79
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4b86

Function4b86: ; 4b86
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4b8d
	dw Function4ba9
; 4b8d

Function4b8d: ; 4b8d
	call AddStepVector
	call UpdateJumpPosition
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Function4600
	call GetCurTile
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 3, [hl]
	call IncrementObjectStructField28
	ret
; 4ba9

Function4ba9: ; 4ba9
	call AddStepVector
	call UpdateJumpPosition
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Function4600
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4bbf

Function4bbf: ; 4bbf
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4bca
	dw Function4bd2
	dw Function4bf2
	dw Function4bfd
; 4bca

Function4bca: ; 4bca
	ld hl, wd150
	set 7, [hl]
	call IncrementObjectStructField28
;	fallthrough
; 4bd2

Function4bd2: ; 4bd2
	call UpdateJumpPosition
	call Function4738
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Function4600
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 3, [hl]
	ld hl, wd150
	set 6, [hl]
	set 4, [hl]
	call IncrementObjectStructField28
	ret
; 4bf2

Function4bf2: ; 4bf2
	call GetCurTile
	ld hl, wd150
	set 7, [hl]
	call IncrementObjectStructField28
;	fallthrough
; 4bfd

Function4bfd: ; 4bfd
	call UpdateJumpPosition
	call Function4738
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wd150
	set 6, [hl]
	call Function4600
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4c18

Function4c18: ; 4c18
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4c23
	dw Function4c32
	dw Function4c42
	dw Function4c5d
; 4c23

Function4c23: ; 4c23
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
;	fallthrough
; 4c32

Function4c32: ; 4c32
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 4
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
	ret
; 4c42

Function4c42: ; 4c42
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_31
	add hl, bc
	ld [hl], $10
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $10
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 3, [hl]
	call IncrementObjectStructField28
;	fallthrough
; 4c5d

Function4c5d: ; 4c5d
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 4
	ld hl, OBJECT_31
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4c89

Function4c89: ; 4c89
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4c9a
	dw Function4caa
	dw Function4cb3
	dw Function4cc9
	dw Function4ceb
	dw Function4cf5
	dw Function4d01
; 4c9a

Function4c9a: ; 4c9a
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
	ret
; 4caa

Function4caa: ; 4caa
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
;	fallthrough
; 4cb3

Function4cb3: ; 4cb3
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_31
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
	ret
; 4cc9

Function4cc9: ; 4cc9
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 4
	ld hl, OBJECT_31
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
;	fallthrough
; 4ceb

Function4ceb: ; 4ceb
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
	ret
; 4cf5

Function4cf5: ; 4cf5
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 4
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
; 4d01

Function4d01: ; 4d01
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4d14

Function4d14: ; 4d14
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4d1f
	dw Function4d2e
	dw Function4d4f
	dw Function4d6b
; 4d1f

Function4d1f: ; 4d1f
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
;	fallthrough
; 4d2e

Function4d2e: ; 4d2e
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], 2
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_31
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
;	fallthrough
; 4d4f

Function4d4f: ; 4d4f
	ld hl, OBJECT_31
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
;	fallthrough
; 4d6b

Function4d6b: ; 4d6b
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4d7e

Function4d7e: ; 4d7e
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4d85
	dw Function4d94
; 4d85

Function4d85: ; 4d85
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 8
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	call IncrementObjectStructField28
	; fallthrough
; 4d94

Function4d94: ; 4d94
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld a, [hl]
	xor 1
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4daf

Function4daf: ; 4daf
	call Function4db5
	jp Function4b79
; 4db5

Function4db5: ; 4db5
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %00000001
	ld a, 1
	jr z, .yes
	ld a, 0

.yes
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	ret
; 4dc8

Function4dc8: ; 4dc8
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %00000001
	ld a, 4
	jr z, .yes
	ld a, 5

.yes
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	jp Function4b79
; 4ddd

Function4ddd: ; 4ddd
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4df0

Function4df0: ; 4df0
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	jp Function4357
; 4dff

Function4dff: ; 4dff
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4e0c

Function4e0c: ; 4e0c
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4e13
	dw Function4e21
; 4e13

Function4e13: ; 4e13
	call RestoreDefaultMovement
	call GetInitialFacing
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	call IncrementObjectStructField28
	; fallthrough
; 4e21

Function4e21: ; 4e21
	call Function4fb2
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret
; 4e2b

Function4e2b: ; 4e2b
	call Function4fb2
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Function4600
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4e47

Function4e47: ; 4e47
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Function4600
	jp RandomStepDuration_Slow
; 4e56

Function4e56: ; 4e56
; AnimateStep?
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4e5d
	dw Function4e65
; 4e5d

Function4e5d: ; 4e5d
	ld hl, wd150
	set 7, [hl]
	call IncrementObjectStructField28
	; fallthrough
; 4e65

Function4e65: ; 4e65
	call Function4738
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz

	ld hl, wd150
	set 6, [hl]
	call Function4600
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4e83

Function4e83: ; 4e83
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4e8e
	dw Function4ea4
	dw Function4ead
	dw Function4ec0
; 4e8e

Function4e8e: ; 4e8e
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_12
	add hl, bc
	ld a, [hl]
	ld [hl], 2
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 2
	call IncrementObjectStructField28
	; fallthrough
; 4ea4

Function4ea4: ; 4ea4
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
	; fallthrough
; 4ead

Function4ead: ; 4ead
	ld hl, OBJECT_29
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $2
	call IncrementObjectStructField28
	; fallthrough
; 4ec0

Function4ec0: ; 4ec0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4ecd

Function4ecd: ; 4ecd
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	push bc
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ld b, a
	callba CopyDECoordsToMapObject
	pop bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 2, [hl]
	call Function4600
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4f04

Function4f04: ; 4f04
	ld hl, OBJECT_29
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .nope
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret nz

.nope
	jp Function4357
; 4f33

Function4f33: ; 4f33
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4f3a
	dw Function4f43
; 4f3a

Function4f3a: ; 4f3a
	xor a
	ld hl, OBJECT_29
	add hl, bc
	ld [hl], a
	call IncrementObjectStructField28
	; fallthrough
; 4f43

Function4f43: ; 4f43
	ld hl, OBJECT_29
	add hl, bc
	ld d, [hl]
	ld a, [wd14f]
	sub d
	ld [wd14f], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	jr z, .ok
	ld a, [hl]
	call Function4f6c
	ld hl, OBJECT_29
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, [wd14f]
	add d
	ld [wd14f], a
	ret

.ok
	call Function4357
	ret
; 4f6c

Function4f6c: ; 4f6c
	ld hl, OBJECT_30
	add hl, bc
	and 1
	ld a, [hl]
	ret z
	cpl
	inc a
	ret
; 4f77

Function4f77: ; 4f77
	call Object28AnonymousJumptable ; ????
; 4f7a

Function4f7a: ; 4f7a
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4f83
	dw Function4f83
	dw Function4f83
; 4f83

Function4f83: ; 4f83
	call Object28AnonymousJumptable
; anonymous jumptable
	dw Function4f8a
	dw Function4f99
; 4f8a

Function4f8a: ; 4f8a
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], $10
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $10
	call IncrementObjectStructField28
; 4f99

Function4f99: ; 4f99
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], $60
	ld hl, OBJECT_12
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_01
	ret
; 4fb2

Function4fb2: ; 4fb2
	ret
; 4fb3

Function4fb3: ; 4fb3
	ld hl, OBJECT_29
	add hl, bc
	inc [hl]
	ld a, [hl]
	srl a
	srl a
	and %00000111
	ld l, a
	ld h, 0
	ld de, .y
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ret
; 4fcd

.y ; 4fcd
	db 0, -1, -2, -3, -4, -3, -2, -1
; 4fd5

UpdateJumpPosition: ; 4fd5
	call GetStepVector
	ld a, h
	ld hl, OBJECT_31
	add hl, bc
	ld e, [hl]
	add e
	ld [hl], a
	nop
	srl e
	ld d, 0
	ld hl, .y
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ret
; 4ff0

.y ; 4ff0
	db  -4,  -6,  -8, -10, -11, -12, -12, -12
	db -11, -10,  -9,  -8,  -6,  -4,   0,   0
; 5000

Function5000: ; unscripted?
; copy [wc2de] to [wc2df]
	ld a, [wc2de]
	ld hl, wc2df
	ld [hl], a
; load [wc2de] with movement_step_sleep_1
	ld a, movement_step_sleep_1
	ld [wc2de], a
; recover the previous value of [wc2de]
	ld a, [hl]
	ret
; 500e

Function500e: ; scripted
	ld hl, wMovementDataPointer
	call Function1aae
	ret
; 5015

Function5015: ; 5015
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wMovementPerson
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	ret
; 5026

Function5026: ; 5026
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wc2e6
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	ret
; 5037

Function5037: ; 5037
	ld hl, GetMovementPerson
	jp HandleMovementData
; 503d

GetMovementPerson: ; 503d
	ld a, [wMovementPerson]
	ret
; 5041

HandleMovementData: ; 5041
	call CopyMovementPointer
.loop
	xor a
	ld [wc2ea], a
	call GetMovementByte
	call DoMovementFunction
	ld a, [wc2ea]
	and a
	jr nz, .loop
	ret
; 5055

CopyMovementPointer: ; 5055
	ld a, l
	ld [wMovementPointer], a
	ld a, h
	ld [wMovementPointer + 1], a
	ret
; 505e

GetMovementByte: ; 505e
	ld hl, wMovementPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp [hl]
; 5065

ContinueReadingMovement: ; 5065
	ld a, 1
	ld [wc2ea], a
	ret
; 506b

DoMovementFunction: ; 506b
	push af
	call ApplyMovementToFollower
	pop af
	ld hl, MovementPointers
	rst JumpTable
	ret
; 5075


; 5075
INCLUDE "engine/movement.asm"
; 54b8


ApplyMovementToFollower: ; 54b8
	ld e, a
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	ld a, [wObjectFollow_Leader]
	ld d, a
	ld a, [hMapObjectIndexBuffer]
	cp d
	ret nz
	ld a, e
	cp $3e
	ret z
	cp $47
	ret z
	cp $4b
	ret z
	cp $50
	ret z
	cp $8
	ret c
	push af
	ld hl, wd4d0
	inc [hl]
	ld e, [hl]
	ld d, 0
	ld hl, wd4d1
	add hl, de
	pop af
	ld [hl], a
	ret
; 54e6

Function54e6: ; 54e6
	ld hl, wd4d0
	ld a, [hl]
	and a
	jr z, .done
	cp -1
	jr z, .done
	dec [hl]
	ld e, a
	ld d, 0
	ld hl, wd4d1
	add hl, de
	inc e
	ld a, -1
.loop
	ld d, [hl]
	ld [hld], a
	ld a, d
	dec e
	jr nz, .loop
	ret

.done
	call Function550a
	ret c

	ld a, movement_step_sleep_1
	ret
; 550a

Function550a: ; 550a
	ld a, [wObjectFollow_Leader]
	cp -1
	jr z, .nope
	push bc
	call GetObjectStruct
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	pop bc
	and a
	jr z, .nope
	and a
	ret

.nope
	ld a, $ff
	ld [wObjectFollow_Follower], a
	ld a, movement_step_end
	scf
	ret
; 5529

SpawnShadow: ; 5529
	push bc
	ld de, .ShadowObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.ShadowObject
	; vtile, palette, movement
	db $00, PAL_OW_SILVER, SPRITEMOVEDATA_SHADOW
; 5538

SpawnStrengthBoulderDust: ; 5538
	push bc
	ld de, .BoulderDustObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.BoulderDustObject
	db $00, PAL_OW_SILVER, SPRITEMOVEDATA_BOULDERDUST
; 5547

SpawnEmote: ; 5547
	push bc
	ld de, .EmoteObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.EmoteObject
	db $00, PAL_OW_SILVER, SPRITEMOVEDATA_EMOTE
; 5556

ShakeGrass: ; 5556
	push bc
	ld de, .data_5562
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.data_5562
	db $00, PAL_OW_TREE, SPRITEMOVEDATA_GRASS
; 5565

ShakeScreen: ; 5565
	push bc
	push af
	ld de, .ScreenShakeObject
	call CopyTempObjectData
	pop af
	ld [wTempObjectCopyRange], a
	call InitTempObject
	pop bc
	ret

.ScreenShakeObject
	db $00, PAL_OW_SILVER, SPRITEMOVEDATA_SCREENSHAKE
; 5579

DespawnEmote: ; 5579
	push bc
	ld a, [hMapObjectIndexBuffer]
	ld c, a
	call .DeleteEmote
	pop bc
	ret
; 5582

.DeleteEmote: ; 5582
	ld de, ObjectStructs
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af
	ld hl, OBJECT_FLAGS1
	add hl, de
	bit 7, [hl]
	jr z, .next
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next
	push bc
	xor a
	ld bc, OBJECT_STRUCT_LENGTH
	call ByteFill
	pop bc

.next
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop af
	dec a
	jr nz, .loop
	ret
; 55ac

InitTempObject: ; 55ac
	call FindFirstEmptyObjectStruct
	ret nc

	ld d, h
	ld e, l
	callba CopyTempObjectToObjectStruct
	ret
; 55b9

CopyTempObjectData: ; 55b9
; load into wTempObjectCopy:
; -1, -1, [de], [de + 1], [de + 2], [hMapObjectIndexBuffer], [NextMapX], [NextMapY], -1
; This spawns the object at the same place as whichever object is loaded into bc.
	ld hl, wTempObjectCopyMapObjectIndex
	ld [hl], -1
	inc hl
	ld [hl], -1
	inc hl

	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hli], a

	ld a, [hMapObjectIndexBuffer]
	ld [hli], a

	push hl
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	pop hl

	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], -1
	ret
; 55e0

Function55e0:: ; 55e0
	ld a, [VramState]
	bit 0, a
	ret z
	ld bc, ObjectStructs
	xor a
.loop
	ld [hMapObjectIndexBuffer], a
	call GetObjectSprite
	jr z, .ok
	call Function565c

.ok
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ld a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret
; 5602

Function5602: ; 5602
	call Function5645
	ld a, 0
	call Function5629
	ld a, [wd459]
	bit 7, a
	jr z, .ok
	ld a, [hLastTalked]
	and a
	jr z, .ok
	call Function5629

.ok
	call RefreshMapAppearDisappear
	ret
; 561d

Function561d: ; 561d
	call Function5645
	ld a, 0
	call Function5629
	call RefreshMapAppearDisappear
	ret
; 5629

Function5629: ; 5629
	cp NUM_OBJECTS
	ret nc

	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	ret z

	cp NUM_OBJECT_STRUCTS
	ret nc

	call GetObjectStruct
	call GetObjectSprite
	ret z

	call Function5673
	ret
; 5645

Function5645: ; 5645
	xor a
	ld bc, ObjectStructs
.loop
	ld [hMapObjectIndexBuffer], a
	call Function5680
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ld a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret
; 565c

Function565c: ; 565c
	push bc
	call Function56cd
	pop bc
	jr c, Function5680
	call Function56a3
	jr c, Function5680
	call Function5688
	callba Function4440
	xor a
	ret
; 5673

Function5673: ; 5673
	call Function56a3
	jr c, Function5680
	callba Function4440
	xor a
	ret
; 5680

Function5680: ; 5680
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], STANDING
	scf
	ret
; 5688

Function5688: ; 5688
	push bc
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	call GetCoordTile
	pop bc
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld [hl], a
	callba Function463f
	ret
; 56a3

Function56a3: ; 56a3
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	inc d
	inc e
	ld a, [XCoord]
	cp d
	jr z, .equal_x
	jr nc, .nope
	add $b
	cp d
	jr c, .nope

.equal_x
	ld a, [YCoord]
	cp e
	jr z, .equal_y
	jr nc, .nope
	add $a
	cp e
	jr c, .nope

.equal_y
	xor a
	ret

.nope
	scf
	ret
; 56cd

Function56cd: ; 56cd
	ld a, [wd14c]
	ld d, a
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	add [hl]
	add d
	cp $f0
	jr nc, .ok1
	cp $a0
	jp nc, .nope

.ok1
	and %00000111
	ld d, 2
	cp 4
	jr c, .ok2
	ld d, 3

.ok2
	ld a, [hl]
	srl a
	srl a
	srl a
	cp SCREEN_WIDTH
	jr c, .ok3
	sub $20

.ok3
	ld [hUsedSpriteIndex], a
	ld a, [wd14d]
	ld e, a
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	add [hl]
	add e
	cp $f0
	jr nc, .ok4
	cp $90
	jr nc, .nope

.ok4
	and %00000111
	ld e, 2
	cp 4
	jr c, .ok5
	ld e, 3

.ok5
	ld a, [hl]
	srl a
	srl a
	srl a
	cp $12
	jr c, .ok6
	sub $20

.ok6
	ld [hUsedSpriteTile], a
	ld hl, OBJECT_PALETTE
	add hl, bc
	bit 7, [hl]
	jr z, .ok7
	ld a, d
	add 2
	ld d, a
	ld a, e
	add 2
	ld e, a

.ok7
	ld a, d
	ld [hFFBF], a
.loop
	ld a, [hFFBF]
	ld d, a
	ld a, [hUsedSpriteTile]
	add e
	dec a
	cp $12
	jr nc, .ok9
	ld b, a
.next
	ld a, [hUsedSpriteIndex]
	add d
	dec a
	cp $14
	jr nc, .ok8
	ld c, a
	push bc
	call Coord2Tile
	pop bc
	ld a, [hl]
	cp $60
	jr nc, .nope

.ok8
	dec d
	jr nz, .next

.ok9
	dec e
	jr nz, .loop
	and a
	ret

.nope
	scf
	ret
; 576a

Function576a:: ; 576a
	call Function5771
	call Function5781
	ret
; 5771

Function5771: ; 5771
	xor a
	ld [wd14e], a
	ld [wd14f], a
	ld [wd150], a
	ld a, -1
	ld [wd151], a
	ret
; 5781

Function5781: ; 5781
	ld bc, ObjectStructs
	xor a
.loop
	ld [hMapObjectIndexBuffer], a
	call GetObjectSprite
	jr z, .next
	call Function437b

.next
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ld a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret
; 579d

Function579d: ; 579d
	ld a, $3e
	ld [wc2de], a
	ld [wc2df], a
	xor a
	ld [wd04e], a
	ld [PlayerObject12], a
	call Function57bc
	callba CheckWarpCollision
	call c, SpawnInFacingDown
	call Function57ca
	ret
; 57bc

Function57bc: ; 57bc
	ld hl, wPlayerSpriteSetupFlags
	bit 7, [hl]
	jr nz, .ok
	ret

.ok
	ld a, 0
	ld [PlayerAction], a
	ret
; 57ca

Function57ca: ; 57ca
	ld hl, wPlayerSpriteSetupFlags
	bit 5, [hl]
	ret z
	ld a, [wPlayerSpriteSetupFlags]
	and 3
rept 2
	add a
endr
	jr Function57db
; 57d9

SpawnInFacingDown: ; 57d9
	ld a, 0
	; fallthrough
; 57db

Function57db: ; 57db
	ld bc, PlayerStruct
	call SetSpriteDirection
	ret
; 57e2

Function57e2: ; 57e2
	ld a, d
	and %10000000
	ret z
	ld bc, 0 ; debug?
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	or d
	ld [hl], a
	ld a, d
	swap a
	and %00000111
	ld d, a
	ld bc, PlayerStruct
	ld hl, OBJECT_PALETTE
	add hl, bc
	ld a, [hl]
	and %11111000
	or d
	ld [hl], a
	ret
; 5803

StartFollow:: ; 5803
	push bc
	ld a, b
	call SetLeaderIfVisible
	pop bc
	ret c
	ld a, c
	call SetFollowerIfVisible
	callba Function848a
	ret
; 5815

SetLeaderIfVisible: ; 5815
	call CheckObjectVisibility
	ret c
	ld a, [hObjectStructIndexBuffer]
	ld [wObjectFollow_Leader], a
	ret
; 581f

StopFollow:: ; 581f
	call ResetLeader
	call ResetFollower
	ret
; 5826

ResetLeader: ; 5826
	ld a, -1
	ld [wObjectFollow_Leader], a
	ret
; 582c

SetFollowerIfVisible: ; 582c
	push af
	call ResetFollower
	pop af
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], SPRITEMOVEDATA_FOLLOWING
	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_00
	ld a, [hObjectStructIndexBuffer]
	ld [wObjectFollow_Follower], a
	ret
; 5847

ResetFollower: ; 5847
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	call GetObjectStruct
	callba Function58e3 ; no need to bankswitch
	ld a, -1
	ld [wObjectFollow_Follower], a
	ret
; 585c

SetFlagsForMovement_1:: ; 585c
	ld a, c
	call CheckObjectVisibility
	ret c
	push bc
	call Function587a
	pop bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
	xor a
	ret
; 586e

Function586e: ; 586e
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 5, [hl]
	xor a
	ret
; 587a

Function587a: ; 587a
	ld bc, ObjectStructs
	xor a
.loop
	push af
	call GetObjectSprite
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 5, [hl]

.next
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret
; 5897

_SetFlagsForMovement_2:: ; 5897
	ld a, [wObjectFollow_Leader]
	cp -1
	ret z
	push bc
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	pop bc
	cp c
	ret nz
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	call GetObjectStruct
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
	ret
; 58b9

Function58b9:: ; 58b9
	push bc
	ld bc, ObjectStructs
	xor a
.loop
	push af
	call GetObjectSprite
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]

.next
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	pop bc
	ret
; 58d8

Function58d8: ; 58d8
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
	ret
; 58e3

Function58e3: ; 58e3
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	jp z, Function5903 ; a jr would have been appropriate here

	push bc
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	pop bc

	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_00
	ret
; 5903

Function5903: ; 5903
	call GetSpriteDirection
	rrca
	rrca
	ld e, a
	ld d, 0
	ld hl, .standing_movefns
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_09
	add hl, bc
	ld [hl], OBJECT_09_VALUE_00
	ret

.standing_movefns
	db SPRITEMOVEDATA_STANDING_DOWN
	db SPRITEMOVEDATA_STANDING_UP
	db SPRITEMOVEDATA_STANDING_LEFT
	db SPRITEMOVEDATA_STANDING_RIGHT
; 5920

RefreshMapAppearDisappear:: ; 5920
	ld a, [VramState]
	bit 0, a
	ret z
	xor a
	ld [hUsedSpriteIndex], a
	ld a, [hOAMUpdate]
	push af
	ld a, 1
	ld [hOAMUpdate], a
	call Function5991
	call Function593a
	pop af
	ld [hOAMUpdate], a
	ret
; 593a

Function593a: ; 593a
	ld a, [VramState]
	bit 1, a
	ld b, $a0
	jr z, .ok
	ld b, $70

.ok
	ld a, [hUsedSpriteIndex]
	cp b
	ret nc
	ld l, a
	ld h, $c4
	ld de, OBJECT_FLAGS1
	ld a, b
	ld c, $a0
.loop
	ld [hl], c
	add hl, de
	cp l
	jr nz, .loop
	ret
; 5958

Function5958: ; 5958
	push hl
	push de
	push bc
	ld a, [wd14c]
	ld d, a
	ld a, [wd14d]
	ld e, a
	ld bc, ObjectStructs
	ld a, NUM_OBJECT_STRUCTS

.loop
	push af
	call GetObjectSprite
	jr z, .skip

	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a

	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a

.skip
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	dec a
	jr nz, .loop

	xor a
	ld [wd14c], a
	ld [wd14d], a
	pop bc
	pop de
	pop hl
	ret
; 5991

Function5991: ; 5991
	call Function59a4
	ld c, $30
	call Function59f3
	ld c, $20
	call Function59f3
	ld c, $10
	call Function59f3
	ret
; 59a4

Function59a4: ; 59a4
	xor a
	ld hl, wMovementPointer
	ld bc, 13
	call ByteFill

	ld d, 0
	ld bc, ObjectStructs
	ld hl, wMovementPointer
.loop
	push hl
	call GetObjectSprite
	jr z, .skip

	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .skip

; Define the sprite priority.
	ld e, $10
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 0, [hl]
	jr nz, .add
	ld e, $20
	bit 1, [hl]
	jr z, .add
	ld e, $30
	jr .add

.skip
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	jr .next

.add
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ld a, d
	or e
	ld [hli], a

.next
	inc d
	ld a, d
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret
; 59f3

Function59f3: ; 59f3
	ld hl, wMovementPointer
.next
	ld a, [hli]
	ld d, a
	and $f0
	ret z
	cp c
	jr nz, .next

	push bc
	push hl
	ld a, d
	and $f
	call .GetObjectStructPointer
	call .asm_5a0d
	pop hl
	pop bc
	jr .next
; 5a0d

.asm_5a0d: ; 5a0d
	ld hl, OBJECT_SPRITE_TILE
	add hl, bc
	ld a, [hl]
	and %01111111
	ld [hFFC1], a

	xor a
	bit 7, [hl]
	jr nz, .skip1
	or %00001000
.skip1

	ld hl, OBJECT_FLAGS2
	add hl, bc
	ld e, [hl]
	bit 7, e
	jr z, .skip2
	or %10000000
.skip2

	bit 4, e
	jr z, .skip3
	or %00010000
.skip3

	ld hl, OBJECT_PALETTE
	add hl, bc
	ld d, a
	ld a, [hl]
	and %00000111
	or d
	ld d, a

	xor a
	bit 3, e
	jr z, .skip4
	or %10000000
.skip4
	ld [hFFC2], a

	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]

	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	add [hl]

	add 8

	ld e, a
	ld a, [wd14c]
	add e
	ld [hFFBF], a

	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]

	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	add [hl]

	add 12

	ld e, a
	ld a, [wd14d]
	add e
	ld [hFFC0], a

	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	cp STANDING
	jp z, .done
	cp NUM_FACINGS
	jp nc, .done

	ld l, a
	ld h, 0
	add hl, hl
	ld bc, Facings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [hUsedSpriteIndex]
	ld c, a
	ld b, Sprites / $100
	ld a, [hli]
	ld [hUsedSpriteTile], a
	add c
	cp SpritesEnd % $100
	jr nc, .full

.addsprite
	ld a, [hFFC0]
	add [hl]
	inc hl

	ld [bc], a
	inc c

	ld a, [hFFBF]
	add [hl]
	inc hl

	ld [bc], a
	inc c

	ld e, [hl]
	inc hl

	ld a, [hFFC1]
	bit 2, e
	jr z, .nope1
	xor a
.nope1
	add [hl]
	inc hl

	ld [bc], a
	inc c

	ld a, e
	bit 1, a
	jr z, .nope2
	ld a, [hFFC2]
	or e
.nope2
	and %11110000
	or d
	ld [bc], a
	inc c

	ld a, [hUsedSpriteTile]
	dec a
	ld [hUsedSpriteTile], a
	jr nz, .addsprite

	ld a, c
	ld [hUsedSpriteIndex], a

.done
	xor a
	ret

.full
	scf
	ret
; 5ac2

.GetObjectStructPointer: ; 5ac2
	ld c, a
	ld b, 0
	ld hl, .Addresses
rept 2
	add hl,bc
endr
	ld c, [hl]
	inc hl
	ld b, [hl]
	ret
; 5ace

.Addresses ; 5ace
	dw PlayerStruct
	dw Object1Struct
	dw Object2Struct
	dw Object3Struct
	dw Object4Struct
	dw Object5Struct
	dw Object6Struct
	dw Object7Struct
	dw Object8Struct
	dw Object9Struct
	dw Object10Struct
	dw Object11Struct
	dw Object12Struct
; 5ae8
