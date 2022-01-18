`timescale 1ns / 1ps

`include "../../macros.v"

module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [3:0] ctrl,
    output [31:0] result
);
	
	assign result = (ctrl == `ALU_and) 	? srcA & srcB 		:
					(ctrl == `ALU_or)	? srcA | srcB 		:
				 	(ctrl == `ALU_add)	? srcA + srcB 		:
				 	(ctrl == `ALU_sub)	? srcA - srcB 		:
					(ctrl == `ALU_xor)	? srcA ^ srcB 		:
				 	(ctrl == `ALU_sll)	? srcB << srcA[4:0]	:
					(ctrl == `ALU_srl)	? srcB >> srcA[4:0]	:
					(ctrl == `ALU_lt)	? $signed($signed(srcA) < $signed(srcB)) :
					(ctrl == `ALU_ltu)	? srcA < srcB		:
					(ctrl == `ALU_sra)	? $signed($signed(srcB) >>> srcA[4:0])	 :
					(ctrl == `ALU_nor)	? ~(srcA | srcB)	:
					32'b0;

endmodule
