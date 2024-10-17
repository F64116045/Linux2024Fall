#include "../include/reverse.h"
char *reverse(char *dest, const char *src) 
{
	//FIX ME
    int last = 0;
    while(1){
        if(src[last] == '\0')
            break;
        else
            last ++;
    }
    int j = 0;
    for(int i = last - 1 ; i >= 0 ; i--)
        dest[j++] = src[i];

    return dest;
}
