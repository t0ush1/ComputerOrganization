`timescale 1ns / 1ps

`include "../../macros.v"

module NPC(
    input [31:0] PC_F,
    input [31:0] PC_D,
    input [31:0] offset,
    input [25:0] index,
    input [31:0] register,
    input [2:0] ctrl,
    output [31:0] PCAdd8,
    output [31:0] nextPC
    );
	
	assign PCAdd8 = PC_D + 8;
	
	assign nextPC = (ctrl == `NPC_add4)     ? PC_F + 4                      :
                    (ctrl == `NPC_offset)	? offset + PC_D + 4				:
					(ctrl == `NPC_index)	? { PC_D[31:28], index, 2'b0 }	:
					(ctrl == `NPC_reg)		? register						:
					32'bx;
	
endmodule
