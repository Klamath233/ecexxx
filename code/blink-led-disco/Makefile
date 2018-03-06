ARMGNU = arm-none-eabi
FLASHER = st-flash

all: blink.bin

blink.bin: blink.elf
	$(ARMGNU)-objcopy blink.elf blink.bin -O binary

blink.elf: blink.o memmap
	$(ARMGNU)-ld -o blink.elf -T memmap blink.o

blink.o: blink.s
	$(ARMGNU)-as blink.s -o blink.o

flash: blink.bin
	$(FLASHER) write blink.bin 0x08000000

.PHONY: clean
clean:
	rm -f *.o *.elf *.bin

erase:
	$(FLASHER) erase