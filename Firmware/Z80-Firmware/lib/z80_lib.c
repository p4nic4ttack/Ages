#include <z80_lib.h>

void delay10us()__naked{
  __asm
    push af
    push bc
    push de
  #ifdef CLK_125e5
     ld b, #0x8 // 7 cycles
  #else // else CLK = 25MHz
     ld b, #0x11
  #endif
     loop2$:
          dec b // 4 cycles
          jp nz, loop2$ // 10 cycles
     pop de
     pop bc
     pop af
     ret // 10 cycles 
  __endasm;
}

void delay1ms()__naked{
  __asm
    push af
    push bc
    push de
  #ifdef CLK_125e5
      ld c, #0x57 // 7 cycles
  #else
      ld c, #0x58
  #endif
      delay1ms1:
        call _delay10us // 17 cycles + 507 cycles
        dec c // 4 cycles
        jp nz, delay1ms1 // 10 cycles
    pop de
    pop bc
    pop af
    ret // 10 cycles
  __endasm;
}

void delay250ms()__naked{
  __asm
    push af
    push bc
    push de
  	ld d, #0xf8 // 7 cycles
  	delay02s1:
  	  call _delay1ms // 17 cycles + 50051 cycles
  	  dec d // 4 cycles
  	  jp nz, delay02s1 // 10 cycles
    pop de
    pop bc
    pop af
    ret // 10 cycles
  __endasm;
}

void delay05s()__naked{
  __asm
  push af
  push bc
  push de
  call _delay250ms
  call _delay250ms
  pop de
  pop bc
  pop af
  ret
  __endasm;
}

void delay(uint32_t time){
    //12.5MHz --> 80ns per pulse (0.00000008)
    //6720ns per while
    //149 for 1ms
    //1488 for 10ms
    //37202 for 250ms
    //74404 for 0.5s
    //148809 for 1s
  while(--time);
}

void reenable_isr_mode2(void) __naked{
  __asm
  ;push af
  ;push bc
    

  im 2
  ei

  ;pop bc
  ;pop af
  ;ret
  __endasm;
}

