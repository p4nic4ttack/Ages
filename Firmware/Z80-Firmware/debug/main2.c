#include <stdio.h>
#include <stdint.h>
#include <z80_lib.h>
#include <mem_map.h>

#define LED0  LED0

int main(){
	uint8_t *ptr = 0x211;
	while(1){
	*ptr = 1;
	//delay();
	//*ptr = 0;
	//delay();
	LED0 = 0x1;
	/*__asm
	ld a,#0x01;
	out (0x211),a
	__endasm;*/
	delay05s();
	LED0 = 0x0;
	*ptr = 0;
	/*__asm
	ld a,#0x00;
	out (0x211),a
	__endasm;*/
	delay05s();
	}

	return 0;
}

