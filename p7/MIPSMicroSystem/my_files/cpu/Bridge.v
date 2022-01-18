`timescale 1ns / 1ps

`include "macros.v"

module Bridge (
    input [31:0] addr,
    input [3:0] byteEn,
    input [31:0] DMRD,
    input [31:0] TC1RD,
    input [31:0] TC2RD,
    output [3:0] DMByteEn,
    output TC1Write,
    output TC2Write,
    output [31:0] RD
);

    wire hitDM;
    wire hitTC1;
    wire hitTC2;

    assign hitDM = addr >= `Data_Base_Addr && addr <= `Data_Limit_Addr;
    assign hitTC1 = addr >= `TC1_Base_Addr && addr <= `TC1_Limit_Addr;
    assign hitTC2 = addr >= `TC2_Base_Addr && addr <= `TC2_Limit_Addr;

    assign DMByteEn = hitDM ? byteEn : 4'b0;
    assign TC1Write = hitTC1 & (&byteEn);
    assign TC2Write = hitTC2 & (&byteEn);

    assign RD = hitDM ? DMRD :
                hitTC1 ? TC1RD :
                hitTC2 ? TC2RD :
                32'bx;

endmodule