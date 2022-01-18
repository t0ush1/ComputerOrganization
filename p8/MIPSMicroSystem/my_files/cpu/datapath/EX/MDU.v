`timescale 1ns / 1ps

`include "../../macros.v"

module MDU (
    input clk,
    input reset,
    input [31:0] srcA,
    input [31:0] srcB,
    input start,
    input [3:0] ctrl,
    output busy,
    output reg [31:0] HI,
    output reg [31:0] LO
);

	wire [63:0] multResult;
	wire [63:0] multuResult;
	wire [63:0] divResult;
	wire [63:0] divuResult;

    reg [31:0] srcA_keep;
    reg [31:0] srcB_keep;
    reg [3:0] ctrl_keep;
    reg [1:0] state;
    reg [31:0] cnt;

	assign busy = state == `MDUState_mulDelay || state == `MDUState_divDelay;

    always @(posedge clk) begin
        if (reset) begin
            HI <= 32'b0;
            LO <= 32'b0;
            srcA_keep <= 32'b0;
            srcB_keep <= 32'b0;
            ctrl_keep <= 4'b0;
            state <= `MDUState_begin;
            cnt <= 32'b0;
        end else begin
            if (ctrl == `MDU_mthi) HI <= srcA;
            else if (ctrl == `MDU_mtlo) LO <= srcA;
			
			case (state)
				`MDUState_begin: begin
					cnt <= 1;
					if (start) begin
						srcA_keep <= srcA;
						srcB_keep <= srcB;
						ctrl_keep <= ctrl;
						if (ctrl == `MDU_mult || ctrl == `MDU_multu)
							state <= `MDUState_mulDelay;
						else if (ctrl == `MDU_div || ctrl == `MDU_divu)
							state <= `MDUState_divDelay;
					end
				end
				`MDUState_mulDelay: begin
					if (cnt == 32'd5) begin
						state <= `MDUState_begin;
						if (ctrl_keep == `MDU_mult)
							{ HI, LO } <= multResult;
						else if (ctrl_keep == `MDU_multu)
							{ HI, LO } <= multuResult;
					end
					else
						cnt <= cnt + 1;
				end
				`MDUState_divDelay: begin
					if (cnt == 32'd50) begin
						state <= `MDUState_begin;
						if (ctrl_keep == `MDU_div)
							{ HI, LO } <= divResult;
							// { HI, LO } <= { $signed(srcA_keep) % $signed(srcB_keep), $signed(srcA_keep) / $signed(srcB_keep) };
						else if (ctrl_keep == `MDU_divu)
							{ HI, LO } <= divuResult;
							// { HI, LO } <= { srcA_keep % srcB_keep, srcA_keep / srcB_keep };
					end
					else
						cnt <= cnt + 1;
				end
			endcase
        end
    end

	Mult mult (
		.clk(clk),
		.a(busy ? srcA_keep : srcA),
		.b(busy ? srcB_keep : srcB),
		.p(multResult)
	);

	Multu multu (
		.clk(clk),
		.a(busy ? srcA_keep : srcA),
		.b(busy ? srcB_keep : srcB),
		.p(multuResult)
	);

	Div div (
		.clk(clk),
		.rfd(),
		.dividend(busy ? srcA_keep : srcA),
		.divisor(busy ? srcB_keep : srcB),
		.quotient(divResult[31:0]),
		.fractional(divResult[63:32])
	);

	Divu divu (
		.clk(clk),
		.rfd(),
		.dividend(busy ? srcA_keep : srcA),
		.divisor(busy ? srcB_keep : srcB),
		.quotient(divuResult[31:0]),
		.fractional(divuResult[63:32])
	);

endmodule