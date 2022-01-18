`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:31 11/13/2021 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input [5:0] op,
    input [5:0] funct,
    input [4:0] rt,
    input ALUFlag,
    output regWrite,
    output [1:0] regDst,
    output [1:0] regSrc,
    output memWrite,
    output ALUSrc,
    output [4:0] ALUCtrl,
    output [2:0] EXTCtrl,
    output [2:0] NPCCtrl,
    output [2:0] DMCtrl
    );
	
	
	
	wire R;
	wire bgez_or_bltz;

	wire addu;
	wire subu;
	wire ori;
	wire lw;
	wire sw;
	wire beq;
	wire lui;
	wire jal;
	wire jr;
	wire sll;
	wire _and;
	wire _or;
	wire sllv;
	wire slt;
	wire j;
	wire addi;
	wire sh;
	wire sb;
	wire lh;
	wire lb;
	wire slti;
	wire addiu;
	wire bgez;
	wire bltz;
	wire bgtz;
	wire blez;
	wire bne;
	wire jalr;
	wire add;
	wire sub;
	wire _nor;
	wire sltu;
	wire srav;
	wire srlv;
	wire _xor;
	wire andi;
	wire srl;
	wire sltiu;
	wire sra;
	wire xori;
	wire lbu;
	wire lhu;



	assign R 			= ~|(op ^ 6'b000000);
	assign bgez_or_bltz = ~|(op ^ 6'b000001);

	assign ori 			= ~|(op ^ 6'b001101);
	assign lw 			= ~|(op ^ 6'b100011);
	assign sw			= ~|(op ^ 6'b101011);
	assign beq 			= ~|(op ^ 6'b000100);
	assign lui 			= ~|(op ^ 6'b001111);
	assign jal 			= ~|(op ^ 6'b000011);
	assign j 			= ~|(op ^ 6'b000010);
	assign addi  		= ~|(op ^ 6'b001000);
	assign sh    		= ~|(op ^ 6'b101001);
	assign sb    		= ~|(op ^ 6'b101000);
	assign lh	 		= ~|(op ^ 6'b100001);
	assign lb	 		= ~|(op ^ 6'b100000);
	assign slti	 		= ~|(op ^ 6'b001010);
	assign addiu 		= ~|(op ^ 6'b001001);
	assign bgtz			= ~|(op ^ 6'b000111);
	assign blez			= ~|(op ^ 6'b000110);
	assign bne			= ~|(op ^ 6'b000101);
	assign andi			= ~|(op ^ 6'b001100);
	assign sltiu		= ~|(op ^ 6'b001011);
	assign xori			= ~|(op ^ 6'b001110);
	assign lbu			= ~|(op ^ 6'b100100);
	assign lhu			= ~|(op ^ 6'b100101);

	assign addu = R & ~|(funct ^ 6'b100001);
	assign subu = R & ~|(funct ^ 6'b100011);
	assign jr 	= R & ~|(funct ^ 6'b001000);
	assign sll 	= R & ~|(funct ^ 6'b000000);
	assign _and = R & ~|(funct ^ 6'b100100);
	assign _or 	= R & ~|(funct ^ 6'b100101);
	assign sllv = R & ~|(funct ^ 6'b000100);
	assign slt 	= R & ~|(funct ^ 6'b101010);
	assign jalr = R & ~|(funct ^ 6'b001001);
	assign add  = R & ~|(funct ^ 6'b100000);
	assign sub	= R & ~|(funct ^ 6'b100010);
	assign _nor	= R & ~|(funct ^ 6'b100111);
	assign sltu	= R & ~|(funct ^ 6'b101011);
	assign srav	= R & ~|(funct ^ 6'b000111);
	assign srlv	= R & ~|(funct ^ 6'b000110);
	assign _xor	= R & ~|(funct ^ 6'b100110);
	assign srl	= R & ~|(funct ^ 6'b000010);
	assign sra	= R & ~|(funct ^ 6'b000011);

	assign bgez = bgez_or_bltz & ~|(rt ^ 5'b00001);
	assign bltz = bgez_or_bltz & ~|(rt ^ 5'b00000);



	assign regWrite   = |{ addu, subu, ori, lw, lui, sll, _and, _or, sllv, slt, addi, jal, lh, lb, slti, addiu, jalr, add, sub, _nor, sltu, srav, srlv, _xor, andi, srl, sltiu, sra, xori, lbu, lhu };
	
	assign regDst[1]  = |{ jal };
	assign regDst[0]  = |{ addu, subu, sll, _and, _or, sllv, slt, jalr, add, sub, _nor, sltu, srav, srlv, _xor, srl, sra };

	assign regSrc[1]  = |{ jal, jalr };
	assign regSrc[0]  = |{ lw, lh, lb, lbu, lhu };

	assign memWrite	  = |{ sw, sh, sb };

	assign ALUSrc 	  = |{ ori, lw, sw, lui, addi, sh, sb, lh, lb, slti, addiu, andi, sltiu, xori, lbu, lhu };
	
	assign ALUCtrl[4] = |{ bne, _nor, srav, srlv, sra };
	assign ALUCtrl[3] = |{ beq, slt, slti, bgez, bltz, bgtz, blez, sltu, sltiu };
	assign ALUCtrl[2] = |{ sll, sllv, bgez, bltz, blez, srlv, _xor, srl, sra, xori };
	assign ALUCtrl[1] = |{ addu, subu, lw, sw, beq, sll, sllv, addi, sh, sb, lh, lb, addiu, bgez, blez, add, sub, _nor, sltu, srav, sltiu, lbu, lhu };
	assign ALUCtrl[0] = |{ subu, ori, lui, _or, sllv, bltz, bgtz, blez, bne, sub, sltu, srav, srl, sltiu, sra };
	
	assign EXTCtrl[2] = |{ 1'b0 };
	assign EXTCtrl[1] = |{ beq, lui, bgez, bltz, bgtz, blez, bne };
	assign EXTCtrl[0] = |{ lw, sw, beq, addi, sh, sb, lh, lb, slti, addiu, bgez, bltz, bgtz, blez, bne, sltiu, lbu, lhu };

	assign NPCCtrl[2] = |{ 1'b0 };
	assign NPCCtrl[1] = |{ j, jr, jal, jalr };
	assign NPCCtrl[0] = |{ jr, jalr, ALUFlag & |{ beq, bgez, bltz, bgtz, blez, bne } };

	assign DMCtrl[2]  = |{ lbu };
	assign DMCtrl[1]  = |{ lb, sb, lhu };
	assign DMCtrl[0]  = |{ lh, sh, lhu };

endmodule
