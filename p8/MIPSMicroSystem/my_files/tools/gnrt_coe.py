import os

marsPath = "G:\\mars\\Mars_test.jar"
prjPath = "D:\\study\\CO\\p8\\MIPSMicroSystem\\"
# asmPath = "D:\\study\\CO\\p8\\upload\\calculator\\calculator.asm"
# asmPath = "D:\\study\\CO\\p8\\upload\\timer\\timer.asm"
asmPath = "D:\\study\\CO\\p8\\upload\\uart_echo\\uart_echo.asm"

code = prjPath + "code.tmp"
handler = prjPath + "handler.tmp"
codeFile = prjPath + "code.coe"
os.system("java -jar " + marsPath + " db nc mc CompactDataAtZero a dump .text HexText " + code + " " + asmPath)
os.system("java -jar " + marsPath + " db nc mc CompactDataAtZero a dump 0x00004180-0x00005180 HexText " + handler + " " + asmPath)
with open(code, "r") as codeSrc, open(codeFile, "w") as codeDst:
    codeDst.write("memory_initialization_radix=16;\n")
    codeDst.write("memory_initialization_vector=\n")
    codeText = codeSrc.read().splitlines()
    for i in range(len(codeText)):
        codeDst.write(codeText[i] + ",\n")
    
    
    if os.path.exists(handler):
        with open(handler, "r") as handlerSrc:
            for i in range(len(codeText), 1120):
                codeDst.write("00000000,\n")
            handlerText = handlerSrc.read().splitlines()
            for i in range(len(handlerText)):
                codeDst.write(handlerText[i] + ",\n")
        os.remove(handler)
    
    codeDst.write("00000000;")
os.remove(code)