`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:35 11/13/2021 
// Design Name: 
// Module Name:    datapath 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`define REGADDR_rt 2'b00
`define REGADDR_rd 2'b01
`define REGADDR_ra 2'b10

`define ALUSRCB_reg 1'b0
`define ALUSRCB_imm 1'b1

`define REGWD_alu 2'b00
`define REGWD_mem 2'b01
`define REGWD_pc4 2'b10

module Datapath(
    input regWrite,
    input [1:0] regDst,
    input [1:0] regSrc,
    input memWrite,
    input ALUSrc,
    input [4:0] ALUCtrl,
    input [2:0] EXTCtrl,
    input [2:0] NPCCtrl,
	input [2:0] DMCtrl,
    input clk,
    input reset,
    output [5:0] op,
    output [5:0] funct,
	output [4:0] rt,
	output ALUFlag
    );
	
	wire [31:0] PC;
	wire [31:0] nextPC;
	wire [31:0] PCAdd4;
	wire [31:0] ins;
	wire [4:0] 	rs;
	wire [4:0] 	rd;
	wire [4:0] 	shamt;
	wire [15:0] imm16;
	wire [25:0] index;
	wire [4:0] 	regAddr;
	wire [31:0] regRD1;
	wire [31:0] regRD2;
	wire [31:0] regWD;
	wire [31:0] imm32;
	wire [31:0] ALUSrcB;
	wire [31:0] ALUResult;
	wire [31:0] memAddr;
	wire [31:0] memWD;
	wire [31:0] memRD;
	
	assign rs 		= ins[25:21];
	assign rt 		= ins[20:16];
	assign rd 		= ins[15:11];
	assign shamt 	= ins[10:6];
	assign imm16 	= ins[15:0];
	assign index 	= ins[25:0];
	assign op 		= ins[31:26];
	assign funct 	= ins[5:0];
	assign memWD 	= regRD2;
	assign memAddr 	= ALUResult;
	
	assign regAddr = (regDst == `REGADDR_rt) ? rt		:
					 (regDst == `REGADDR_rd) ? rd 		:
					 (regDst == `REGADDR_ra) ? 5'b11111 :
					 5'b0;
	
	assign ALUSrcB = (ALUSrc == `ALUSRCB_reg) ? regRD2	:
					 (ALUSrc == `ALUSRCB_imm) ? imm32	:
					 32'b0;
	
	assign regWD = (regSrc == `REGWD_alu) ? ALUResult	:
				   (regSrc == `REGWD_mem) ? memRD		:
				   (regSrc == `REGWD_pc4) ? PCAdd4		:
				   32'b0;
	
	PC pc (
		.nextPC(nextPC),
		.clk(clk),
		.reset(reset),
		.PC(PC)
	);
	
	IM im (
		.A(PC[11:2]),
		.RD(ins)
	);
	
	GRF grf (
		.A1(rs),
		.A2(rt),
		.A3(regAddr),
		.WD(regWD),
		.WE(regWrite),
		.clk(clk),
		.reset(reset),
		.PC(PC),
		.RD1(regRD1),
		.RD2(regRD2)
	);
	
	EXT ext (
		.imm16(imm16),
		.ctrl(EXTCtrl),
		.imm32(imm32)
	);
	
	ALU alu (
		.srcA(regRD1),
		.srcB(ALUSrcB),
		.shamt(shamt),
		.ctrl(ALUCtrl),
		.out(ALUResult),
		.flag(ALUFlag)
	);
	
	DM dm (
		.A(memAddr),
		.ctrl(DMCtrl),
		.WD(memWD),
		.WE(memWrite),
		.clk(clk),
		.reset(reset),
		.PC(PC),
		.RD(memRD)
	);
	
	NPC npc (
		.PC(PC),
		.offset(imm32),
		.index(index),
		.register(regRD1),
		.ctrl(NPCCtrl),
		.PCAdd4(PCAdd4),
		.nextPC(nextPC)
	);
	
///////////////////////////////////////////////////////////////////////////
// `define __DEBUG__
`ifdef __DEBUG__
	wire [32*8-1:0] asm;
	DASM tool_dasm(
		.pc(PC),
		.instr(ins),
		.imm_as_dec(1'b1),
		.reg_name(1'b0),
		.asm(asm)
	);
	always @(posedge clk) begin
		if (reset);
		else begin
			if (regWrite && regAddr != 5'b0)
				$display("asm: %s", asm);
			else;
			if (memWrite) begin
				$display("asm: %s", asm);
				if (memAddr[11:2] == 10'b0)
					$display("breakpoint");
			end
			else;
		end
	end
`endif
////////////////////////////////////////////////////////////////////////////
	
endmodule
