`timescale 1ns / 1ps

`include "../macros.v"

module HazardSolveUnit (
    input [2:0] Tuse_A1_D,
    input [2:0] Tuse_A2_D,
    input [4:0] regA1_D,
    input [4:0] regA2_D,
    input [4:0] regA1_E,
    input [4:0] regA2_E,
    input [4:0] regA2_M,

    input [2:0] Tnew_E,
    input [2:0] Tnew_M,
    input [2:0] Tnew_W,
    input [4:0] regA3_E,
    input [4:0] regA3_M,
    input [4:0] regA3_W,

    input start,
    input busy,
    input md,
    input mt,
    input mf,

    input eret,
    input CP0Write_E,
    input CP0Write_M,
    input [4:0] rd_E,
    input [4:0] rd_M,

    output [1:0] regRD1Forward_D,
    output [1:0] regRD2Forward_D,
    output [1:0] regRD1Forward_E,
    output [1:0] regRD2Forward_E,
    output regRD2Forward_M,
    output stall
);

////// forward ////////////////////////////////////////////////////////////////////////////////////
    assign regRD1Forward_D = (regA3_E && regA3_E == regA1_D) ? `forward_D_EXBack  :
                             (regA3_M && regA3_M == regA1_D) ? `forward_D_MEMBack :
                             `forward_D_orig;
    assign regRD2Forward_D = (regA3_E && regA3_E == regA2_D) ? `forward_D_EXBack  :
                             (regA3_M && regA3_M == regA2_D) ? `forward_D_MEMBack :
                             `forward_D_orig;
    assign regRD1Forward_E = (regA3_M && regA3_M == regA1_E) ? `forward_E_MEMBack :
                             (regA3_W && regA3_W == regA1_E) ? `forward_E_WBBack  :
                             `forward_E_orig;
    assign regRD2Forward_E = (regA3_M && regA3_M == regA2_E) ? `forward_E_MEMBack :
                             (regA3_W && regA3_W == regA2_E) ? `forward_E_WBBack  :
                             `forward_E_orig;
    assign regRD2Forward_M = (regA3_W && regA3_W == regA2_M) ? `forward_M_WBBack  :
                             `forward_M_orig;
    
////// stall ///////////////////////////////////////////////////////////////////////////////////////
    wire regA1Stall_E;
    wire regA1Stall_M;
    wire regA1Stall;
    assign regA1Stall_E = (regA3_E && regA3_E == regA1_D) && (Tuse_A1_D < Tnew_E);
    assign regA1Stall_M = (regA3_M && regA3_M == regA1_D) && (Tuse_A1_D < Tnew_M);
    assign regA1Stall = regA1Stall_E | regA1Stall_M;

    wire regA2Stall_E;
    wire regA2Stall_M;
    wire regA2Stall;
    assign regA2Stall_E = (regA3_E && regA3_E == regA2_D) && (Tuse_A2_D < Tnew_E);
    assign regA2Stall_M = (regA3_M && regA3_M == regA2_D) && (Tuse_A2_D < Tnew_M);
    assign regA2Stall = regA2Stall_E | regA2Stall_M;

    wire MDUStall;
    assign MDUStall = (start | busy) & (md | mt | mf);

    wire EPCStall;
    assign EPCStall = eret && ((CP0Write_E && rd_E == `CP0Addr_EPC) || (CP0Write_M && rd_M == `CP0Addr_EPC));

    assign stall = regA1Stall | regA2Stall | MDUStall | EPCStall;

endmodule