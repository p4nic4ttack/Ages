#include "joystick.h"



volatile const uint8_t *joystick2_reg = 0x202;
volatile uint8_t *gamepad2_state = 0x203;

void joystick_isr(void)__naked{
  __asm
  push af
  push bc
  push de
  ld a,#0x00
  in a, (_joystick1)
  ld (0x200),a
  in a, (_joystick2)
  ld (0x202), a
  pop de
  pop bc
  pop af
  ei
  reti
  __endasm;
}

void setup_joystick_isr(void){
  __asm
  push af
  push bc
  push de
  di

  ld hl,#0xF800
  ld de,#0xF801
  ld (hl),#_joystick_isr
  ld bc,#257  
  ldir
  
  ld a, #0xf8
  ld i,a

  ld hl,#_joystick_isr
  ld a,l
  ld (0xf800), a
  ld a, h
  ld (0xf801), a

  im 2
  ei
  pop de
  pop bc
  pop af
  ret
  __endasm;
}

volatile const uint8_t *joystick1_reg = 0x200;
volatile uint8_t *gamepad_state = 0x201;

ButtonState poll_button(Button btn){
  if(*joystick1_reg & (1 << btn) && !(*gamepad_state & (1 << btn)) ){
    *gamepad_state |= (1 << btn);
    return BTN_PRESSED;
  }
  else if(*joystick1_reg & (1 << btn) && *gamepad_state & (1 << btn)){
    return BTN_HOLD;
  }
  else if( !(*joystick1_reg & (1<<btn)) && *gamepad_state & (1<<btn)){
    *gamepad_state &= ~(1 << btn);
    return BTN_RELEASE;
  }
  else if(!(*joystick1_reg & (1<<btn)) && !(*gamepad_state & (1<<btn))){
    return BTN_IDLE;
  }
  else{
    return BTN_IDLE;
  }
}

ButtonState a_pressed(void){
  return poll_button( (Button)A );
}

ButtonState b_pressed(void){
  return poll_button( (Button)B );
}

ButtonState c_pressed(void){
  return poll_button( (Button)C );
}

ButtonState up_pressed(void){
  return poll_button( (Button)UP );
}

ButtonState dwn_pressed(void){
  return poll_button( (Button)DOWN );
}

ButtonState lft_pressed(void){
  return poll_button( (Button)LEFT );
}

ButtonState rgt_pressed(void){
  return poll_button( (Button)RIGHT );
}

ButtonState sel_pressed(void){
  return poll_button( (Button)SELECT );
}


ButtonState poll2_button(Button btn){
  if(*joystick2_reg & (1 << btn) && !(*gamepad2_state & (1 << btn)) ){
    *gamepad2_state |= (1 << btn);
    return BTN_PRESSED;
  }
  else if(*joystick2_reg & (1 << btn) && *gamepad2_state & (1 << btn)){
    return BTN_HOLD;
  }
  else if( !(*joystick2_reg & (1<<btn)) && *gamepad2_state & (1<<btn)){
    *gamepad2_state &= ~(1 << btn);
    return BTN_RELEASE;
  }
  else if(!(*joystick2_reg & (1<<btn)) && !(*gamepad2_state & (1<<btn))){
    return BTN_IDLE;
  }
  else{
    return BTN_IDLE;
  }
}

ButtonState a2_pressed(void){
  return poll2_button( (Button)A );
}

ButtonState b2_pressed(void){
  return poll2_button( (Button)B );
}

ButtonState c2_pressed(void){
  return poll2_button( (Button)C );
}

ButtonState up2_pressed(void){
  return poll2_button( (Button)UP );
}

ButtonState dwn2_pressed(void){
  return poll2_button( (Button)DOWN );
}

ButtonState lft2_pressed(void){
  return poll2_button( (Button)LEFT );
}

ButtonState rgt2_pressed(void){
  return poll2_button( (Button)RIGHT );
}

ButtonState sel2_pressed(void){
  return poll2_button( (Button)SELECT );
}
