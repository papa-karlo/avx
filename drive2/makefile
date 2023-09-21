#makefile for drive2.asm

drive2: drive2.o
	gcc -o drive2 drive2.o -no-pie
drive2.o: drive2.asm
	nasm -f elf64 -g -F dwarf drive2.asm -l drive2.lst

