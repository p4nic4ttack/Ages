#!/bin/bash
sdasz80 -xlos -g crt0.s
sdcc -o main2.rel -c --std-c11 -mz80 --debug --no-std-crt0 -Iinclude main2.c
sdcc -o z80_lib.rel -c --std-c11 -mz80 --debug --no-std-crt0 -Iinclude lib/z80_lib.c
sdasz80 -plosgffwy main2.rel main2.asm
sdasz80 -plosgffwy z80_lib.rel z80_lib.asm
sdcc -o main2.ihx -mz80 -Wl -y --code-loc 0x0500 --data-loc 0x1000 --std-c11 -mz80 --debug --no-std-crt0 crt0.rel main2.rel z80_lib.rel
sdobjcopy -I ihex -O binary main2.ihx main2.bin
cp main2.bin ../scripts/
#rm *.rel *.sym *.ihx *.noi *.adb *.lst *.asm *.lk *.cdb *.map
