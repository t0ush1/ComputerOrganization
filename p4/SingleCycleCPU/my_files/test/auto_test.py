#############################################################
# win10 64bit
# python 3.9.6
# 
# all args of func are filepath
#
# tools:
#   run Mars
#   run ISE
#   cmp result
#############################################################

import os
import re

# software path
xilinxPath = "G:\\ISE\\ise\\14.7\\ISE_DS\\ISE\\"
marsPath = "G:\\mars\\Mars_test.jar"

# export code and run mips
def runMars(asm, code, out):
    os.system("java -jar " + marsPath + " nc mc CompactDataAtZero a dump .text HexText " + code + " " + asm)
    os.system("java -jar " + marsPath + " " + asm + "  nc mc CompactDataAtZero > " + out)

# generate prj and tcl file
def initISE(prj):
    verilogPath = prj + "my_files\\cpu\\"
    prjFilePath = prj + "mips.prj"
    tclFilePath = prj + "mips.tcl"

    with open(prjFilePath, "w") as prjFile, open(tclFilePath, "w") as tclFile:
        for root, dirs, files in os.walk(verilogPath):
            for fileName in files:
                if re.match(r"[\w]*\.v", fileName):
                    prjFile.write("Verilog work " + root + "\\" + fileName + "\n")
        tclFile.write("run 20000us" + "\n" + "exit")

# compile and run verilog
def runISE(prj, code, out):
    prjFilePath = prj + "mips.prj"
    tclFilePath = prj + "mips.tcl"
    exeFilePath = prj + "mips.exe"
    logFilePath = prj + "log.txt"
    codeFilePath = prj + "code.txt"
    
    with open(code, "r") as codeSrc, open(codeFilePath, "w") as codeDst:
        codeDst.write(codeSrc.read())
    
    os.environ['XILINX'] = xilinxPath
    os.system(xilinxPath + "bin\\nt64\\fuse -nodebug -prj " + prjFilePath + " -o " + exeFilePath + " mips_tb > " + logFilePath)
    os.system(exeFilePath + " -nolog -tclbatch " + tclFilePath + " > " + out)

# compare my and std
def cmp(my, std, res):
    with open(my, "r") as myFile, open(std, "r") as stdFile, open(res, "w") as out:
        myFileText = myFile.read()
        myLogs = re.findall("@[^\n]*", myFileText)
        stdLogs = re.findall("@[^\n]*", stdFile.read())
        asmLogs = re.findall("asm: [^\n]*", myFileText)

        isAC = True

        for i in range(len(stdLogs)):
            if i < len(myLogs) and myLogs[i] != stdLogs[i]:
                out.write("On Line " + str(i+1) + "\n")
                out.write("\tGet\t\t: " + myLogs[i] + "\n")
                out.write("\tExpect\t: " + stdLogs[i] + "\n")
                print("On Line " + str(i+1))
                print("\tGet\t: " + myLogs[i])
                print("\tExpect\t: " + stdLogs[i])
                if (i < len(asmLogs)):
                    out.write("\tAsm\t\t: " + asmLogs[i] + "\n")
                    print("\tAsm\t: " + asmLogs[i])
                isAC = False
                break
            elif i >= len(myLogs):
                out.write("myLogs is too short \n")
                print("myLogs is too short")
                isAC = False
                break
        if isAC :
            out.write("All Accepted")
            print("All Accepted")
    return isAC

# run auto_test

prjPath = "D:\\study\\CO\\p4\\SingleCycleCPU\\"
initISE(prjPath)

tot = 9
ac = 0
print("------------------------------------------------------------")
for i in range(tot):
    testpointPath = prjPath + "my_files\\test\\data\\testpoint" + str(i)
    asmPath = testpointPath + "\\test.asm"
    codePath = testpointPath + "\\code.txt"
    stdAnsPath = testpointPath + "\\std_ans.txt"
    testAnsPath = testpointPath + "\\test_ans.txt"
    cmpResPath = testpointPath + "\\cmp_res.txt"

    runMars(asmPath, codePath, stdAnsPath)
    runISE(prjPath, codePath, testAnsPath)
    print("in testpoint" + str(i) + " : \n")
    if cmp(testAnsPath, stdAnsPath, cmpResPath):
        ac += 1
    print("------------------------------------------------------------")

if ac == tot:
    print("All Killed!!!\n")
else:
    print(str(tot - ac) + " of " + str(tot) + " are wrong\n")

print("------------------------------------------------------------")