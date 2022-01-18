`timescale 1ns / 1ps

`include "../../macros.v"

module CP0 (
    input clk,
    input reset,
    input [4:0] A1,
    input [4:0] A2,
    input [31:0] WD,
    input [31:0] PC,
    input [4:0] excCode,
    input [5:0] HWInt,
    input WE,
    input EXLReset,
    input BD,
    output intExcReq,
    output reg [31:0] EPC,
    output [31:0] RD,
    output reg respTbInt
);

    reg [31:0] SR;
    reg [31:0] Cause;
    reg [31:0] PrID = 32'h20373944;

    wire excReq;
    wire intReq;
    
    assign intReq = `IE & ~`EXL & (|(`IM & HWInt));
    assign excReq = |excCode & ~`EXL;
    assign intExcReq = excReq | intReq;

    assign RD = (A1 == `CP0Addr_SR)     ? SR :
                (A1 == `CP0Addr_Cause)  ? Cause :
                (A1 == `CP0Addr_EPC)    ? EPC :
                (A1 == `CP0Addr_PrID)   ? PrID :
                32'bx;

    always @(posedge clk) begin
        if (reset)
            respTbInt <= 1'b0;
        else
            respTbInt <= `IE & ~`EXL & SR[12] & HWInt[2];
    end

    always @(posedge clk) begin
        if (reset)
            SR <= 32'h0;
        else begin
            if (EXLReset)
                `EXL <= 1'b0;
            if (intExcReq)
                `EXL <= 1'b1;
            if (WE && A2 == `CP0Addr_SR)
                { `IM, `EXL, `IE } <= { WD[15:10], WD[1:0] };
        end
    end

    always @(posedge clk) begin
        if (reset)
            Cause <= 32'b0;
        else begin
            `IP <= HWInt;
            if (intExcReq) begin
                `BD <= BD;
                `ExcCode <= intReq ? 5'd0 : excCode;
            end
        end
    end

    always @(posedge clk) begin
        if (reset)
            EPC <= 32'b0;
        else begin
            if (intExcReq)
                EPC <= BD ? PC - 4 : PC;
            if (WE && A2 == `CP0Addr_EPC)
                EPC <= WD;
        end
    end

endmodule