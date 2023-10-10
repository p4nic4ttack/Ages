#ifndef LCD_H
#define LCD_H

#include <stdint.h>
#include <string.h>
#include <z80_lib.h>
#include <mem_map.h>

//extern uint8_t ascii[];
void init_lcd(void);
void set_x(int x);
void set_y(int y);
void lcd_command_byte(uint8_t val);
void lcd_data_byte(uint8_t val);
//void lcd_byte(uint8_t val);
void lcd_out_char(uint8_t chr);
void lcd_out_str(uint8_t string[], uint8_t, uint8_t);
void lcd_draw(const uint8_t array[],uint8_t x,uint8_t y,uint16_t size);
#endif