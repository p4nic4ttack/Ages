#ifndef WS2812_H
#define WS2812_H
#include <stdint.h>
#include <position.h>
#define FB_SIZE 256
#define MATRIX_SIZE 16
extern volatile uint8_t *fb_ptr;
extern uint8_t framebuffer[FB_SIZE];


void get_framebuffer();
void update_framebuffer(uint8_t fb[]);
void clear_framebuffer();
uint8_t isset(uint8_t,uint8_t);
void set_pixel(uint8_t,uint8_t);
void unset_pixel(uint8_t,uint8_t);
void set_pixel_position(Position*);
void unset_pixel_position(Position*);
#endif