


# Makefile for the project moodlamp

# general
PROJECT=moodlamp

# compiling
SOURCES=main.c
CC=avr-gcc
OBJCOPY=avr-objcopy
MMCU=attiny85
F_CPU=8000000
CFLAGS=-mmcu=$(MMCU) -Wall -DF_CPU=$(F_CPU) -Os

# programming
MMCU_ID=t85
PROGRAMMER=dragon_hvsp
PORT=usb

$(PROJECT).hex: $(PROJECT).out
	$(OBJCOPY) -j .text -O ihex $(PROJECT).out $(PROJECT).hex

$(PROJECT).out: $(SOURCES)
	$(CC) $(CFLAGS) -I./ -o $(PROJECT).out $(SOURCES)

# all command, do compile and flash
all: build_arduino program

# build command, to compile the .hex
build: $(PROJECT).hex $(PROJECT).out
	rm -f $(PROJECT).out

# build arduino command, to compile arduino code (.pde) to .hex
build_arduino:
	make -s -C attiny45_85/cores/attiny45_85/
	make -C attiny45_85/cores/attiny45_85/ clean

# may require root rights for locating usb for programmer
# program command, to write generated hex to mcu
program:
	avrdude -F -p $(MMCU_ID) -c $(PROGRAMMER) -P $(PORT) -U flash:w:$(PROJECT).hex

# fuse command, set fuses on mcu
write_fuse:
	avrdude -p $(MMCU_ID) -c $(PROGRAMMER) -P $(PORT) -U lfuse:w:0xE2:m -U hfuse:w:0xDF:m -U efuse:w:0xFF:m

read_fuse:
	avrdude -p $(MMCU_ID) -c $(PROGRAMMER) -P $(PORT) -U lfuse:r:-:i -U hfuse:r:-:i -U efuse:r:-:i

# clean command, to remove compiled files (.hex .out)
clean:
	rm -f $(PROJECT).out
	rm -f $(PROJECT).hex
