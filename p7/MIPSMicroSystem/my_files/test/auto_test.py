#############################################################
# win10 64bit
# python 3.9.6
# 
# author: toush1 (20373944 he tianran)
#############################################################

import os
import re

# software path
xilinxPath = "G:\\ISE\\ise\\14.7\\ISE_DS\\ISE\\"
marsPath = "G:\\mars\\Mars_test.jar"

# prj path and test mode
myPrjPath = "D:\\study\\CO\\p7\\MIPSMicroSystem\\"
otherPrjPath = "D:\\study\\CO\\p7\\szxCPU\\"
start = 0
tot = 1
interrupt = 0x301c # if 0 not interrupt; if -1 interrupt all; if 0x3000 interrupt at 0x3000

# dump text and handler (and run in Mars)
def runMars(asm, codeFilePath, out):
    path = os.path.dirname(codeFilePath) + "\\"
    code = path + "code.tmp"
    handler = path + "handler.tmp"
    os.system("java -jar " + marsPath + " db nc mc CompactDataAtZero a dump .text HexText " + code + " " + asm)
    os.system("java -jar " + marsPath + " db nc mc CompactDataAtZero a dump 0x00004180-0x00005180 HexText " + handler + " " + asm)
    # os.system("java -jar " + marsPath + " " + asm + " 4096 db nc mc CompactDataAtZero > " + out)
    with open(code, "r") as codeSrc, open(handler, "r") as handlerSrc, open(codeFilePath, "w") as codeDst:
        codeText = codeSrc.read()
        textLen = len(codeText.splitlines())
        codeDst.write(codeText)
        for i in range(len(codeText.splitlines()), 1120):
            codeDst.write("00000000\n")
        codeDst.write(handlerSrc.read())
    os.remove(code)
    os.remove(handler)
    return textLen

# gnrt prj and tcl file
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

# change interrupt position in testbench
def changeIntPos(tbPath, intPos):
    text = ""
    with open(tbPath, "r") as testbench:
        text = testbench.read()
        if intPos == 0:
            text = text.replace("need_interrupt = 1", "need_interrupt = 0")
        else:
            text = text.replace("need_interrupt = 0", "need_interrupt = 1")
            text = re.sub(r"fixed_macroscopic_pc == 32'h[0-9a-f]+",
                "fixed_macroscopic_pc == 32'h" + str(hex(intPos)).removeprefix("0x"), text)
    with open(tbPath, "w") as testbench:
        testbench.write(text)

# compile and run in ISE
def runISE(prj, out):
    prjFilePath = prj + "mips.prj"
    tclFilePath = prj + "mips.tcl"
    exeFilePath = prj + "mips.exe"
    logFilePath = prj + "log.txt"
    
    os.chdir(prj)    
    os.environ['XILINX'] = xilinxPath
    os.system(xilinxPath + "bin\\nt64\\fuse -nodebug -prj " + prjFilePath + " -o " + exeFilePath + " mips_tb > " + logFilePath)
    os.system(exeFilePath + " -nolog -tclbatch " + tclFilePath + " > " + out)

# cmp myAns and stdAns
def cmp(interrupt, my, std, cmpRes):
    with open(my, "r") as myFile, open(std, "r") as stdFile, open(cmpRes, "a") as out:
        myLogs = re.findall("\@[^\n]*", myFile.read())
        stdLogs = re.findall("\@[^\n]*", stdFile.read())

        if interrupt != 0:
            out.write("interrupt at " + str(hex(interrupt)) + " : \n")
            print("interrupt at " + str(hex(interrupt)) + " : ")
        else:
            out.write("no interrupt : \n")
            print("no interrupt : ")

        for i in range(len(stdLogs)):
            if i < len(myLogs) and myLogs[i] != stdLogs[i]:
                out.write("\tOn Line " + str(i+1) + "\n")
                out.write("\tGet\t\t: " + myLogs[i] + "\n")
                out.write("\tExpect\t: " + stdLogs[i] + "\n")
                print("\tOn Line " + str(i+1))
                print("\tGet\t: " + myLogs[i])
                print("\tExpect\t: " + stdLogs[i])
                return False
            elif i >= len(myLogs):
                out.write("\tmyLogs is too short\n")
                print("\tmyLogs is too short")
                return False
        if len(myLogs) > len(stdLogs):
            out.write("\tmyLogs is too long\n")
            print("\tmyLogs is too long")
            return False
    return True

# main
initISE(myPrjPath)
initISE(otherPrjPath)
testdataPath = myPrjPath + "my_files\\test\\data\\"
cmpResPath = testdataPath + "cmp_res.txt"
myTbPath = myPrjPath + "my_files\\cpu\\mips_tb.v"
otherTbPath = otherPrjPath + "my_files\\cpu\\mips_tb.v"
if os.path.exists(cmpResPath):
    os.remove(cmpResPath)

for i in range(start, start + tot):
    testpointPath = testdataPath + "testpoint\\testpoint" + str(i) + ".asm"
    codePath = testdataPath + "code\\code" + str(i) + ".txt"
    stdAnsPath = testdataPath + "std_ans\\std_ans" + str(i) + ".txt"
    testAnsPath = testdataPath + "test_ans\\test_ans" + str(i) + ".txt"

    textLen = runMars(testpointPath, codePath, stdAnsPath) - 4
    with open(codePath, "r") as codeSrc, open(myPrjPath + "code.txt", "w") as codeDst1, open(otherPrjPath + "code.txt", "w") as codeDst2:
        code = codeSrc.read()
        codeDst1.write(code)
        codeDst2.write(code)
    
    with open(cmpResPath, "a") as out:
        out.write("\n----------------------------------------------------------------\n")
        out.write("\nin testpoint" + str(i) + " : \n\n")
        print("\n----------------------------------------------------------------")
        print("\nin testpoint" + str(i) + " : \n")
    
    isAC = True

    if interrupt == 0:
        changeIntPos(myTbPath, 0)
        changeIntPos(otherTbPath, 0)
        runISE(myPrjPath, testAnsPath)
        runISE(otherPrjPath, stdAnsPath)
        isAC = cmp(0, testAnsPath, stdAnsPath, cmpResPath)
    elif interrupt == -1:
        for j in range(1, textLen):
            intPos = j * 4 + 0x3000
            changeIntPos(myTbPath, intPos)
            changeIntPos(otherTbPath, intPos)
            runISE(myPrjPath, testAnsPath)
            runISE(otherPrjPath, stdAnsPath)
            if not cmp(intPos, testAnsPath, stdAnsPath, cmpResPath):
                isAC = False
                break
    else:
        changeIntPos(myTbPath, interrupt)
        changeIntPos(otherTbPath, interrupt)
        runISE(myPrjPath, testAnsPath)
        runISE(otherPrjPath, stdAnsPath)
        isAC = cmp(interrupt, testAnsPath, stdAnsPath, cmpResPath)

    if isAC:
        with open(cmpResPath, "a") as out:
            out.write("\n\tAll Accepted\n")
            print("\n\tAll Accepted")

print("\n----------------------------------------------------------------")