#include <stdio.h>
#include <unistd.h>

int foo (int *a, int *b)
{
	*a = *b; *b = 4; return 0;
}

int main (void)
{
	int a, b;
	a = 1;
	b = 2;
	sleep(40);
	foo (&a, &b);
	printf ("Value a: %d, Value b: %d\n", a, b);
	return 0;
}
