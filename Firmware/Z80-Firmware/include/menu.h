#ifndef MENU_H
#define MENU_H
#include <stdint.h>
#include <stdbool.h>
#include <z80_lib.h>
#include <ws2812-matrix.h>
#include <joystick.h>
#include <lcd.h>

extern uint8_t menu_fb[];

typedef struct Menu{
	uint8_t choice;
	uint8_t chosen_item;
	bool lcd_drawn;
} Menu;

void init_menu(Menu *);
void draw_menu(Menu *);
void get_menu_input(Menu*);


#endif