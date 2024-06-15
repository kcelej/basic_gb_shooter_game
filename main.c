#include <gb/gb.h>
#include <stdio.h>

#include "map_tiles.c"
#include "map01.c"

#include "spaceship.c"

const char blankmap[1] = {0x00};

void performant_delay(uint8_t number_of_loops){
    uint8_t i;
    for(i = 0; i< number_of_loops; i++){
        wait_vbl_done();
    }
}

typedef struct pos{
    uint8_t x;
    uint8_t y;
} pos;

UBYTE missle_moving;

UBYTE shoot(uint8_t x, uint8_t y){
    if(missle_moving != 1){
        move_sprite(1,x,y-8);
        missle_moving = 1;

        NR10_REG = 0x16;
        NR11_REG = 0x40;
        NR12_REG = 0x73;
        NR13_REG = 0x00;   
        NR14_REG = 0xC3;

        return 1;
    }
    return 0;
}

UBYTE brick_hit(uint8_t newX, uint8_t newY){
    uint16_t indexTLx, indexTLy, tileIndexTL;
    UBYTE result;
    
    uint16_t buff;

    indexTLx = (newX - 8)/8;
    indexTLy = (newY - 8)/8;
    tileIndexTL = 20*indexTLy+indexTLx;

    result = map01[tileIndexTL] == blankmap[0];

    if (!result){
        set_bkg_tiles(indexTLx,indexTLy,1,1,0x00);
        map01[tileIndexTL] = blankmap[0];
        NR41_REG = 0x1F;
        NR42_REG = 0xF1;
        NR43_REG = 0x30;
        NR44_REG = 0xC0;
    }

    return result;
}

void main() {
    NR52_REG = 0x80; // is 1000 0000 in binary and turns on sound
    NR50_REG = 0x77; // sets the volume for both left and right channel just set to max 0x77
    NR51_REG = 0xFF; // is 1111 1111 in binary, select which chanels we want to use in this case all of them. One bit for the L one bit for the R of all four channels

    set_bkg_data(0,3, map_tiles);
    set_bkg_tiles(0,0,20,18,map01);

    SHOW_BKG;
    DISPLAY_ON;

    set_sprite_data(0,2,spaceship);
    set_sprite_tile(0,0);   //spaceship

    set_sprite_tile(1,1);   //spaceship missle
    
    pos ship_position;
    ship_position.x = 10*8;
    ship_position.y = 18*8;
    
    move_sprite(0,ship_position.x,ship_position.y);

    pos missle_position;

    SHOW_SPRITES;

    missle_moving = 0;

    while(1){
        switch(joypad()){
            case J_LEFT:
                scroll_sprite(0,-8,0);
                ship_position.x-=8;
                break;
            case J_RIGHT:
                scroll_sprite(0,8,0);
                ship_position.x+=8;
                break;
            case J_A:
                if(shoot(ship_position.x, ship_position.y)){
                    missle_position.x = ship_position.x;
                    missle_position.y = ship_position.y;
                }
                break;
        }

        if(missle_moving) {
            if(missle_position.y == 0){
                missle_moving = 0;
            }
            else{
                if(!brick_hit(missle_position.x, missle_position.y-9)){
                     move_sprite(1,0,0);
                     missle_moving = 0;
                }
                else {
                    scroll_sprite(1,0,-8);
                    missle_position.y-=8;
                }
            }
        }

        performant_delay(5);
    }
}