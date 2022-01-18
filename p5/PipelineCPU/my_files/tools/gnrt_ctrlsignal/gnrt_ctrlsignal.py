bitwise = [1, 2, 2, 2, 2, 1, 1, 4, 4, 3, 3, 3, 3, 3, 3]
pre = [" 1'b", "`regAddr_", "`EXBack_", "`MEMBack_", "`WBBack_", "`ALUSrcA_", "`ALUSrcB_", "`ALU_",
        "`CMP_", "`EXT_", "`NPC_", "`DM_", " 3'd", " 3'd", " 3'd"]
lens = [9, 11, 14, 18, 17, 15, 15, 8, 8, 14, 28, 8, 5, 8, 9]

with open("D:\\study\\CO\\p5\\PipelineCPU\\my_files\\tools\\gnrt_ctrlsignal\\ctrltable.txt", "r") as ctrltable, open("D:\\study\\CO\\p5\\PipelineCPU\\my_files\\tools\\gnrt_ctrlsignal\\out.txt", "w") as out :
    ctrlsignals = ctrltable.read().splitlines()
    for i in range(len(ctrlsignals)):
        cnt = 0
        if i != 0:
            out.write(",")
        if ctrlsignals[i] == "-":
            out.write(" " + str(bitwise[i]) + "'b0")
            cnt = 4 + len(str(bitwise[i]))
        else:
            out.write(pre[i] + ctrlsignals[i])
            cnt = len(pre[i]) + len(ctrlsignals[i])
        while cnt < lens[i]:
                out.write(" ")
                cnt += 1