#include <ws2812-matrix.h>

volatile uint8_t *fb_ptr = 0x9000;
uint8_t framebuffer[256];

void clear_framebuffer(){
	for(uint16_t i = 0; i < FB_SIZE; i++){
		framebuffer[i] = 0x00;
	}
}

void update_framebuffer(uint8_t fb[]){
	for(uint16_t i = 0; i < FB_SIZE; i++){
		*(fb_ptr + i) = fb[i];
	}
}

void get_framebuffer(){
	for(int i = 0; i < FB_SIZE; i++){
		framebuffer[i] = *(fb_ptr + i);
  	}
}

uint8_t isset(uint8_t x,uint8_t y){
	if(y%2==0)
		return framebuffer[(16*y)+x] == 0xff ? 1 : 0;
	else
		return framebuffer[(16*y)+(15-x)] == 0xff ? 1 : 0;
}

void set_pixel(uint8_t x, uint8_t y){
	if(y%2==0)
		framebuffer[(16*y)+x] = 0xff;
	else
		framebuffer[(16*y)+(15-x)] = 0xff;
}

void set_pixel_position(Position *pos){
	if(pos->y % 2 == 0)
		framebuffer[(16*pos->y)+pos->x] = 0xff;
	else
		framebuffer[(16*pos->y)+(15 - pos->x)] = 0xff;
}

void unset_pixel(uint8_t x, uint8_t y){
	if(y%2==0)
		framebuffer[(16*y)+x] = 0x00;
	else
		framebuffer[(16*y)+(15-x)] = 0x00;
}

void unset_pixel_position(Position *pos){
	if(pos->y % 2 == 0)
		framebuffer[(16*pos->y)+pos->x] = 0x00;
	else
		framebuffer[(16*pos->y)+(15 - pos->x)] = 0x00;
}