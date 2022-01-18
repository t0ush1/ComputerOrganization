import os
import re

cnt = 0
for root, dirs, files in os.walk("D:\\study\\CO\\p6\\PipelineCPU\\my_files\\cpu\\"):
    for fileName in files:
        if re.match(r"[\w]*\.v", fileName):
            with open(root + "\\" + fileName, "r") as file:
                lines = file.read().splitlines()
                for i in range(len(lines)):
                    if lines[i] != "":
                        cnt += 1
print(cnt)