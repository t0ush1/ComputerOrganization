from os import truncate
import re

path = "D:\\study\\CO\\p7\\MIPSMicroSystem\\my_files\\tools\\gnrt_io\\"

with open(path + "iotable.txt", "r") as iotable, open(path + "out.txt", "w") as out :
    io = iotable.read().splitlines()
    for i in range(len(io)):
        s = re.search(r"(?:input|output)(?: reg)?(?: \[[0-9]+\:[0-9]\])? ([\w]+)", io[i])
        if s:
            out.write("        ." + s.group(1) + "(")
            if (False):
                out.write(s.group(1))
            out.write("),\n")
        else:
            out.write("\n")