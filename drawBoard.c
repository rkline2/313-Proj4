#include <stdio.h> //printf, scanf //
#include <stdlib.h> //fprint, fgets //
#include <string.h>
#include <math.h>

int main(){
  const char DASH = '-';
  const int LAST_RW = 16;
  char x[16][3] = {" "," "," "," ",
		   " "," "," "," ",
		   " "," "," "," ",
		   " "," "," "," "};
  
  for(int i=0; i<16; i++){
    // last value of the row
    if(((i+1) % 4) == 0){
      printf("%s \n", x+i);
      
      if(i+1 != LAST_RW){
	// print dashes
	for (int j = 0; j<7; j++){       
	    printf("%c", DASH);
	}
	printf("\n");
      }
    }
    
    // normal case 
    else{
    printf("%s|", x+i);
    }
  }
  return 0;
}
