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
    os.system("java -jar " + marsPath + " db nc mc CompactDataAtZero a dump .text HexText " + code + " " + asm)
    os.system("java -jar " + marsPath + " " + asm + " 4096 db nc mc CompactDataAtZero > " + out)

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
        tclFile.write("run 200us" + "\n" + "exit")

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
    os.system(xilinxPath + "bin\\nt64\\fuse -nodebug -prj " + prjFilePath + " -o " + exeFilePath + " mips_txt > " + logFilePath)
    os.system(exeFilePath + " -nolog -tclbatch " + tclFilePath + " > " + out)

# compare my and std
def cmp(index, my, std, res):
    with open(my, "r") as myFile, open(std, "r") as stdFile, open(res, "a") as out:
        out.write("in testpoint" + str(index) + " : \n")
        print("in testpoint" + str(index) + " : \n")
        
        myFileText = myFile.read()
             
        myLogs = re.findall("\@[^\n]*", myFileText)
        stdLogs = re.findall("\@[^\n]*", stdFile.read())

        isAC = True

        for i in range(len(stdLogs)):
            if i < len(myLogs) and myLogs[i] != stdLogs[i]:
                out.write("\tOn Line " + str(i+1) + "\n")
                out.write("\tGet\t\t: " + myLogs[i] + "\n")
                out.write("\tExpect\t: " + stdLogs[i] + "\n")
                print("\tOn Line " + str(i+1))
                print("\tGet\t: " + myLogs[i])
                print("\tExpect\t: " + stdLogs[i])
                isAC = False
                break
            elif i >= len(myLogs):
                out.write("myLogs is too short\n")
                print("myLogs is too short")
                isAC = False
                break
        if isAC :
            out.write("\tAll Accepted\n")
            print("\tAll Accepted")
    return isAC

# run auto_test

prjPath = "D:\\study\\CO\\p6\\PipelineCPU\\"
initISE(prjPath)

tot = 101
ac = 0

testdataPath = prjPath + "my_files\\test\\data\\"
cmpResPath = testdataPath + "cmp_res.txt"
if os.path.exists(cmpResPath):
    os.remove(cmpResPath)
print("------------------------------------------------------------")
for i in range(0, tot):
    testpointPath = testdataPath + "testpoint\\testpoint" + str(i) + ".asm"
    codePath = testdataPath + "code\\code" + str(i) + ".txt"
    stdAnsPath = testdataPath + "std_ans\\std_ans" + str(i) + ".txt"
    testAnsPath = testdataPath + "test_ans\\test_ans" + str(i) + ".txt"

    runMars(testpointPath, codePath, stdAnsPath)
    runISE(prjPath, codePath, testAnsPath)
    if cmp(i, testAnsPath, stdAnsPath, cmpResPath):
        ac += 1
    # if ac + 3 <= i:
        # break
    print("------------------------------------------------------------")

if ac == tot:
    print("All Killed!!!\n")