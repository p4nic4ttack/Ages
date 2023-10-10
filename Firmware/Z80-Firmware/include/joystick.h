#ifndef JOYSTICK_H
#define JOYSTICK_H
#include <stdint.h>
#include <z80_lib.h>
#include "mem_map.h"
#define RETI __asm reti __endasm;

extern volatile const uint8_t *joystick1_reg;
extern volatile uint8_t *gamepad_state;

extern volatile const uint8_t *joystick2_reg;
extern volatile uint8_t *gamepad2_state;

typedef enum ButtonState{
	BTN_PRESSED,
	BTN_HOLD,
	BTN_RELEASE,
	BTN_IDLE
} ButtonState;

typedef enum Button{
	A,
	B,
	C,
	UP,
	DOWN,
	LEFT,
	RIGHT,
	SELECT
} Button;

void setup_joystick_isr(void);
void joystick_isr(void)__naked;

ButtonState poll_button(Button);

ButtonState a_pressed(void);
ButtonState b_pressed(void);
ButtonState c_pressed(void);
ButtonState up_pressed(void);
ButtonState dwn_pressed(void);
ButtonState lft_pressed(void);
ButtonState rgt_pressed(void);
ButtonState sel_pressed(void);

ButtonState poll2_button(Button);

ButtonState a2_pressed(void);
ButtonState b2_pressed(void);
ButtonState c2_pressed(void);
ButtonState up2_pressed(void);
ButtonState dwn2_pressed(void);
ButtonState lft2_pressed(void);
ButtonState rgt2_pressed(void);
ButtonState sel2_pressed(void);
#endif
