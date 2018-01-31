#include <math.h>
#include <time.h>
#include <stdlib.h>

// MAKE: gcc -o /usr/local/bin/funkeh ./andy.c -lm && /usr/local/bin/funkeh

void rand_str(char *dest, size_t length) {
    char charset[] = "0123456789"
					"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                     "abcdefghijklmnopqrstuvwxyz";

    while (length-- > 0) {
        size_t index = (double) rand() / RAND_MAX * (sizeof charset - 1);
        *dest++ = charset[index];
    }
    *dest = '\0';
}

const int str_len_circ = 38;
const int str_len_surr = 62;
const int str_len_dunn = 7;

char *gen_rando(size_t l) {
	char *rando = malloc(l + 1);
	rand_str(rando, l);
	return rando;
}

c,p,i,j,n,F=40,k,m;float a,x,y,S=0,V=0;main(){
srand(time(NULL)); // Seed random
char *rando = gen_rando(str_len_circ);
char *rando2 = gen_rando(str_len_surr);
char *rando3 = gen_rando(str_len_dunn);
for(;F--;usleep(50000),F?puts(
"\x1b[25A"):0)for(S+=V+=(1-S)/10-V/4,j=0;j<72;j+=3,putchar(10))for(i=0;x=S*(
i-27),i++<73;putchar(c[" ''\".$u$"]))for(c=0,n=3;n--;)for(y=S*(j+n-36),k=0,c
^=(136*x*x+84*y*y<92033)<<n,p=6,m=0;m<8;k++[rando]/1.16-68>x*cos(a)+y*sin(a)?k=p,p="<AFJPTX"[m++]-50:k==p?c^=1<<n,
m=8:0)a=(k[rando2]-79)/14.64;
}
