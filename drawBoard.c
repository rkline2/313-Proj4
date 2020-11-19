#include <stdio.h> //printf, scanf //
#include <stdlib.h> //fprint, fgets //
#include <string.h>
#include <math.h>

void printTble (char x[16]){
  const char DASH = '-';
  const int MAX_RW = 4,
    MAX_ELM = 16, MAX_DSH = 14;
  /* this is the expected array for x   
  char x[16] =  {' ',' ',' ',' ',
		 ' ',' ',' ',' ',
		 ' ',' ',' ',' ',
		 ' ',' ',' ',' '};
  */
  for (int i = 0; i < MAX_ELM; i++){
      // last col of the row case
      if(((i+1) % MAX_RW) == 0){
	printf(" %c \n", x[i]);

	// print dashes
	if(i+1 != MAX_ELM){
	  for (int f = 0; f < MAX_DSH + 1; f++){
	    printf("%c", DASH);
	  }
	  printf("\n");
	}
	
      }
      // normal case
      else{
	printf(" %c |", x[i]);
      }
    }
  
}
