#include <stdio.h>

char s[50][100];

int main()
{
	freopen("reg32.xml", "w", stdout);
	freopen("reg_example.xml", "r", stdin);
	int line = 0, x, y, dx = 200, dy = 120;
	while (gets(s[line ++]));
	for (int i = 0; i < 32; i ++)
	{
		printf("reg%02d:\n", i);
		for (int j = 0; j < line; j ++)
		{
			for (int k = 0; s[j][k]; k ++)
				if (s[j][k] == '(')
				{
					sscanf(s[j] + k, "(%d,%d)", &x, &y);
					printf("(%d,%d)", x + dx*(i%8), y + dy*(i/8));
					while (s[j][k] != ')') k ++;
				}
				else if (s[j][k] == '_')
				{
					sscanf(s[j] + k, "_%d", &x);
					printf("_%02d\"", x + i);
					while (s[j][k] != '\"') k ++;
				}
				else putchar(s[j][k]);
			puts("");
		}
	}
	return 0;
}
