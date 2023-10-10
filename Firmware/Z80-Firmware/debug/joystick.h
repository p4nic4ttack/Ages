#ifndef JOYSTICK_H
#define JOYSTICK_H
#include <stdint.h>
#include "mem_map.h"
#define RETI __asm reti __endasm;

extern volatile uint8_t *joystick_reg_a;
extern volatile uint8_t *joystick_reg_b;
extern volatile uint8_t *joystick_reg_c;
extern volatile uint8_t *joystick_reg_up;
extern volatile uint8_t *joystick_reg_dwn;
extern volatile uint8_t *joystick_reg_lft;
extern volatile uint8_t *joystick_reg_rgt;
extern volatile uint8_t *joystick_reg_sel;

void setup_joystick_isr(void);
/*void joystick_a_press_isr(void)__naked;
void joystick_b_press_isr(void)__naked;
void joystick_c_press_isr(void)__naked;
void joystick_up_press_isr(void)__naked;
void joystick_dwn_press_isr(void)__naked;
void joystick_lft_press_isr(void)__naked;
void joystick_rgt_press_isr(void)__naked;
void joystick_sel_press_isr(void)__naked;
void joystick_a_release_isr(void)__naked;
void joystick_b_release_isr(void)__naked;
void joystick_c_release_isr(void)__naked;
void joystick_up_release_isr(void)__naked;
void joystick_dwn_release_isr(void)__naked;
void joystick_lft_release_isr(void)__naked;
void joystick_rgt_release_isr(void)__naked;
void joystick_sel_release_isr(void)__naked;*/
void joystick_isr(void)__naked;
#endif
