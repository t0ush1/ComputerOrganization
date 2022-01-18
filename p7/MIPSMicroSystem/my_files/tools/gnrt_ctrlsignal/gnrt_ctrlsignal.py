from typing import NewType


bitwise = [0, 0, 0, 2, 2, 2, 3, 1, 1, 1, 1, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3]
pre = ["", "", "", "`regAddr_", "`EXBack_", "`MEMBack_", "`WBBack_", "`ALUSrcA_", "`ALUSrcB_", "`MDUResult_", " 1'b", 
        "`ALU_", "`MDU_", "`CMP_", "`EXT_", "`NPC_", "`BE_", "`DE_", " 3'd", " 3'd", " 3'd"]
width = [0, 0, 0, 11, 14, 18, 17, 15, 15, 13, 6, 8, 10, 8, 14, 28, 8, 8, 5, 8, 9]

path = "D:\\study\\CO\\p7\\MIPSMicroSystem\\my_files\\tools\\gnrt_ctrlsignal\\"

with open(path + "ctrltable.txt", "r") as ctrltable, open(path + "out.txt", "w") as out :
    table = ctrltable.read().splitlines()
    
    # gnrt_signaltable
    signals = []
    for i in range(len(table)):
        signals.append(table[i].split('\t'))
    for i in range(len(signals[0])):
        if (signals[0][i] == ""):
            out.write("\n")
            continue
        out.write("%12s" % (""))
        if signals[2][i] == "-":
            out.write("(op == `%-5s) ?%16s" % (signals[0][i], ""))
        elif signals[1][i] == "000000":
            out.write("(op == `R && funct == `%-5s) ? " % (signals[0][i]))
        elif signals[1][i] == "000001":
            out.write("(op == `SPC1 && rt == `%-5s) ? " % (signals[0][i]))
        elif signals[1][i] == "010000":
            if len(signals[2][i]) == 6:
                out.write("(op == `SPC2 && funct == `%-5s) ? " % (signals[0][i]))
            else:
                out.write("(op == `SPC2 && rs == `%-5s) ? " % (signals[0][i]))
        out.write("{")
        for j in range(3, len(table)):
            if (signals[j][i] == "-"):
                out.write("%-*s" % (width[j], " " + str(bitwise[j]) + "'b0"))
            else:
                out.write("%-*s" % (width[j], pre[j] + signals[j][i]))
            out.write("} :\n" if j == len(table)-1 else "," )

    out.write("\n")

    #gnrt_macro
    for i in range(len(signals[0])):
        if (signals[0][i] == ""):
            out.write("\n")
            continue
        out.write("`define %-5s " % (signals[0][i]))
        if signals[2][i] == "-":
            out.write("6'b%s" % (signals[1][i]))
        elif signals[1][i] == "000000":
            out.write("6'b%s" % (signals[2][i]))
        elif signals[1][i] == "000001":
            out.write("5'b%s" % (signals[2][i]))
        elif signals[1][i] == "010000":
            if len(signals[2][i]) == 6:
                out.write("6'b%s" % (signals[2][i]))
            else:
                out.write("5'b%s" % (signals[2][i]))
        out.write("\n")