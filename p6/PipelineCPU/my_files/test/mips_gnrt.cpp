#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>
using namespace std;

///////////////// const value ///////////////////////////////////////////////////////////////////////////
#define TYPENUM 10
#define MAXINSNUM 13
#define MEMSIZE 128
#define BLOCKNUM 750
#define INITINSNUM 36

enum TYPE { cal_ri, cal_rr, br_r2, br_r1, store, load, mf, mt, md, _lui };
enum CALRI { addi, addiu, slti, sltiu, andi, ori, xori, sll, srl, sra };
enum CALRR { add, addu, sub, subu, slt, sltu, _and, _or, nor, _xor, sllv, srlv, srav };
enum BRR2 { beq, bne };
enum BRR1 { bgez, bgtz, blez, bltz };
enum STORE { sw, sh, sb };
enum LOAD { lw, lh, lhu, lb, lbu };
enum MF { mfhi, mflo };
enum MT { mthi, mtlo };
enum MD { mult, multu, _div, divu };
enum LUI { lui };

const int insNum[TYPENUM] = { 10, 13, 2, 4, 3, 5, 2, 2, 4, 1 };
const char format[TYPENUM][30] = {
    "%s $%d, $%d, %d",
    "%s $%d, $%d, $%d",
    "%s $%d, $%d, TAG%d",
    "%s $%d, TAG%d",
    "%s $%d, %d($%d)",
    "%s $%d, %d($%d)",
    "%s $%d",
    "%s $%d",
    "%s $%d, $%d",
    "%s $%d, %d"
};
const char insName[TYPENUM][MAXINSNUM][10] = {
    { "addi", "addiu", "slti", "sltiu", "andi", "ori", "xori", "sll", "srl", "sra" },
    { "add", "addu", "sub", "subu", "slt", "sltu", "and", "or", "nor", "xor", "sllv", "srlv", "srav" },
    { "beq", "bne" },
    { "bgez", "bgtz", "blez", "bltz" },
    { "sw", "sh", "sb" },
    { "lw", "lh", "lhu", "lb", "lbu" },
    { "mfhi", "mflo" },
    { "mthi", "mtlo" },
    { "mult", "multu", "div", "divu" },
    { "lui" }
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////// generate //////////////////////////////////////////////////////////////////////////////////////////
#define ranReg (rand() % 4 + 1) //only $1 ~ $4

struct Instr {
    int type, ins, a0, a1, a2;
    Instr() {}
    Instr(int type, int ins, int a0, int a1, int a2) : type(type), ins(ins), a0(a0), a1(a1), a2(a2) {}
    Instr(int index) : type(-1), a0(index) {}
    void print()
    {
        if (type == -1)
            printf("TAG%d:", a0);
        else
            printf(format[type], insName[type][ins], a0, a1, a2);
        puts("");
    }
};

vector<Instr*> instrs;

void gnrtJump()
{
    int tagNum = 0, insCnt = 0, endNum = 0;
    // cal_rr <- jal
    for (int i = 0; i < insNum[cal_rr]; i ++)
    {
        printf("jal TAG%d\n", ++ tagNum);
        printf("%s $1, $ra, $0\n", insName[cal_rr][i]);
        printf("TAG%d:\n", tagNum);
        printf("%s $2, $ra, $0\n", insName[cal_rr][i]);
        printf("%s $3, $ra, $0\n", insName[cal_rr][i]);
        insCnt += 4;
        puts("");
    }
    // cal_ri <- jal
    for (int i = 0; i < insNum[cal_ri]; i ++)
    {
        printf("jal TAG%d\n", ++ tagNum);
        printf("%s $1, $ra, 0\n", insName[cal_ri][i]);
        printf("TAG%d:\n", tagNum);
        printf("%s $2, $ra, 0\n", insName[cal_ri][i]);
        printf("%s $3, $ra, 0\n", insName[cal_ri][i]);
        insCnt += 4;
        puts("");
    }
    // br_r2 <- jal
    for (int i = 0; i < insNum[br_r2]; i ++)
    {
        printf("jal TAG%d\n", ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        printf("%s $ra, $0, TAG%d\n", insName[br_r2][i], ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);

        printf("jal TAG%d\n", ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        printf("nop\n");
        printf("%s $0, $ra, TAG%d\n", insName[br_r2][i], ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        insCnt += 9;
        puts("");
    }
    // br_r1 <- jal
    for (int i = 0; i < insNum[br_r1]; i ++)
    {
        printf("jal TAG%d\n", ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        printf("%s $ra, TAG%d\n", insName[br_r1][i], ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);

        printf("jal TAG%d\n", ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        printf("nop\n");
        printf("%s $ra, TAG%d\n", insName[br_r1][i], ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        insCnt += 9;
        puts("");
    }
    // store <- jal
    for (int i = 0; i < insNum[store]; i ++)
    {
        printf("jal TAG%d\n", ++ tagNum);
        printf("%s $ra, 0($0)\n", insName[store][i]);
        printf("TAG%d:\n", tagNum);
        printf("%s $ra, 0($0)\n", insName[store][i]);
        printf("%s $ra, 0($0)\n", insName[store][i]);

        printf("jal TAG%d\n", ++ tagNum);
        printf("%s $1, -0x3000($ra)\n", insName[store][i]);
        printf("TAG%d:\n", tagNum);
        printf("%s $2, -0x3000($ra)\n", insName[store][i]);
        printf("%s $3, -0x3000($ra)\n", insName[store][i]);
        insCnt += 8;
        puts("");
    }
    // load <- jal
    for (int i = 0; i < insNum[load]; i ++)
    {
        printf("jal TAG%d\n", ++ tagNum);
        printf("%s $1, -0x3000($ra)\n", insName[load][i]);
        printf("TAG%d:\n", tagNum);
        printf("%s $2, -0x3000($ra)\n", insName[load][i]);
        printf("%s $3, -0x3000($ra)\n", insName[load][i]);
        insCnt += 4;
        puts("");
    }
    // mt <- jal
    for (int i = 0; i < insNum[mt]; i ++)
    {
        printf("jal TAG%d\n", ++ tagNum);
        printf("%s $ra\n", insName[mt][i]);
        printf("TAG%d:\n", tagNum);
        printf("%s $ra\n", insName[mt][i]);
        printf("%s $ra\n", insName[mt][i]);
        insCnt += 4;
        puts("");
    }
    // md <- jal
    for (int i = 0; i < insNum[md]; i ++)
    {
        printf("ori $1, $0, 1\n");
        printf("jal TAG%d\n", ++ tagNum);
        printf("%s $ra, $1\n", insName[md][i]);
        printf("TAG%d:\n", tagNum);
        printf("%s $ra, $1\n", insName[md][i]);
        printf("%s $ra, $1\n", insName[md][i]);
        insCnt += 5;
        puts("");
    }
    // cal_rr <- jalr
    for (int i = 0; i < insNum[cal_rr]; i ++)
    {
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("%s $1, $ra, $0\n", insName[cal_rr][i]);
        printf("%s $2, $ra, $0\n", insName[cal_rr][i]);
        printf("%s $3, $ra, $0\n", insName[cal_rr][i]);
        insCnt += 6;
        puts("");
    }
    // cal_ri <- jalr
    for (int i = 0; i < insNum[cal_ri]; i ++)
    {
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("%s $1, $ra, 0\n", insName[cal_ri][i]);
        printf("%s $2, $ra, 0\n", insName[cal_ri][i]);
        printf("%s $3, $ra, 0\n", insName[cal_ri][i]);
        insCnt += 6;
        puts("");
    }
    // br_r2 <- jalr
    for (int i = 0; i < insNum[br_r2]; i ++)
    {
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("nop\n");
        printf("%s $ra, $0, TAG%d\n", insName[br_r2][i], ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        insCnt += 6;
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("nop\n");
        printf("nop\n");
        printf("%s $0, $ra, TAG%d\n", insName[br_r2][i], ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        insCnt += 7;
        puts("");
    }
    // br_r1 <- jalr
    for (int i = 0; i < insNum[br_r1]; i ++)
    {
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("nop\n");
        printf("%s $ra, TAG%d\n", insName[br_r1][i], ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        insCnt += 6;
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("nop\n");
        printf("nop\n");
        printf("%s $ra, TAG%d\n", insName[br_r1][i], ++ tagNum);
        printf("nop\n");
        printf("TAG%d:\n", tagNum);
        insCnt += 7;
        puts("");
    }
    // store <- jalr
    for (int i = 0; i < insNum[store]; i ++)
    {
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("%s $ra, 0($0)\n", insName[store][i]);
        printf("%s $ra, 0($0)\n", insName[store][i]);
        printf("%s $ra, 0($0)\n", insName[store][i]);
        insCnt += 6;
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("%s $1, -0x3000($ra)\n", insName[store][i]);
        printf("%s $2, -0x3000($ra)\n", insName[store][i]);
        printf("%s $3, -0x3000($ra)\n", insName[store][i]);
        insCnt += 6;
        puts("");
    }
    // load <- jalr
    for (int i = 0; i < insNum[load]; i ++)
    {
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("%s $1, -0x3000($ra)\n", insName[load][i]);
        printf("%s $2, -0x3000($ra)\n", insName[load][i]);
        printf("%s $3, -0x3000($ra)\n", insName[load][i]);
        insCnt += 6;
        puts("");
    }
    // mt <- jalr
    for (int i = 0; i < insNum[mt]; i ++)
    {
        printf("ori $t0, $0, %d\n", (insCnt+4)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("%s $ra\n", insName[mt][i]);
        printf("%s $ra\n", insName[mt][i]);
        printf("%s $ra\n", insName[mt][i]);
        insCnt += 6;
        puts("");
    }
    // md <- jalr
    for (int i = 0; i < insNum[md]; i ++)
    {
        printf("ori $1, $0, 1\n");
        printf("ori $t0, $0, %d\n", (insCnt+5)*4);
        printf("addi $t0, $t0, 0x3000\n");
        printf("jalr $ra, $t0\n");
        printf("%s $ra, $1\n", insName[md][i]);
        printf("%s $ra, $1\n", insName[md][i]);
        printf("%s $ra, $1\n", insName[md][i]);
        insCnt += 7;
        puts("");
    }
    // others
    for (int j = 0; j < 2; j ++)
    {
        // jalr/jr <- cal_rr 
        for (int i = 0; i < insNum[cal_rr]; i ++)
        {
            if (i == slt || i == sltu) continue;
            if (i == nor)
            {
                printf("ori $t0, $0, %d\n", ~(0x3000 + (insCnt+6)*4)); // split insCnt 1->3
                printf("nor $1, $t0, $0\n");
                printf(j ? "jalr $ra, $1\n" : "jr $1\n");
                printf("nop\n");
                insCnt += 6;
                printf("ori $t0, $0, %d\n", ~(0x3000 + (insCnt+7)*4));
                printf("nor $1, $t0, $0\n");
                printf("nop\n");
                printf(j ? "jalr $ra, $1\n" : "jr $1\n");
                printf("nop\n");
                insCnt += 7;
                printf("ori $t0, $0, %d\n", ~(0x3000 + (insCnt+8)*4));
                printf("nor $1, $t0, $0\n");
                printf("nop\n");
                printf("nop\n");
                printf(j ? "jalr $ra, $1\n" : "jr $1\n");
                printf("nop\n");
                insCnt += 8;
                puts("");
                continue;
            }
            if (i == _and)
            {
                printf("ori $t1, $0, 0xffff\n");
                printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+5)*4);
                printf("and $1, $t0, $t1\n");
                printf(j ? "jalr $ra, $1\n" : "jr $1\n");
                printf("nop\n");
                insCnt += 5;
                printf("ori $t1, $0, 0xffff\n");
                printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+6)*4);
                printf("and $1, $t0, $t1\n");
                printf("nop\n");
                printf(j ? "jalr $ra, $1\n" : "jr $1\n");
                printf("nop\n");
                insCnt += 6;
                printf("ori $t1, $0, 0xffff\n");
                printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+7)*4);
                printf("and $1, $t0, $t1\n");
                printf("nop\n");
                printf("nop\n");
                printf(j ? "jalr $ra, $1\n" : "jr $1\n");
                printf("nop\n");
                insCnt += 7;
                puts("");
                continue;
            }
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+4)*4);
            printf("%s $1, $t0, $0\n", insName[cal_rr][i]);
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 4;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+5)*4);
            printf("%s $1, $t0, $0\n", insName[cal_rr][i]);
            printf("nop\n");
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 5;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+6)*4);
            printf("%s $1, $t0, $0\n", insName[cal_rr][i]);
            printf("nop\n");
            printf("nop\n");
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 6;
            puts("");
        }
        // jalr/jr <- cal_ri
        for (int i = 0; i < insNum[cal_ri]; i ++)
        {
            if (i == slti || i == sltiu) continue;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+4)*4);
            printf("%s $1, $t0, 0x%x\n", insName[cal_ri][i], (i == andi ? 0xffff : 0));
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 4;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+5)*4);
            printf("%s $1, $t0, 0x%x\n", insName[cal_ri][i], (i == andi ? 0xffff : 0));
            printf("nop\n");
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 5;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+6)*4);
            printf("%s $1, $t0, 0x%x\n", insName[cal_ri][i], (i == andi ? 0xffff : 0));
            printf("nop\n");
            printf("nop\n");
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 6;
            puts("");
        }
        // jalr/jr <- mf
        for (int i = 0; i < insNum[mf]; i ++)
        {
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+5)*4);
            printf("%s $t0\n", insName[mt][i]);
            printf("%s $1\n", insName[mf][i]);
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 5;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+6)*4);
            printf("%s $t0\n", insName[mt][i]);
            printf("%s $1\n", insName[mf][i]);
            printf("nop\n");
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 6;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+7)*4);
            printf("%s $t0\n", insName[mt][i]);
            printf("%s $1\n", insName[mf][i]);
            printf("nop\n");
            printf("nop\n");
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 7;
            puts("");
        }
        // jalr/jr <- load
        for (int i = 0; i < insNum[load]; i ++)
        {
            if (i == lb || i == lbu) continue;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+5)*4);
            printf("%s $t0, 0($0)\n", (i == lw ? "sw" : "sh"));
            printf("%s $1, 0($0)\n", insName[load][i]);
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 5;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+6)*4);
            printf("%s $t0, 0($0)\n", (i == lw ? "sw" : "sh"));
            printf("%s $1, 0($0)\n", insName[load][i]);
            printf("nop\n");
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 6;
            printf("ori $t0, $0, %d\n", 0x3000 + (insCnt+7)*4);
            printf("%s $t0, 0($0)\n", (i == lw ? "sw" : "sh"));
            printf("%s $1, 0($0)\n", insName[load][i]);
            printf("nop\n");
            printf("nop\n");
            printf(j ? "jalr $ra, $1\n" : "jr $1\n");
            printf("nop\n");
            insCnt += 7;
        }
        // jalr/jr <- jal
        {
            printf("jal TAG%d\n", ++ tagNum);
            printf("nop\n");
            printf("j END%d\n", ++ endNum);
            printf("nop\n");
            printf("TAG%d:\n", tagNum);
            printf(j ? "jalr $0, $ra\n" : "jr $ra\n");
            printf("nop\n");
            printf("END%d:\n", endNum);
            insCnt += 6;
            printf("jal TAG%d\n", ++ tagNum);
            printf("nop\n");
            printf("j END%d\n", ++ endNum);
            printf("nop\n");
            printf("TAG%d:\n", tagNum);
            printf("nop\n");
            printf(j ? "jalr $0, $ra\n" : "jr $ra\n");
            printf("nop\n");
            printf("END%d:\n", endNum);
            insCnt += 7;
            puts("");
        }
        // jalr/jr <- jalr
        {
            printf("ori $1, $0, %d\n", 0x3000 + (insCnt+5)*4);
            printf("jalr $ra, $1\n");
            printf("nop\n");
            printf("j END%d\n", ++ endNum);
            printf("nop\n");
            printf(j ? "jalr $0, $ra\n" : "jr $ra\n");
            printf("nop\n");
            printf("END%d:\n", endNum);
            insCnt += 7;
            printf("ori $1, $0, %d\n", 0x3000 + (insCnt+5)*4);
            printf("jalr $ra, $1\n");
            printf("nop\n");
            printf("j END%d\n", ++ endNum);
            printf("nop\n");
            printf("nop\n");
            printf(j ? "jalr $0, $ra\n" : "jr $ra\n");
            printf("nop\n");
            printf("END%d:\n", endNum);
            insCnt += 8;
            puts("");
        }
    }
}

