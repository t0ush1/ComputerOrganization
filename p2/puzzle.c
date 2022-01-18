#include <stdio.h>

int dx[] = { -1, 0, 1, 0 }, dy[] = { 0, 1, 0, -1 };
int mat[10][10], mark[10][10];
int n, m, x0, y0, x1, y1, ans;

void dfs(int x, int y)
{
	if (x == x1 && y == y1)
	{
		ans ++;
		return;
	}
	mark[x][y] = 1;
	for (int i = 0; i < 4; i ++)
	{
		int xx = x + dx[i], yy = y + dy[i];
		if (!mark[xx][yy] && mat[xx][yy])
			dfs(xx, yy);
	}
	mark[x][y] = 0;
}

int main()
{
	scanf("%d %d", &n, &m);
	for (int i = 1; i <= n; i ++)
		for (int j = 1; j <= m; j ++)
			scanf("%d", &mat[i][j]), mat[i][j] ^= 1;
	scanf("%d %d %d %d", &x0, &y0, &x1, &y1);
	dfs(x0, y0);
	printf("%d", ans);
	return 0;
}
