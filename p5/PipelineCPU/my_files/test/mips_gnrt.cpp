#include <fstream>
#include <cstdlib>
#include <ctime>
#include <vector>
using namespace std;

#define ranReg (rand() % 31 + 1) //except $0
#define ranImm(x) (rand() % (1 << (x)))
#define getPC(i) (0x3000 + ((i) - tagCnt) * 4)

ofstream cout("test.txt");
const int MEMSIZE = 4096;
const int INSTYPENUM = 8;
vector<string> instrs;

enum INS { ori, addu, beq, sw, lw, jal, jr, lui };
char format[INSTYPENUM][50] = { "ori $%d, $%d, %d",
	                            "addu $%d, $%d, $%d",
	                            "beq $%d, $%d, TAG%d",
	                            "sw $%d, %d($%d)",
	                            "lw $%d, %d($%d)",
	                            "jal TAG%d",
	                            "jr $%d",
	                            "lui $%d, %d" };

char* insToStr(char* dst, int type, int a0, int a1, int a2)
{
	sprintf(dst, format[type], a0, a1, a2);
	return dst;
}

void init()
{
    freopen("test.txt", "w", stdout);
    srand(time(0));
    char instr[50];
    for (int i = 1; i <= 31; i ++)      // init reg
        instrs.push_back(insToStr(instr, ori, i, 0, ranImm(16)));
    for (int i = 0; i < MEMSIZE; i += 4)    // init mem
        instrs.push_back(insToStr(instr, sw, ranReg, i, 0));
}

void gnrtBlock(int index)
{
    char instr[50];
    int type, a0, a1, a2, isJBTag = 0;
    int dstReg[10], cnt = 0;
    for (int i = 0; i < 4; i ++)
    {
        type = rand() % INSTYPENUM;
        switch (type)
        {
            case ori:
                a0 = ranReg;
                a1 = (cnt ? dstReg[rand() % cnt] : ranReg);
                a2 = ranImm(16);
                dstReg[cnt ++] = a0;
                break;
            case addu:
                a0 = ranReg;
                a1 = (cnt ? dstReg[rand() % cnt] : ranReg);
                a2 = (cnt ? dstReg[rand() % cnt] : ranReg);
                dstReg[cnt ++] = a0;
                break;
            case beq:
                a0 = (cnt ? dstReg[rand() % cnt] : ranReg);
                a1 = (rand() % 2 ? (cnt ? dstReg[rand() % cnt] : ranReg) : a0);
                a2 = index;
                isJBTag = 1;
                break;
            case sw:
                a0 = (cnt ? dstReg[rand() % cnt] : ranReg);
                a1 = 0;
                a2 = (cnt ? dstReg[rand() % cnt] : ranReg);
                if (a2 == 31) a2 == 30;
                break;
            case lw:
                a0 = ranReg;
                a1 = 0;
                a2 = (cnt ? dstReg[rand() % cnt] : ranReg);
                dstReg[cnt ++] = a0;
                if (a2 == 31) a2 == 30;
                break;
            case jal:
                a0 = index;
                dstReg[cnt ++] = 31;
                isJBTag = 1;
                break;
            case jr:
                a0 = (cnt ? dstReg[rand() % cnt] : ranReg);
                if (a0 == 31) a0 == 30;
                break;
            case lui:
                a0 = ranReg;
                a1 = ranImm(16);
                dstReg[cnt ++] = a0;
                break;
        }
        instrs.push_back(insToStr(instr, type, a0, a1, a2));
    }
    sprintf(instr, "TAG%d:", index);
    if (isJBTag) instrs.push_back(instr);
}

void checkDelayedBranch()
{
    char instr[50];
    string tmp;
    int isjump = 0, a0, a1, a2;
    for (int i = 0; i < (int)instrs.size(); i ++)
        if (instrs[i].find("beq") == 0)
        {
            sscanf(instrs[i].c_str(), format[beq], &a0, &a1, &a2);
            if (isjump)
            {
                tmp = insToStr(instr, ori, a0, 0, 1);
                instrs.insert(instrs.begin()+i, tmp);
                i ++;
            }
            isjump = 1;
        }
        else if (instrs[i].find("jal") == 0)
        {
            sscanf(instrs[i].c_str(), format[jal], &a0);
            if (isjump)
            {
                tmp = insToStr(instr, ori, 0, 0, 0);
                instrs.insert(instrs.begin()+i, tmp);
                i ++;
            }
            isjump = 1;
        }
        else if (instrs[i].find("jr") == 0)
        {
            sscanf(instrs[i].c_str(), format[jr], &a0);
            if (isjump)
            {
                tmp = insToStr(instr, ori, a0, 0, 0);
                instrs.insert(instrs.begin()+i, tmp);
                i ++;
            }
            isjump = 1;
        }
        else if (instrs[i].find("TAG") != 0) isjump = 0;
}

void trace()
{
    int tagCnt = 0;
    char instr[50]; string s;
    int GRF[32] = {}, a0, a1, a2;
    for (int i = 1055; i < (int)instrs.size(); i ++)
        if (instrs[i].find("sw") == 0)
        {
            sscanf(instrs[i].c_str(), format[sw], &a0, &a1, &a2);
            int ran = ranImm(15);
            a1 = -ran + ((rand() % MEMSIZE) >> 2 << 2);
            s = insToStr(instr, sw, a0, a1, a2);
            instrs[i].replace(0, instrs[i].length(), s);
            s = insToStr(instr, ori, a2, 0, ran);
            instrs.insert(instrs.begin()+i, s);
            i ++;
        }
        else if (instrs[i].find("lw") == 0)
        {
            sscanf(instrs[i].c_str(), format[lw], &a0, &a1, &a2);
            int ran = ranImm(15);
            a1 = -ran + ((rand() % MEMSIZE) >> 2 << 2);
            s = insToStr(instr, lw, a0, a1, a2);
            instrs[i].replace(0, instrs[i].length(), s);
            s = insToStr(instr, ori, a2, 0, ran);
            instrs.insert(instrs.begin()+i, s);
            i ++;
        }
        else if (instrs[i].find("jr") == 0)
        {
            sscanf(instrs[i].c_str(), format[jr], &a0);
            s = insToStr(instr, ori, a0, 0, getPC(i + 2));
            instrs.insert(instrs.begin()+i, s);
            i ++;
        }
        else if (instrs[i].find("TAG") == 0) tagCnt ++;
}

int main()
{
    init();
    for (int i = 0; i < 400; i ++) gnrtBlock(i);
    checkDelayedBranch();
    trace();
    for (int i = 0; i < (int)instrs.size(); i ++)
    	puts(instrs[i].c_str());
    printf("nop\nnop\ntest_end:\nbeq  $0, $0, test_end\nnop");
    return 0;
}