int ranImm(int bitwidth, int flag) // if flag = 0, only > 0
{
    if (bitwidth <= 0 || bitwidth > 32 || (flag != 0 && flag != 1)) return 0;
    int num[32] = {}, isMinus = flag * (rand() % 2), ret = 0;
    for (int i = 0; i <= 32 - bitwidth; i ++) num[i] = isMinus;
    for (int i = 33-bitwidth; i < 32; i ++) num[i] = rand() % 2;
    for (int i = 0; i < 32; i ++) ret = ret << 1 | num[i];
    return ret;
}

void init()
{
    instrs.clear();
    for (int i = 1; i <= 4; i ++)
        instrs.push_back(new Instr(cal_ri, ori, i, 0, ranImm(5, 0)));
    for (int i = 0; i < MEMSIZE; i += 4)
        instrs.push_back(new Instr(store, sw, ranReg, i, 0));
}

void gnrtBlock(int index, int& lastDst, int& JBFlag)
{
    int type, ins, a0, a1, a2;
    int dstReg[10] = {lastDst}, cnt = 1;
    for (int i = 0; i < 4; i ++)
    {
        type = rand() % TYPENUM;
        if (type == br_r2 || type == br_r1) // DoubleDelay 
        {
            if (JBFlag)
                while (type == br_r2 || type == br_r1)
                    type = rand() % TYPENUM, JBFlag = 0;
            else JBFlag = 1;
        }
        else JBFlag = 0;
        ins = rand() % insNum[type];
        if (type == cal_ri) a0 = ranReg, a1 = dstReg[rand()%cnt], a2 = ranImm(5, 0), dstReg[cnt ++] = a0;
        else if (type == cal_rr) a0 = ranReg, a1 = dstReg[rand()%cnt], a2 = dstReg[rand()%cnt], dstReg[cnt ++] = a0;
        else if (type == br_r2) a0 = dstReg[rand()%cnt], a1 = dstReg[rand()%cnt], a2 = index;
        else if (type == br_r1) a0 = dstReg[rand()%cnt], a1 = index;
        else if (type == store) a0 = dstReg[rand()%cnt], a1 = 0, a2 = dstReg[rand()%cnt];
        else if (type == load) a0 = ranReg, a1 = 0, a2 = dstReg[rand()%cnt], dstReg[cnt ++] = a0;
        else if (type == mf) a0 = ranReg, dstReg[cnt ++] = a0;
        else if (type == mt) a0 = dstReg[rand()%cnt];
        else if (type == md) a0 = dstReg[rand()%cnt], a1 = dstReg[rand()%cnt];
        else if (type == _lui) a0 = ranReg, a1 = ranImm(5, 0), dstReg[cnt ++] = a0;
        instrs.push_back(new Instr(type, ins, a0, a1, a2));
    }
    instrs.push_back(new Instr(index));
    lastDst = dstReg[cnt-1];
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////// trace ////////////////////////////////////////////////////////////////////////////////////////////////
void trace()
{
    int reg[32] = {}, HI = 0, LO = 0, mem[1024] = {};
    int type, ins, a0, a1, a2, tag = 0;
    for (int i = 0; i < (int)instrs.size(); i ++)
    {
        type = instrs[i]->type;
        if (type == -1) continue;
        ins = instrs[i]->ins;
        a0 = instrs[i]->a0;
        a1 = instrs[i]->a1;
        a2 = instrs[i]->a2;
        if (type == cal_ri)
        {
            if (ins == addi && (INT_MAX-reg[a1] < a2 || INT_MIN-reg[a1] > a2)) //overflow
                instrs[i]->ins = ins = addiu;
            if (ins == addi) reg[a0] = reg[a1] + a2;
            else if (ins == addiu) reg[a0] = reg[a1] + a2;
            else if (ins == slti) reg[a0] = reg[a1] < a2;
            else if (ins == sltiu) reg[a0] = (unsigned int)reg[a1] < (unsigned int)a2;
            else if (ins == andi) reg[a0] = reg[a1] & a2;
            else if (ins == ori) reg[a0] = reg[a1] | a2;
            else if (ins == xori) reg[a0] = reg[a1] ^ a2;
            else if (ins == sll) reg[a0] = reg[a1] << a2;
            else if (ins == srl) reg[a0] = (unsigned int)reg[a1] >> a2;
            else if (ins == sra) reg[a0] = reg[a1] >> a2;
        }
        else if (type == cal_rr)
        {
            if (ins == add && (INT_MAX-reg[a1] < reg[a2] || INT_MIN-reg[a1] > reg[a2])) //overflow
                instrs[i]->ins = ins = addu;
            else if (ins == sub && (reg[a1] > INT_MAX + reg[a2] || reg[a1] < INT_MIN + reg[a2]))
                instrs[i]->ins = ins = subu;
            if (ins == add) reg[a0] = reg[a1] + reg[a2];
            else if (ins == addu) reg[a0] = reg[a1] + reg[a2];
            else if (ins == sub) reg[a0] = reg[a1] - reg[a2];
            else if (ins == subu) reg[a0] = reg[a1] - reg[a2];
            else if (ins == slt) reg[a0] = reg[a1] < reg[a2];
            else if (ins == sltu) reg[a0] = (unsigned int)reg[a1] < (unsigned int)reg[a2];
            else if (ins == _and) reg[a0] = reg[a1] & reg[a2];
            else if (ins == _or) reg[a0] = reg[a1] | reg[a2];
            else if (ins == nor) reg[a0] = ~(reg[a1] | reg[a2]);
            else if (ins == _xor) reg[a0] = reg[a1] ^ reg[a2];
            else if (ins == sllv) reg[a0] = reg[a1] << (reg[a2] & 31);
            else if (ins == srlv) reg[a0] = (unsigned int)reg[a1] >> (reg[a2] & 31);
            else if (ins == srav) reg[a0] = reg[a1] >> (reg[a2] & 31);
        }
        else if (type == br_r2)
        {
            int flag = (ins == beq) ? reg[a0] == reg[a1] :
                        (ins == bne) ? reg[a0] != reg[a1] : 0;
            if (flag) { tag = a2; continue; }
        }
        else if (type == br_r1)
        {
            int flag = (ins == bgez) ? reg[a0] >= 0 :
                        (ins == bgtz) ? reg[a0] > 0 :
                        (ins == blez) ? reg[a0] <= 0 :
                        (ins == bltz) ? reg[a0] < 0 : 0;
            if (flag) { tag = a1; continue; }
        }
        else if (type == store)
        {
            int flag = 1;
            if (a1 + reg[a2] < 0 || a1 + reg[a2] > MEMSIZE) // address overflow
            {
                if (reg[a2] < -0x7fff || reg[a2] > 0x7fff) instrs[i] = new Instr(cal_ri, sll, 0, 0, 0), flag = 0;
                else instrs[i]->a1 = a1 = -reg[a2];
            }
            if (flag)
            {
                if (ins == sw && ((a1 + reg[a2]) & 3)) // address align
                    instrs[i]->ins = ins = sh;
                if (ins == sh && ((a1 + reg[a2]) & 1))
                    instrs[i]->ins = ins = sb;
                int addr = (reg[a2] + a1) >> 2, byteSel = (reg[a2] + a1) & 3;
                if (ins == sw)
                    mem[addr] = reg[a0];
                else if (ins == sh)
                    mem[addr] = (byteSel == 0) ? (mem[addr] & 0xffff0000) | ((reg[a0] << (8*byteSel)) & 0x0000ffff) :
                                (byteSel == 2) ? (mem[addr] & 0x0000ffff) | ((reg[a0] << (8*byteSel)) & 0xffff0000) : 0;
                else if (ins == sb)
                    mem[addr] = (byteSel == 0) ? (mem[addr] & 0xffffff00) | ((reg[a0] << (8*byteSel)) & 0x000000ff) :
                                (byteSel == 1) ? (mem[addr] & 0xffff00ff) | ((reg[a0] << (8*byteSel)) & 0x0000ff00) :
                                (byteSel == 2) ? (mem[addr] & 0xff00ffff) | ((reg[a0] << (8*byteSel)) & 0x00ff0000) :
                                (byteSel == 3) ? (mem[addr] & 0x00ffffff) | ((reg[a0] << (8*byteSel)) & 0xff000000) : 0;
            }
        }
        else if (type == load)
        {
            int flag = 1;
            if (a1 + reg[a2] < 0 || a1 + reg[a2] > MEMSIZE) // address overflow
            {
                if (reg[a2] < -0x7fff || reg[a2] > 0x7fff || (i > 0 && instrs[i-1]->type == -1)) instrs[i] = new Instr(cal_ri, sll, 0, 0, 0), flag = 0;
                else instrs[i]->a1 = a1 = -reg[a2];
            }
            if (flag)
            {
                if (ins == lw && ((a1 + reg[a2]) & 3)) // address align
                    instrs[i]->ins = ins = (rand() % 2 ? lh : lhu);
                if ((ins == lh) && ((a1 + reg[a2]) & 1))
                    instrs[i]->ins = ins = lb;
                if ((ins == lhu) && ((a1 + reg[a2]) & 1))
                    instrs[i]->ins = ins = lbu;
                int addr = (reg[a2] + a1) >> 2, byteSel = (reg[a2] + a1) & 3;
                if (ins == lw) reg[a0] = mem[addr];
                else if (ins == lh) reg[a0] = (mem[addr] >> (8*byteSel)) << 16 >> 16;
                else if (ins == lhu) reg[a0] = (mem[addr] >> (8*byteSel)) & 0xffff;
                else if (ins == lb) reg[a0] = (mem[addr] >> (8*byteSel)) << 24 >> 24;
                else if (ins == lbu) reg[a0] = (mem[addr] >> (8*byteSel)) & 0xff;
            }
        }
        else if (type == mf)
        {
            if (ins == mfhi) reg[a0] = HI;
            else if (ins == mflo) reg[a0] = LO;
        }
        else if (type == mt)
        {
            if (ins == mthi) HI = reg[a0];
            else if (ins == mtlo) LO = reg[a0];
        }
        else if (type == md)
        {
            if (ins == _div && reg[a1] == 0) //DivZero
                instrs[i]->ins = ins = mult;
            else if (ins == divu && reg[a1] == 0)
                instrs[i]->ins = ins = multu;
            if (ins == mult) HI = (1LL * reg[a0] * reg[a1]) >> 32, LO = 1LL * reg[a0] * reg[a1];
            else if (ins == multu) HI = (1uLL * (unsigned)reg[a0] * (unsigned)reg[a1]) >> 32, LO = 1uLL * (unsigned)reg[a0] * (unsigned)reg[a1];
            else if (ins == _div) HI = reg[a0] % reg[a1], LO = reg[a0] / reg[a1];
            else if (ins == divu) HI = (unsigned)reg[a0] % (unsigned)reg[a1], LO = (unsigned)reg[a0] / (unsigned)reg[a1];
        }
        else if (type == _lui) reg[a0] = a1 << 16;
        if (tag) i = 5*tag - 1 + INITINSNUM, tag = 0;
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

int main()
{
    srand(time(0));
    char pre[100] = "D:\\study\\CO\\p6\\PipelineCPU\\my_files\\test\\data\\testpoint\\testpoint";
    char path[100] = "D:\\study\\CO\\p6\\PipelineCPU\\my_files\\test\\test.asm";
    // sprintf(path, "%s%d.asm", pre, 0);
    // freopen(path, "w", stdout);
    // gnrtJump();
    for (int index = 1; index <= 10; index ++)
    {
        sprintf(path, "%s%d.asm", pre, index);
        freopen(path, "w", stdout);
        init();
        for (int i = 1, lastDst = 2, JBFlag = 0; i <= BLOCKNUM; i ++)
            gnrtBlock(i, lastDst, JBFlag);
        trace();
        for (int i = 0; i < (int)instrs.size(); i ++)
            instrs[i]->print();
        printf("nop\nnop\ntest_end:\nbeq  $0, $0, test_end\nnop");
    }
    return 0;
}
