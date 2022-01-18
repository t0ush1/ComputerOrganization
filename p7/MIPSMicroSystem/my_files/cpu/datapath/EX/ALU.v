`timescale 1ns / 1ps

`include "../../macros.v"

module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [3:0] ctrl,
    output [31:0] result,
	output overflow
);
	
	wire [63:0] shiftLeftCyclic;
	wire [63:0] shiftRightCyclic;
	assign shiftLeftCyclic = { srcB, srcB } << srcA[4:0];
	assign shiftRightCyclic = { srcB, srcB } >> srcA[4:0];
	
	wire [32:0] extAdd;
	wire [32:0] extSub;
	assign extAdd = { srcA[31], srcA } + { srcB[31], srcB };
	assign extSub = { srcA[31], srcA } - { srcB[31], srcB };
	assign overflow = (extAdd[32] != extAdd[31] && ctrl == `ALU_add ) || (extSub[32] != extSub[31] && ctrl == `ALU_sub);

	assign result = (ctrl == `ALU_and) 	? srcA & srcB 								:
					(ctrl == `ALU_or)	? srcA | srcB 								:
				 	(ctrl == `ALU_add)	? srcA + srcB 								:
				 	(ctrl == `ALU_sub)	? srcA - srcB 								:
					(ctrl == `ALU_xor)	? srcA ^ srcB 								:
				 	(ctrl == `ALU_sll)	? srcB << srcA[4:0]							:
					(ctrl == `ALU_srl)	? srcB >> srcA[4:0]							:
					(ctrl == `ALU_lt)	? $signed($signed(srcA) < $signed(srcB))	:
					(ctrl == `ALU_ltu)	? srcA < srcB								:
					(ctrl == `ALU_sra)	? $signed($signed(srcB) >>> srcA[4:0])		:
					(ctrl == `ALU_nor)	? ~(srcA | srcB)							:
					(ctrl == `ALU_slc)	? shiftLeftCyclic[63:32]					:
					(ctrl == `ALU_src)	? shiftRightCyclic[31:0]					:
					32'bx;

endmodule
