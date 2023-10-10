#!/bin/bash
sdasz80 -xlos -g crt0.s
sdcc -o main.rel -c --std-c11  --stack-probe -mz80 --debug --no-std-crt0 -Iinclude main.c
sdcc -o z80_lib.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/z80_lib.c
sdcc -o joystick.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/joystick.c
sdcc -o ws2812b-matrix.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/ws2812-matrix.c
sdcc -o position.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/position.c
sdcc -o snake.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/snake.c
sdcc -o brick_breaker.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/brick_breaker.c
sdcc -o menu.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/menu.c
sdcc -o lcd.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/lcd.c
sdcc -o pong.rel -c --std-c11 --stack-probe -mz80 --debug --no-std-crt0 -Iinclude lib/pong.c
sdasz80 -plosgffwy  main.rel main.asm
sdasz80 -plosgffwy z80_lib.rel z80_lib.asm
sdasz80 -plosgffwy joystick.rel joystick.asm
sdasz80 -plosgffwy ws2812b-matrix.rel ws2812b-matrix.asm
sdasz80 -plosgffwy position.rel position.asm
sdasz80 -plosgffwy snake.rel snake.asm
sdasz80 -plosgffwy brick_breaker.rel brick_breaker.asm
sdasz80 -plosgffwy menu.rel menu.asm
sdasz80 -plosgffwy lcd.rel lcd.asm
sdasz80 -plosgffwy pong.rel pong.asm
sdcc -o main.ihx -mz80 -Wl -y --code-loc 0x0500 --data-loc 0x5000 --std-c11 --stack-probe -mz80 --debug --no-std-crt0 crt0.rel main.rel z80_lib.rel joystick.rel ws2812b-matrix.rel position.rel snake.rel brick_breaker.rel menu.rel lcd.rel pong.rel
sdobjcopy -I ihex -O binary main.ihx main.bin
cp main.bin ../../../../Downloads/main.bin
rm *.rel *.sym *.ihx *.noi *.adb *.lst *.asm *.lk *.cdb *.map
