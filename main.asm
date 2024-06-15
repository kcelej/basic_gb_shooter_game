;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _brick_hit
	.globl _shoot
	.globl _performant_delay
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _spaceship
	.globl _map01
	.globl _map_tiles
	.globl _missle_moving
	.globl _blankmap
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_missle_moving::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_map_tiles::
	.ds 64
_map01::
	.ds 360
_spaceship::
	.ds 32
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:11: void performant_delay(uint8_t number_of_loops){
;	---------------------------------
; Function performant_delay
; ---------------------------------
_performant_delay::
	ld	c, a
;main.c:13: for(i = 0; i< number_of_loops; i++){
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, c
	ret	NC
;main.c:14: wait_vbl_done();
	call	_wait_vbl_done
;main.c:13: for(i = 0; i< number_of_loops; i++){
	inc	b
;main.c:16: }
	jr	00103$
_blankmap:
	.db #0x00	;  0
;main.c:25: UBYTE shoot(uint8_t x, uint8_t y){
;	---------------------------------
; Function shoot
; ---------------------------------
_shoot::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
;main.c:26: if(missle_moving != 1){
	ld	a, (#_missle_moving)
	dec	a
	jr	Z, 00102$
;main.c:27: move_sprite(1,x,y-8);
	ldhl	sp,	#0
;c:\gbdk\include\gb\gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
;c:\gbdk\include\gb\gb.h:1962: itm->y=y, itm->x=x;
	ld	a, (hl+)
	add	a, #0xf8
	ld	bc, #_shadow_OAM+4
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:28: missle_moving = 1;
	ld	hl, #_missle_moving
	ld	(hl), #0x01
;main.c:30: NR10_REG = 0x16;
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;main.c:31: NR11_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR11_REG + 0), a
;main.c:32: NR12_REG = 0x73;
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;main.c:33: NR13_REG = 0x00;   
	xor	a, a
	ldh	(_NR13_REG + 0), a
;main.c:34: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;main.c:36: return 1;
	ld	a, #0x01
	jr	00104$
00102$:
;main.c:38: return 0;
	xor	a, a
00104$:
;main.c:39: }
	inc	sp
	inc	sp
	ret
;main.c:41: UBYTE brick_hit(uint8_t newX, uint8_t newY){
;	---------------------------------
; Function brick_hit
; ---------------------------------
_brick_hit::
	add	sp, #-8
	ldhl	sp,	#7
	ld	(hl), e
;main.c:47: indexTLx = (newX - 8)/8;
	ldhl	sp,	#3
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, (hl)
	jr	Z, 00105$
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0xffff
	add	hl, de
	ld	c, l
	ld	b, h
00105$:
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:48: indexTLy = (newY - 8)/8;
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	pop	de
	push	de
	ld	hl, #0x0008
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, (hl)
	jr	Z, 00106$
	pop	de
	push	de
	ld	hl, #0xffff
	add	hl, de
	ld	c, l
	ld	b, h
00106$:
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
;main.c:49: tileIndexTL = 20*indexTLy+indexTLx;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
;main.c:51: result = map01[tileIndexTL] == blankmap[0];
	ld	bc,#_map01
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#0
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (#_blankmap + 0)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00128$
	xor	a, a
	sub	a, d
	ld	a, #0x01
	jr	Z, 00129$
00128$:
	xor	a, a
00129$:
	ldhl	sp,	#6
	ld	(hl), a
;main.c:53: if (!result){
	or	a, a
	jr	NZ, 00102$
;main.c:54: set_bkg_tiles(indexTLx,indexTLy,1,1,0x00);
	dec	hl
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (hl)
	ld	hl, #0x0000
	push	hl
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	ld	l, d
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:55: map01[tileIndexTL] = blankmap[0];
	ld	a, (#_blankmap + 0)
	ld	(bc), a
;main.c:56: NR41_REG = 0x1F;
	ld	a, #0x1f
	ldh	(_NR41_REG + 0), a
;main.c:57: NR42_REG = 0xF1;
	ld	a, #0xf1
	ldh	(_NR42_REG + 0), a
;main.c:58: NR43_REG = 0x30;
	ld	a, #0x30
	ldh	(_NR43_REG + 0), a
;main.c:59: NR44_REG = 0xC0;
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
00102$:
;main.c:62: return result;
	ldhl	sp,	#6
	ld	a, (hl)
;main.c:63: }
	add	sp, #8
	ret
;main.c:65: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-5
;main.c:66: NR52_REG = 0x80; // is 1000 0000 in binary and turns on sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:67: NR50_REG = 0x77; // sets the volume for both left and right channel just set to max 0x77
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;main.c:68: NR51_REG = 0xFF; // is 1111 1111 in binary, select which chanels we want to use in this case all of them. One bit for the L one bit for the R of all four channels
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:70: set_bkg_data(0,3, map_tiles);
	ld	de, #_map_tiles
	push	de
	ld	hl, #0x300
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:71: set_bkg_tiles(0,0,20,18,map01);
	ld	de, #_map01
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:73: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:74: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:76: set_sprite_data(0,2,spaceship);
	ld	de, #_spaceship
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
;main.c:82: ship_position.x = 10*8;
	ldhl	sp,	#0
;main.c:83: ship_position.y = 18*8;
	ld	a, #0x50
	ld	(hl+), a
;main.c:85: move_sprite(0,ship_position.x,ship_position.y);
	ld	a, #0x90
	ld	(hl-), a
	ld	c, (hl)
;c:\gbdk\include\gb\gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1962: itm->y=y, itm->x=x;
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), c
;main.c:89: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:91: missle_moving = 0;
	ld	hl, #_missle_moving
	ld	(hl), #0x00
;main.c:93: while(1){
00116$:
;main.c:94: switch(joypad()){
	call	_joypad
	ldhl	sp,#4
	ld	(hl), a
	ld	a, (hl)
	dec	a
	jr	Z, 00102$
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00101$
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00103$
	jr	00106$
;main.c:95: case J_LEFT:
00101$:
;c:\gbdk\include\gb\gb.h:1977: OAM_item_t * itm = &shadow_OAM[nb];
;c:\gbdk\include\gb\gb.h:1978: itm->y+=y, itm->x+=x;
	ld	a, (#_shadow_OAM + 0)
	ld	(#_shadow_OAM),a
	ld	bc, #_shadow_OAM + 1
	ld	a, (bc)
	add	a, #0xf8
	ld	(bc), a
;main.c:97: ship_position.x-=8;
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0xf8
	ld	(hl), a
;main.c:98: break;
	jr	00106$
;main.c:99: case J_RIGHT:
00102$:
;c:\gbdk\include\gb\gb.h:1977: OAM_item_t * itm = &shadow_OAM[nb];
;c:\gbdk\include\gb\gb.h:1978: itm->y+=y, itm->x+=x;
	ld	a, (#_shadow_OAM + 0)
	ldhl	sp,	#4
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl)
	ld	(de), a
	ld	a, (#(_shadow_OAM + 1) + 0)
	ldhl	sp,#4
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x08
	ld	(#(_shadow_OAM + 1)),a
;main.c:101: ship_position.x+=8;
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#0
	ld	(hl), a
;main.c:102: break;
	jr	00106$
;main.c:103: case J_A:
00103$:
;main.c:104: if(shoot(ship_position.x, ship_position.y)){
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
	ld	e, b
	ld	a, c
	call	_shoot
	or	a, a
	jr	Z, 00106$
;main.c:105: missle_position.x = ship_position.x;
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
;main.c:106: missle_position.y = ship_position.y;
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;main.c:109: }
00106$:
;main.c:111: if(missle_moving) {
	ld	a, (#_missle_moving)
	or	a, a
	jr	Z, 00114$
;main.c:112: if(missle_position.y == 0){
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	NZ, 00111$
;main.c:113: missle_moving = 0;
	ld	hl, #_missle_moving
	ld	(hl), #0x00
	jr	00114$
00111$:
;main.c:116: if(!brick_hit(missle_position.x, missle_position.y-9)){
	add	a, #0xf7
	ld	c, a
	ldhl	sp,	#2
	ld	b, (hl)
	ld	e, c
	ld	a, b
	call	_brick_hit
	or	a, a
	jr	NZ, 00108$
;c:\gbdk\include\gb\gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:\gbdk\include\gb\gb.h:1962: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:118: missle_moving = 0;
	ld	hl, #_missle_moving
	ld	(hl), #0x00
	jr	00114$
00108$:
;c:\gbdk\include\gb\gb.h:1977: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #(_shadow_OAM + 4)
;c:\gbdk\include\gb\gb.h:1978: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0xf8
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:122: missle_position.y-=8;
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0xf8
	ld	(hl), a
00114$:
;main.c:127: performant_delay(5);
	ld	a, #0x05
	call	_performant_delay
	jp	00116$
;main.c:129: }
	add	sp, #5
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__map_tiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xd5	; 213
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xd5	; 213
	.db #0xd5	; 213
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xd5	; 213
	.db #0xd5	; 213
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xd5	; 213
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x5a	; 90	'Z'
	.db #0x66	; 102	'f'
	.db #0xe7	; 231
	.db #0x99	; 153
	.db #0xe7	; 231
	.db #0x99	; 153
	.db #0x5a	; 90	'Z'
	.db #0x66	; 102	'f'
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
__xinit__map01:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__spaceship:
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xbd	; 189
	.db #0xa5	; 165
	.db #0xbd	; 189
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x08	; 8
	.area _CABS (ABS)
