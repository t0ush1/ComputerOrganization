#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <cstring>
using namespace std;

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
const char format_in[TYPENUM][30] = {
    "$%d, $%d, %d",
    "$%d, $%d, $%d",
    "$%d, $%d, TAG%d",
    "$%d, TAG%d",
    "$%d, %d($%d)",
    "$%d, %d($%d)",
    "$%d",
    "$%d",
    "$%d, $%d",
    "$%d, %d"
};
const char format_out[TYPENUM][30] = {
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
            printf(format_out[type], insName[type][ins], a0, a1, a2);
        puts("");
    }
};

vector<Instr*> instrs;

void loadMips()
{
    char s[10];
    int a0, a1, a2;
    while (~scanf("%s ", s))
    {
        int flag = 0;
        for (int i = 0; i <TYPENUM && !flag; i ++)
            for (int j = 0; j < insNum[i] && !flag; j ++)
                if (!strcmp(s, insName[i][j]))
                {
                    scanf(format_in[i], &a0, &a1, &a2);
                    instrs.push_back(new Instr(i, j, a0, a1, a2));
                    flag = 1;
                }
        if (!flag)
        {
            scanf("TAG:%d", &a0);
            instrs.push_back(new Instr(a0));
        }
    }
}

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
            if (a0) printf("$%2d <= %08x\n", a0, reg[a0]);
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
            printf("$%2d <= %08x\n", a0, reg[a0]);
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
                printf("*%08x <= %08x\n", addr << 2, mem[addr]);
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
                printf("$%2d <= %08x\n", a0, reg[a0]);
            }
        }
        else if (type == mf)
        {
            if (ins == mfhi) reg[a0] = HI;
            else if (ins == mflo) reg[a0] = LO;
            printf("$%2d <= %08x\n", a0, reg[a0]);
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
        else if (type == _lui)
        {
        	reg[a0] = a1 << 16;
        	printf("$%2d <= %08x\n", a0, reg[a0]);
		}
        if (tag) i = 5*tag - 1 + INITINSNUM, tag = 0;
    }
}

int main()
{
    freopen("D:\\study\\CO\\p6\\PipelineCPU\\my_files\\test\\test.asm", "r", stdin);
    loadMips();
//    for (int i = 0; i < (int)instrs.size(); i ++)
//    	instrs[i]->print();
    trace();
    return 0;
}
