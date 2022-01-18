#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>
using namespace std;

///////////////// const value ///////////////////////////////////////////////////////////////////////////
#define TYPENUM 16
#define MAXINSNUM 13
#define MEMSIZE 128
#define BLOCKNUM 50
#define INITINSNUM 4

enum TYPE { cal_ri, cal_rr, br_r2, br_r1, store, load, mf, mt, md, lui, jal, jr, jalr, mfc0, mtc0, movz }; //except j, eret
enum CALRI { addi, addiu, slti, sltiu, andi, ori, xori, sll, srl, sra };
enum CALRR { add, addu, sub, subu, slt, sltu, _and, _or, nor, _xor, sllv, srlv, srav };
enum BRR2 { beq, bne };
enum BRR1 { bgez, bgtz, blez, bltz };
enum STORE { sw, sh, sb };
enum LOAD { lw, lh, lhu, lb, lbu };
enum MF { mfhi, mflo };
enum MT { mthi, mtlo };
enum MD { mult, multu }; //except div

const int insNum[TYPENUM] = { 10, 13, 2, 4, 3, 5, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1 };
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
    "%s $%d, %d",
    "%s TAG%d",
    "%s $%d",
    "%s $%d, $%d",
    "%s $%d, $%d",
    "%s $%d, $%d",
    "%s $%d, $%d, $%d"
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
    { "lui" },
    { "jal" },
    { "jr" },
    { "jalr" },
    { "mfc0" },
    { "mtc0" },
    { "movz" }
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////// generate //////////////////////////////////////////////////////////////////////////////////////////
#define ranReg (rand() % 4 + 28) //only $28 ~ $31
#define ranCP0Reg (rand() % 3 + 12)

struct Instr {
    int type, ins, a0, a1, a2;
    Instr() {}
    Instr(int type, int ins, int a0, int a1, int a2) : type(type), ins(ins), a0(a0), a1(a1), a2(a2) {}
    Instr(int index) : type(-1), a0(index) {}
    void print()
    {
        if (type == -1) printf("TAG%d:", a0);
        else printf(format[type], insName[type][ins], a0, a1, a2);
        puts("");
    }
};

vector<Instr*> instrs;

int ranImm(int bitwidth, int flag) // if flag = 0, only > 0
{
    if (bitwidth <= 0 || bitwidth > 32 || (flag != 0 && flag != 1)) return 0;
    int num[32] = {}, isMinus = flag * (rand() % 2), ret = 0;
    for (int i = 0; i <= 32 - bitwidth; i ++) num[i] = isMinus;
    for (int i = 33-bitwidth; i < 32; i ++) num[i] = rand() % 2;
    for (int i = 0; i < 32; i ++) ret = ret << 1 | num[i];
    return ret ? ret : 1;
}

void init()
{
    puts(".text");
    puts("ori $k1, $0, 0x301c");
    puts("ori $31, $0, 0x1001");
    puts("mtc0 $31, $12");
    instrs.clear();
    for (int i = 28; i <= 31; i ++)
        instrs.push_back(new Instr(cal_ri, ori, i, 0, ranImm(16, 0)));
}

void gnrtBlock(int index, int& lastDst, int& JBFlag)
{
    int type, ins, a0, a1, a2;
    int dstReg[10] = {lastDst}, cnt = 1;
    for (int i = 0; i < 4; i ++)
    {
        type = rand() % TYPENUM;
        if (type == br_r2 || type == br_r1 || type == jal || type == jalr || type == jr) // DoubleDelay 
        {
            if (JBFlag)
                while (type == br_r2 || type == br_r1 || type == jal || type == jalr || type == jr)
                    type = rand() % TYPENUM, JBFlag = 0;
            else JBFlag = 1;
        }
        else JBFlag = 0;
        ins = rand() % insNum[type];
        if (type == cal_ri) a0 = ranReg, a1 = dstReg[rand()%cnt], a2 = ranImm(5, 0), dstReg[cnt++] = a0;
        else if (type == cal_rr) a0 = ranReg, a1 = dstReg[rand()%cnt], a2 = dstReg[rand()%cnt], dstReg[cnt++] = a0;
        else if (type == br_r2) a0 = dstReg[rand()%cnt], a1 = dstReg[rand()%cnt], a2 = index;
        else if (type == br_r1) a0 = dstReg[rand()%cnt], a1 = index;
        else if (type == store) a0 = dstReg[rand()%cnt], a1 = 0, a2 = dstReg[rand()%cnt];
        else if (type == load) a0 = ranReg, a1 = 0, a2 = dstReg[rand()%cnt], dstReg[cnt++] = a0;
        else if (type == mf) a0 = ranReg, dstReg[cnt++] = a0;
        else if (type == mt) a0 = dstReg[rand()%cnt];
        else if (type == md) a0 = dstReg[rand()%cnt], a1 = dstReg[rand()%cnt];
        else if (type == lui) a0 = ranReg, a1 = ranImm(16, 0), dstReg[cnt++] = a0;
        else if (type == jal) a0 = index;
        else if (type == jr) a0 = dstReg[rand()%cnt];
        else if (type == jalr) { a1 = dstReg[rand()%cnt]; while ((a0 = ranReg) == a1); dstReg[cnt++] = a0; } // JalrSame
        else if (type == mfc0) a0 = ranReg, a1 = ranCP0Reg, dstReg[cnt++] = a0;
        else if (type == mtc0) a0 = dstReg[rand()%cnt], a1 = 14;
        else if (type == movz) a0 = a1 = a2 = 0;
        instrs.push_back(new Instr(type, ins, a0, a1, a2));
    }
    instrs.push_back(new Instr(index));
    lastDst = dstReg[cnt-1];
}

void gnrtHandler(string& handlerText)
{
    char s[100];
    freopen("D:\\study\\CO\\p7\\MIPSMicroSystem\\my_files\\test\\handler.s", "r", stdin);
    while (fgets(s, 100, stdin)) handlerText += s;
}

//// main //////////////////////////////////////////////////////////////////////////////////////////////////////

int main()
{
    srand(time(0));
    char pre[100] = "D:\\study\\CO\\p7\\MIPSMicroSystem\\my_files\\test\\data\\testpoint\\testpoint";
    char path[100] = "D:\\study\\CO\\p7\\MIPSMicroSystem\\my_files\\test\\test.asm";
    string handlerText = "";
    gnrtHandler(handlerText);
    for (int index = 9; index < 10; index ++)
    {
        sprintf(path, "%s%d.asm", pre, index);
        freopen(path, "w", stdout);
        init();
        for (int i = 1, lastDst = 31, JBFlag = 0; i <= BLOCKNUM; i ++)
            gnrtBlock(i, lastDst, JBFlag);
        for (int i = 0; i < (int)instrs.size(); i ++)
            instrs[i]->print();
        printf("nop\nnop\ntest_end:\nbeq  $0, $0, test_end\nnop\n\n\n");
        printf(handlerText.c_str());
    }
    return 0;
}
