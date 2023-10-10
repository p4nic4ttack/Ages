#include "joystick.h"

volatile uint8_t *joystick_reg_a = 0x200;
volatile uint8_t *joystick_reg_b = 0x201;
volatile uint8_t *joystick_reg_c = 0x202;
volatile uint8_t *joystick_reg_up = 0x203;
volatile uint8_t *joystick_reg_dwn = 0x204;
volatile uint8_t *joystick_reg_lft = 0x205;
volatile uint8_t *joystick_reg_rgt = 0x206;
volatile uint8_t *joystick_reg_sel = 0x207;

/*void joystick_a_press_isr(void) __naked{
  //*joystick_reg_a |= (1<<0);
  *joystick_reg_a |= (1<<0);
  RETI;
}

void joystick_b_press_isr(void) __naked{
  *joystick_reg_b |= (1<<0);
  RETI;
}

void joystick_c_press_isr(void) __naked{
  *joystick_reg_c |= (1<<0);
  RETI;
}

void joystick_up_press_isr(void)__naked{
  *joystick_reg_up |= (1<<0);
  RETI;
}

void joystick_dwn_press_isr(void)__naked{
  *joystick_reg_dwn |= (1<<0);
  RETI;
}

void joystick_lft_press_isr(void)__naked{
  *joystick_reg_lft |= (1<<0);
  RETI;
}

void joystick_rgt_press_isr(void)__naked{
  *joystick_reg_rgt |= (1<<0);
  RETI;
}

void joystick_sel_press_isr(void)__naked{
  *joystick_reg_sel |= (1<<0);
  RETI;
}

void joystick_a_release_isr(void) __naked{
  //*joystick_reg_a |= (1<<0);
  *joystick_reg_a &= ~(1<<0);
  RETI;
}

void joystick_b_release_isr(void) __naked{
  *joystick_reg_b &= ~(1<<0);
  RETI;
}

void joystick_c_release_isr(void) __naked{
  *joystick_reg_c &= ~(1<<0);
  RETI;
}

void joystick_up_release_isr(void)__naked{
  *joystick_reg_up &= ~(1<<0);
  RETI;
}

void joystick_dwn_release_isr(void)__naked{
  *joystick_reg_dwn &= ~(1<<0);
  RETI;
}

void joystick_lft_release_isr(void)__naked{
  *joystick_reg_lft &= ~(1<<0);
  RETI;
}

void joystick_rgt_release_isr(void)__naked{
  *joystick_reg_rgt &= ~(1<<0);
  RETI;
}

void joystick_sel_release_isr(void)__naked{
  *joystick_reg_sel &= ~(1<<0);
  RETI;
}

void setup_joystick_isr(void){
  __asm
  push af
  push bc

  di

  ld hl,#0xF800
  ld de,#0xF801
  ld (hl),#_joystick_a_press_isr
  ld bc,#257  
  ldir

  ld hl,#0xF802
  ld de,#0xF803
  ld (hl),#_joystick_b_press_isr
  ld bc,#257 
  ldir

  ld hl,#0xF804
  ld de,#0xF805
  ld (hl),#_joystick_c_press_isr
  ld bc,#257 
  ldir

  ld hl,#0xF806
  ld de,#0xF807
  ld (hl),#_joystick_up_press_isr
  ld bc,#257 
  ldir

  ld hl,#0xF808
  ld de,#0xF809
  ld (hl),#_joystick_dwn_press_isr
  ld bc,#257 
  ldir

  ld hl,#0xF80A
  ld de,#0xF80B
  ld (hl),#_joystick_lft_press_isr
  ld bc,#257 
  ldir

  ld hl,#0xF80C
  ld de,#0xF80D
  ld (hl),#_joystick_rgt_press_isr
  ld bc,#257 
  ldir

  ld hl,#0xF80E
  ld de,#0xF80F
  ld (hl),#_joystick_sel_press_isr
  ld bc,#257 
  ldir

  ld hl,#0xF810
  ld de,#0xF811
  ld (hl),#_joystick_a_release_isr
  ld bc,#257 
  ldir

  ld hl,#0xF812
  ld de,#0xF813
  ld (hl),#_joystick_b_release_isr
  ld bc,#257 
  ldir

  ld hl,#0xF814
  ld de,#0xF815
  ld (hl),#_joystick_c_release_isr
  ld bc,#257 
  ldir

  ld hl,#0xF816
  ld de,#0xF817
  ld (hl),#_joystick_up_release_isr
  ld bc,#257 
  ldir

  ld hl,#0xF818
  ld de,#0xF819
  ld (hl),#_joystick_dwn_release_isr
  ld bc,#257 
  ldir

  ld hl,#0xF81a
  ld de,#0xF81b
  ld (hl),#_joystick_lft_release_isr
  ld bc,#257 
  ldir

  ld hl,#0xF81c
  ld de,#0xF81d
  ld (hl),#_joystick_rgt_release_isr
  ld bc,#257 
  ldir

  ld hl,#0xF81e
  ld de,#0xF81f
  ld (hl),#_joystick_sel_release_isr
  ld bc,#257 
  ldir

  ld a, #0xf8
  ld i,a

  ld hl,#_joystick_a_press_isr
  ld a,l
  ld (0xf800), a
  ld a, h
  ld (0xf801), a

  ld hl,#_joystick_b_press_isr
  ld a,l
  ld (0xf802), a
  ld a, h
  ld (0xf803), a

  ld hl,#_joystick_c_press_isr
  ld a,l
  ld (0xf804), a
  ld a, h
  ld (0xf805), a

  ld hl,#_joystick_up_press_isr
  ld a,l
  ld (0xf806), a
  ld a, h
  ld (0xf807), a

  ld hl,#_joystick_dwn_press_isr
  ld a,l
  ld (0xf808), a
  ld a, h
  ld (0xf809), a

  ld hl,#_joystick_lft_press_isr
  ld a,l
  ld (0xf80a), a
  ld a, h
  ld (0xf80b), a

  ld hl,#_joystick_rgt_press_isr
  ld a,l
  ld (0xf80c), a
  ld a, h
  ld (0xf80d), a

  ld hl,#_joystick_sel_press_isr
  ld a,l
  ld (0xf80e), a
  ld a, h
  ld (0xf80f), a

  ld hl,#_joystick_a_release_isr
  ld a,l
  ld (0xf810), a
  ld a, h
  ld (0xf811), a

  ld hl,#_joystick_b_release_isr
  ld a,l
  ld (0xf812), a
  ld a, h
  ld (0xf813), a

  ld hl,#_joystick_c_release_isr
  ld a,l
  ld (0xf814), a
  ld a, h
  ld (0xf815), a

  ld hl,#_joystick_up_release_isr
  ld a,l
  ld (0xf816), a
  ld a, h
  ld (0xf817), a

  ld hl,#_joystick_dwn_release_isr
  ld a,l
  ld (0xf818), a
  ld a, h
  ld (0xf819), a

  ld hl,#_joystick_lft_release_isr
  ld a,l
  ld (0xf81a), a
  ld a, h
  ld (0xf81b), a

  ld hl,#_joystick_rgt_release_isr
  ld a,l
  ld (0xf81c), a
  ld a, h
  ld (0xf81d), a

  ld hl,#_joystick_sel_release_isr
  ld a,l
  ld (0xf81e), a
  ld a, h
  ld (0xf81f), a

  im 2
  ei

  pop bc
  pop af
  ret
  __endasm;
}*/
void joystick_isr(void)__naked{
  __asm
  push af
  push bc
  push de
  ld a,#0x00
  in a, (0xff)
  ld (0x200),a
  pop de
  pop bc
  pop af
  reti
  __endasm;
}

void setup_joystick_isr(void){
  __asm
  push af
  push bc

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

  pop bc
  pop af
  ret
  __endasm;
}