`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:20:39 11/13/2021 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

	wire regWrite;
    wire [1:0] regDst;
    wire [1:0] regSrc;
    wire memWrite;
    wire ALUSrc;
    wire [4:0] ALUCtrl;
    wire [2:0] EXTCtrl;
    wire [2:0] NPCCtrl;
	wire [2:0] DMCtrl;
    wire [5:0] op;
    wire [5:0] funct;
	wire [4:0] rt;
	wire ALUFlag;

	Datapath datapath (
		.regWrite(regWrite),
		.regDst(regDst),
		.regSrc(regSrc),
		.memWrite(memWrite),
		.ALUSrc(ALUSrc),
		.ALUCtrl(ALUCtrl),
		.EXTCtrl(EXTCtrl),
		.NPCCtrl(NPCCtrl),
		.DMCtrl(DMCtrl),
		.clk(clk),
		.reset(reset),
		.op(op),
		.funct(funct),
		.rt(rt),
		.ALUFlag(ALUFlag)
	);
	
	Controller controller (
		.op(op),
		.funct(funct),
		.rt(rt),
		.ALUFlag(ALUFlag),
		.regWrite(regWrite),
		.regDst(regDst),
		.regSrc(regSrc),
		.memWrite(memWrite),
		.ALUSrc(ALUSrc),
		.ALUCtrl(ALUCtrl),
		.EXTCtrl(EXTCtrl),
		.NPCCtrl(NPCCtrl),
		.DMCtrl(DMCtrl)
	);
	
endmodule
