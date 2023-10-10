#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <joystick.h>
#include <z80_lib.h>
#include <ws2812-matrix.h>
#include <menu.h>
#include <brick_breaker.h>
#include <snake.h>
#include <pong.h>
#include <lcd.h>

const uint8_t *led_reg = 0x210;


typedef enum Views{
  MENU,
  SNAKE,
  BB,
  PONG
} Views;

void game_over_loop(void);


uint8_t  game_over_screen[FB_SIZE];
int main(){
  init_lcd();
  srand(time(NULL));
  setup_joystick_isr();
  get_framebuffer();
  for(uint16_t i = 0; i < 256; i++)
    game_over_screen[i] = framebuffer[i];
  clear_framebuffer();

  Views view = MENU;
  Menu menu;
  
  init_menu(&menu);
  while(1){
    __asm
    im 2
    ei
    __endasm;
    if(view == MENU){
      draw_menu(&menu);
      get_menu_input(&menu);
      if(menu.chosen_item == 0){
        view = SNAKE;
      }
      else if(menu.chosen_item == 1){
        view = BB;
      }else if(menu.chosen_item == 2){
        view = PONG;
      }
    }
    else if(view == SNAKE){
      main_snake_loop();
      game_over_loop();
      init_menu(&menu);
      view = MENU;
    }
    else if(view == BB){
      main_brickbreaker_loop();
      game_over_loop();
      init_menu(&menu);
      view = MENU;
    }
    else if(view == PONG){
      main_pong_loop();
      ButtonState sel = sel_pressed();
      do{
        sel = sel_pressed();
      }while(sel != BTN_HOLD);
      init_menu(&menu);
      view = MENU;
    }


    LED0 = 1;
    for(uint8_t i = 0; i < 1; i++){
      delay10us();
    }
    LED0 = 0;
    for(uint8_t i = 0; i < 1; i++){
      delay10us();
    }

  }
  return 0;
}

void game_over_loop(void){
  ButtonState select;
  bool toggle = false;
  do{
    clear_framebuffer();
    update_framebuffer(game_over_screen);
    if(!toggle){
      toggle = true;
      lcd_out_str("            ", 10, 5);
    }else{
      toggle = false;
      lcd_out_str("Game over...", 10, 5);
    }
    for(uint8_t i = 0; i < 100; i++)
      delay1ms();
      select = sel_pressed();
    }while(select != BTN_HOLD);
}