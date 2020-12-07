OBJS = menu.o askLocation.o compEasy.o compHard.o drawBoard.o randomNum.o main.o checkWinner.o o_marks_the_spot.o
ASSFLAGS = nasm -f elf64
CXX = gcc -m64


all: $(OBJS)
	$(CXX) $(OBJS) -o test

menu.o: menu.asm
	$(ASSFLAGS) menu.asm

askLocation.o: askLocation.asm
	$(ASSFLAGS) askLocation.asm

compEasy.o: compEasy.asm
	$(ASSFLAGS) compEasy.asm

compHard.o: compHard.asm
	$(ASSFLAGS) compHard.asm

drawBoard.o: drawBoard.c
	gcc -c drawBoard.c

randomNum.o: randomNum.asm
	$(ASSFLAGS) randomNum.asm

checkWinner.o: checkWinner.asm
	$(ASSFLAGS) checkWinner.asm

o_marks_the_spot.o: o_marks_the_spot.asm
	$(ASSFLAGS) o_marks_the_spot.asm

main.o: main.asm
	$(ASSFLAGS) main.asm

clean:
	rm -rf *.o
	rm -rf test
	rm -f *~ *#
