`timescale 1ns / 1ps

`include "macros.v"

module Bridge (
    input [31:0] addr,
    input [3:0] byteEn,
    input [31:0] DMRD,
    input [31:0] TCRD,
    input [31:0] DTRD,
    input [31:0] UARTRD,
    input [31:0] IORD,
    output [3:0] DMByteEn,
    output TCWrite,
    output [3:0] DTByteEn,
    output UARTWrite,
    output [3:0] IOByteEn,
    output [31:0] RD
);

    wire hitDM;
    wire hitTC;
    wire hitDT;
    wire hitUART;
    wire hitIO;

    assign hitDM = addr >= `Data_Base_Addr && addr <= `Data_Limit_Addr;
    assign hitTC = addr >= `TC_Base_Addr && addr <= `TC_Limit_Addr;
    assign hitDT = addr >= `DT_Base_Addr && addr <= `DT_Limit_Addr;
    assign hitUART = addr >= `UART_Base_Addr && addr <= `UART_Limit_Addr;
    assign hitIO = addr >= `IO_Base_Addr && addr <= `IO_Limit_Addr;

    assign DMByteEn = hitDM ? byteEn : 4'b0;
    assign TCWrite = hitTC & (&byteEn);
    assign DTByteEn = hitDT ? byteEn : 4'b0;
    assign UARTWrite = hitUART & (&byteEn);
    assign IOByteEn = hitIO ? byteEn : 4'b0;

    assign RD = hitDM ? DMRD :
                hitTC ? TCRD :
                hitDT ? DTRD :
                hitUART ? UARTRD :
                hitIO ? IORD :
                32'b0;

endmodule