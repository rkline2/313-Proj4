OBJS = askLocation.o compEasy.o drawBoard.o randomNum.o test2_main.o checkWinner.o
ASSFLAGS = nasm -f elf64
CXX = gcc -m64


all: $(OBJS)
	$(CXX) $(OBJS) -o test

askLocation.o: askLocation.asm
	$(ASSFLAGS) askLocation.asm

compEasy.o: compEasy.asm
	$(ASSFLAGS) compEasy.asm

drawBoard.o: drawBoard.c
	gcc -c drawBoard.c

randomNum.o: randomNum.asm
	$(ASSFLAGS) randomNum.asm

checkWinner.o: checkWinner.asm
	$(ASSFLAGS) checkWinner.asm

test2_main.o: test2_main.asm
	$(ASSFLAGS) test2_main.asm

clean:
	rm -rf *.o
	rm -rf test
	rm -f *~ *#
