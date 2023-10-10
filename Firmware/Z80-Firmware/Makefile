# Makefile for Z80 project

# Compiler and assembler options
ASFLAGS = -xlos -g
CFLAGS = --std-c11 -mz80 --debug --no-std-crt0 -Iinclude
LDFLAGS = -mz80 -Wl -y --code-loc 0x0500 --data-loc 0x1000 --std-c11 --debug --no-std-crt0

# Object file dependencies
DEPS = crt0.s include/z80_lib.h lib/z80_lib.c include/joystick.h lib/joystick.c include/brick_breaker.h lib/brick_breaker.c include/lcd.h lib/lcd.c include/mem_map.h include/menu.h lib/menu.c include/pong.h lib/pong.c include/position.h lib/position.c include/snake.h lib/snake.c include/ws2812-matrix.h lib/ws2812-matrix.c main.c

all: main.bin

# Compile CRT0 assembly file
crt0.rel: crt0.s
	sdasz80 $(ASFLAGS) $<

# Compile main C file
main.rel: main.c
	sdcc $(CFLAGS) -c $< -o $@

# Compile z80_lib C file
z80_lib.rel: lib/z80_lib.c include/z80_lib.h
	sdcc $(CFLAGS) -c $< -o $@

joystick.rel: lib/joystick.c include/joystick.h
	sdcc $(CFLAGS) -c $< -o $@

brick_breaker.rel: lib/brick_breaker.c include/brick_breaker.h
	sdcc $(CFLAGS) -c $< -o $@

lcd.rel: lib/lcd.c include/lcd.h
	sdcc $(CFLAGS) -c $< -o $@

menu.rel: lib/menu.c include/menu.h
	sdcc $(CFLAGS) -c $< -o $@

pong.rel: lib/pong.c include/pong.h
	sdcc $(CFLAGS) -c $< -o $@

snake.rel: lib/snake.c include/snake.h
	sdcc $(CFLAGS) -c $< -o $@

position.rel: lib/position.c include/position.h
	sdcc $(CFLAGS) -c $< -o $@

ws2812-matrix.rel: lib/ws2812-matrix.c include/ws2812-matrix.h
	sdcc $(CFLAGS) -c $< -o $@

# Generate assembly files from object files
main.asm: main.rel
	sdasz80 -plosgffwy $< $@

z80_lib.asm: z80_lib.rel
	sdasz80 -plosgffwy $< $@

joystick.asm: joystick.rel
	sdasz80 -plosgffwy $< $@

brick_breaker.asm: brick_breaker.rel
	sdasz80 -plosgffwy $< $@

lcd.asm: lcd.rel
	sdasz80 -plosgffwy $< $@

menu.asm: menu.rel
	sdasz80 -plosgffwy $< $@

pong.asm: pong.rel
	sdasz80 -plosgffwy $< $@

snake.asm: snake.rel
	sdasz80 -plosgffwy $< $@

position.asm: position.rel
	sdasz80 -plosgffwy $< $@

ws2812-matrix.asm: ws2812-matrix.rel
	sdasz80 -plosgffwy $< $@

# Link object files and generate ihx file
main.ihx: crt0.rel main.rel z80_lib.rel joystick.rel brick_breaker.rel lcd.rel menu.rel pong.rel snake.rel position.rel ws2812-matrix.rel
	sdcc $(LDFLAGS) $^ -o $@

# Convert ihx file to binary
main.bin: main.ihx
	sdobjcopy -I ihex -O binary $< $@

clean:
	rm -f *.rel *.sym *.ihx *.noi *.adb *.lst *.asm *.lk *.cdb *.map
