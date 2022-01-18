`timescale 1ns / 1ps

`define dips0_3 mem[0]
`define dips4_7 mem[1]
`define key     mem[2]
`define LED     mem[4]

module IO (
    input clk,
    input reset,
    input [3:0] byteEn,
    input [4:2] Addr,
    input [31:0] WD_orig,
    input [31:0] dips0_3,
    input [31:0] dips4_7,
    input [7:0] key,
    output [31:0] RD,
    output [31:0] LED
);

    reg [31:0] mem [4:0];
    reg [31:0] WD;

    assign RD = mem[Addr];
    assign LED = ~`LED;

    always @(*) begin
		WD = RD;
		if (byteEn[3]) WD[31:24] = WD_orig[31:24];
		if (byteEn[2]) WD[23:16] = WD_orig[23:16];
		if (byteEn[1]) WD[15:8] = WD_orig[15:8];
		if (byteEn[0]) WD[7:0] = WD_orig[7:0];
	end

    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 5; i = i + 1)
                mem[i] <= 32'b0;
        end
        else begin
            if (|byteEn && Addr == 3'd4)
                `LED <= WD;
            `dips0_3 <= ~dips0_3;
            `dips4_7 <= ~dips4_7;
            `key <= { 24'b0, ~key };
        end
    end

endmodule