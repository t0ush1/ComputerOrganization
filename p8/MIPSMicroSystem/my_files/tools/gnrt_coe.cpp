#include <bits/stdc++.h>
#define endl '\n'
using namespace std;

string marsPath = "G:\\mars\\Mars_test.jar";
string prjPath = "D:\\study\\CO\\p8\\MIPSMicroSystem\\";
string asmPath = "D:\\study\\CO\\p8\\upload\\uart_echo\\uart_echo.asm";

string code = prjPath + "code.tmp";
string handler = prjPath + "handler.tmp";
string codeFile = prjPath + "code.coe";

int main()
{
    system(("java -jar " + marsPath + " db nc mc CompactDataAtZero a dump .text HexText " + code + " " + asmPath).c_str());
    system(("java -jar " + marsPath + " db nc mc CompactDataAtZero a dump 0x00004180-0x00005180 HexText " + handler + " " + asmPath).c_str());

    ifstream codeSrc(code);
    ifstream handlerSrc(handler);
    ofstream codeDst(codeFile);
    int cnt = 0;
    string instr;
    codeDst << "memory_initialization_radix=16;" << endl;
    codeDst << "memory_initialization_vector=" << endl;
    while (codeSrc >> instr)
        codeDst << instr + "," << endl, cnt ++;
    for (int i = cnt; i < 1120; i ++)
        codeDst << "00000000," << endl;
    while (handlerSrc >> instr)
        codeDst << instr + "," << endl;
    codeDst << "00000000;";
    codeSrc.close();
    handlerSrc.close();
    remove(code.c_str());
    remove(handler.c_str());

    return 0;
}