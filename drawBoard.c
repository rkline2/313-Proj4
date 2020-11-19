#include <stdio.h> //printf, scanf //
#include <stdlib.h> //fprint, fgets //
#include <string.h>
#include <math.h>

int main(){
  const char DASH = '-';
  const int LAST_RW = 16, MAX_RW = 4;
  
  char x[4][4] =  {{' ',' ',' ',' '},
		   {' ',' ',' ',' '},
		   {' ',' ',' ',' '},
		   {' ',' ',' ',' '}};

  for (int i =0; i< MAX_RW; i++){
    for(int j=0; j<MAX_RW; j++){

      // last col of the row
      if(((j+1) % MAX_RW) == 0){
	printf(" %c \n", x[i][j]);

	if(i+1 != MAX_RW){
	  // print dashes
	  for (int f = 0; f< 14 + 1; f++){
	    printf("%c", DASH);
	  }
	  printf("\n");
	}
      }
      // normal case
      else{
	printf(" %c |", x[i][j]);
      }
    }
  }

  return 0;
}
