#include <stdio.h>

int main()
{
	int len = 1, n, num[256] = { 1 };
	scanf("%d", &n);
	while (n)
	{
		for (int i = 0; i < len; i ++)
			num[i] *= n;
		for (int i = 0; i < len; i ++)
			num[i+1] += num[i] / 1000000, num[i] %= 1000000;
		if (num[len]) len ++;
		n --;
	}
	printf("%d", num[-- len]);
	while (len)
		printf("%06d", num[-- len]);
	return 0;
}
