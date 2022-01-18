import os
import re

marsPath = "G:/mars/Mars4_5.jar"
lgsmPath = "G:/logisim/logisim-generic-2.7.1.jar"
testPath = "D:/study/CO/P3/test/"
mipsPath = testPath + "test.asm"
myCircPath = testPath + "scmCPU.circ"
testCircPath = testPath + "testCPU.circ"
dataPath = testPath + "in1.txt"
logPath = testPath + "log1.txt"
ansPath = testPath + "out1.txt"

# export hex code

# os.system("java -jar " + marsPath + " " + mipsPath + " nc mc CompactTextAtZero a dump .text HexText " + dataPath) 

# load code to IM, generate test circuit

testData = open(dataPath).read()
circ = open(myCircPath).read()
circ = re.sub(r"addr/data: 5 32([\s\S]*)</a>", "addr/data: 5 32\n" + testData + "</a>", circ)
with open(testCircPath, "w") as testCirc:
    testCirc.write(circ)

# export logisim result

os.system("java -jar " + lgsmPath + " " + testCircPath + " -tty table >" + logPath)

# formalize output

with open(ansPath, "w") as ans, open(logPath, "r") as log:
    logText = log.readlines()
    for line in logText:
        line = re.sub(r"[\s]+", "", line)
        ans.write("@" + "{:>08x}".format(int(line[0:32], 2)) + ":\t")
        if (line[32] == '1' and line[33:38] != "00000"):
            ans.write("$" + "{:2d}".format(int(line[33:38], 2)) + " <= " + "{:>08x}".format(int(line[38:70],2)) + "\t")
        if (line[70] == '1'):
            ans.write("#" + "{:>08x}".format(4 * int(line[71:76], 2)) + " <= " + "{:>08x}".format(int(line[76:108], 2)) + "\t")
        ans.write("\n")