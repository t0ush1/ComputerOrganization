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
    reg [31:0] srcA_stall;
    reg [31:0] srcB_stall;
    reg [3:0] ctrl_stall;
    reg [1:0] state;
    reg [31:0] cnt;

    always @(posedge clk) begin
        if (reset) begin
            HI <= 32'b0;
            LO <= 32'b0;
            srcA_stall <= 32'b0;
            srcB_stall <= 32'b0;
            ctrl_stall <= 4'b0;
            state <= `MDUState_begin;
            cnt <= 32'b0;
        end else begin
            if (ctrl == `MDU_mthi) HI <= srcA;
            else if (ctrl == `MDU_mtlo) LO <= srcA;
            else;

            case (state)
                `MDUState_begin: begin
                    cnt <= 1;
                    if (start) begin
                        srcA_stall <= srcA;
                        srcB_stall <= srcB;
                        ctrl_stall <= ctrl;
                        if (ctrl == `MDU_mult || ctrl == `MDU_multu)
                            state <= `MDUState_mulDelay;
                        else if (ctrl == `MDU_div || ctrl == `MDU_divu)
                            state <= `MDUState_divDelay;
                        else;
                    end
                    else;
                end
                `MDUState_mulDelay: begin
                    if (cnt == 32'd5) begin
                        state <= `MDUState_begin;
                        if (ctrl_stall == `MDU_mult)
                            { HI, LO } <= $signed({ {32{srcA_stall[31]}}, srcA_stall }) * $signed({ {32{srcB_stall[31]}}, srcB_stall });
                        else if (ctrl_stall == `MDU_multu)
                            { HI, LO } <= { 32'b0, srcA_stall } * { 32'b0, srcB_stall };
                        else;
                    end
                    else
                        cnt <= cnt + 1;
                end
                `MDUState_divDelay: begin
                    if (cnt == 32'd10) begin
                        state <= `MDUState_begin;
                        if (ctrl_stall == `MDU_div)
                            { HI, LO } = { $signed(srcA_stall) % $signed(srcB_stall), $signed(srcA_stall) / $signed(srcB_stall) };
                        else if (ctrl_stall == `MDU_divu)
                            { HI, LO } = { srcA_stall % srcB_stall, srcA_stall / srcB_stall };
                        else;
                    end
                    else
                        cnt <= cnt + 1;
                end
                default:;
            endcase
        end
    end

    assign busy = state == `MDUState_mulDelay || state == `MDUState_divDelay;

endmodule