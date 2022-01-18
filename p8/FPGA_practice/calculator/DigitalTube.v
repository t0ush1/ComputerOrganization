module DigitalTube (
    input clk,
    input reset,
    input [15:0] WD,
    output reg [3:0] sel,
    output [7:0] code
);

    localparam [127:0] CODE = {
        8'b10000001, 8'b11001111, 8'b10010010, 8'b10000110,
        8'b11001100, 8'b10100100, 8'b10100000, 8'b10001111,
        8'b10000000, 8'b10000100, 8'b10001000, 8'b11100000,
        8'b10110001, 8'b11000010, 8'b10110000, 8'b10111000
    };

    reg [15:0] data;
    reg [31:0] cnt;
    wire [3:0] curData;

    assign curData = sel == 4'b0001 ? data[3:0] :
                    sel == 4'b0010 ? data[7:4] :
                    sel == 4'b0100 ? data[11:8] :
                    sel == 4'b1000 ? data[15:12] :
                    4'b0;
    assign code = CODE[127 - (curData << 3) -: 8];

    always @(posedge clk) begin
        if (~reset) begin
            sel <= 4'b1;
            data <= 16'b0;
            cnt <= 32'd10;
        end
        else begin
            if (cnt == 0) begin
                sel <= { sel[2:0], sel[3] };
                cnt <= 32'd10;
            end else begin
                cnt <= cnt - 1;
            end
            data <= WD;
        end
    end

endmodule