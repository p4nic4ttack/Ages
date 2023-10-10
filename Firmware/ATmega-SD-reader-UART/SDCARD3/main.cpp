#include <avr/io.h>
#include <util/delay.h>
#include <string.h>
#include <stdlib.h>
#include "sdcard/ff.h"
#include "sdcard/integer.h"


#define MIN(a,b) (((a)<(b))?(a):(b))
#define F_CPU 8000000UL
#define BAUD_RATE 38400
#define BAUD_PRESCALER (((F_CPU / (BAUD_RATE * 16UL))) - 1)

FATFS FatFs;	// FatFs work area
FIL *fp;

void uart_init()
{
	// Set baud rate
	UBRR0 = BAUD_PRESCALER;
	// Enable receiver and transmitter
	UCSR0B = (1 << RXEN0) | (1 << TXEN0);
	// Set frame format: 8 data bits, no parity, 1 stop bit
	UCSR0C = (0 << USBS0) | (1 << UCSZ00) | (1 << UCSZ01);
}

void USART_Transmit( unsigned char data )
{
	/* Wait for empty transmit buffer */
	while ( !( UCSR0A & (1<<UDRE0)) )
	;
	/* Put data into buffer, sends the data */
	UDR0 = data;
}

DWORD get_fattime (void)
{
	// Returns current time packed into a DWORD variable
	return	  ((DWORD)(2013 - 1980) << 25)	// Year 2013
	| ((DWORD)8 << 21)				// Month 7
	| ((DWORD)2 << 16)				// Mday 28
	| ((DWORD)20 << 11)				// Hour 0..24
	| ((DWORD)30 << 5)				// Min 0
	| ((DWORD)0 >> 1);				// Sec 0
}

int main(void)
{
	uart_init();
	UINT bw;
	f_mount(0, &FatFs);
	fp = (FIL *)malloc(sizeof (FIL));
	if (f_open(fp, "fntcol.bin", FA_READ ) == FR_OK) {
		//entered = 1;
		UINT br;
		uint8_t buffer[512];
		
		while (f_read(fp, buffer, sizeof(buffer), &br) == FR_OK && br > 0) {
			for(int i = 0; i < 512; i++){
				USART_Transmit(buffer[i]);
			}
		}
		// Close the file
		f_close(fp);
	}
	
    /* Replace with your application code */
    while (1) 
    {
    }
}

