#ifndef Z80_LIB_H
#define Z80_LIB_H
#include <stdint.h>
#include "mem_map.h"

// Delays
void delay10us()__naked;
void delay1ms()__naked;
void delay250ms()__naked;
void delay(uint32_t);

// Interrupts
void reenable_isr_mode2(void)__naked;
#endif
