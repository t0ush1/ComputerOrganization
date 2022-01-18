`timescale 1ns / 1ps

module DT (
    input clk,
    input reset,
    input [3:0] byteEn,
    input Addr,
    input [31:0] WD_orig,
    output [31:0] RD,
    output [7:0] code0,
    output [7:0] code1,
    output [7:0] code2,
    output reg [3:0] sel0,
    output reg [3:0] sel1,
    output reg sel2
);

    localparam [127:0] CODE = {
        8'b10000001, 8'b11001111, 8'b10010010, 8'b10000110,
        8'b11001100, 8'b10100100, 8'b10100000, 8'b10001111,
        8'b10000000, 8'b10000100, 8'b10001000, 8'b11100000,
        8'b10110001, 8'b11000010, 8'b10110000, 8'b10111000
    };

    localparam CYCLE = 100;

    reg [31:0] mem [1:0];
    reg [31:0] WD;
    reg [31:0] cnt;
    
    wire [3:0] curData0;
    wire [3:0] curData1;

    assign curData0 = sel0 == 4'b0001 ? mem[0][3:0] :
                    sel0 == 4'b0010 ? mem[0][7:4] :
                    sel0 == 4'b0100 ? mem[0][11:8] :
                    sel0 == 4'b1000 ? mem[0][15:12] :
                    4'b0;
    assign curData1 = sel1 == 4'b0001 ? mem[0][19:16] :
                    sel1 == 4'b0010 ? mem[0][23:20] :
                    sel1 == 4'b0100 ? mem[0][27:24] :
                    sel1 == 4'b1000 ? mem[0][31:28] :
                    4'b0;

    assign code0 = CODE[127 - (curData0 << 3) -: 8];
    assign code1 = CODE[127 - (curData1 << 3) -: 8];
    assign code2 = CODE[127 - (mem[1][3:0] << 3) -: 8];

    assign RD = mem[Addr];

    always @(*) begin
		WD = RD;
		if (byteEn[3]) WD[31:24] = WD_orig[31:24];
		if (byteEn[2]) WD[23:16] = WD_orig[23:16];
		if (byteEn[1]) WD[15:8] = WD_orig[15:8];
		if (byteEn[0]) WD[7:0] = WD_orig[7:0];
	end

    always @(posedge clk) begin
        if (reset) begin
            sel0 <= 4'b1;
            sel1 <= 4'b1;
            sel2 <= 1'b1;
            cnt <= CYCLE;
            mem[0] <= 32'b0;
            mem[1] <= 32'b0;
        end
        else if (|byteEn) begin
            mem[Addr] <= Addr ? { 28'b0, WD[3:0] } : WD;
        end else begin
            if (cnt == 0) begin
                sel0 <= { sel0[2:0], sel0[3] };
                sel1 <= { sel1[2:0], sel1[3] };
                cnt <= CYCLE;
            end else begin
                cnt <= cnt - 1;
            end
        end
    end

endmodule