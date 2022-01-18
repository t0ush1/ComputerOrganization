from os import truncate
import re

with open("D:\\study\\CO\\p5\\tools\\gnrt_io\\iotable.txt", "r") as iotable, open("D:\\study\\CO\\p5\\tools\\gnrt_io\\out.txt", "w") as out :
    io = iotable.read().splitlines()
    for i in range(len(io)):
        s = re.search(r"(?:input|output)(?: reg)?(?: \[[0-9]+\:0\])? ([\w]+)", io[i])
        if s:
            out.write("        ." + s.group(1) + "(")
            if (False):
                out.write(s.group(1))
            out.write("),\n")
        else:
            out.write("\n")