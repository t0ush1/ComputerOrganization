`define MINUS 8'b11111110
`define NONE 8'b11111111

module Calculator (
    input clk_in,
    input sys_rstn,
    input [7:0] dip_switch0,
    input [7:0] dip_switch1,
    input [7:0] dip_switch2,
    input [7:0] dip_switch3,
    input [7:0] dip_switch4,
    input [7:0] dip_switch5,
    input [7:0] dip_switch6,
    input [7:0] dip_switch7,
    input [7:0] user_key,
    output [31:0] led_light,
    output [7:0] digital_tube2,
    output digital_tube_sel2,
    output [7:0] digital_tube1,
    output [3:0] digital_tube_sel1,
    output [7:0] digital_tube0,
    output [3:0] digital_tube_sel0,
    input uart_rxd,
    output uart_txd
);

    wire blank;
    wire [7:0] digital_tube0_orig;
    wire [7:0] digital_tube1_orig;
    wire [3:0] digital_tube_sel0_orig;
    wire [3:0] digital_tube_sel1_orig;
    wire [31:0] srcA;
    wire [31:0] srcB;
    wire [31:0] result;
    wire [31:0] abs;

    assign blank = ~sys_rstn | (user_key[0]+user_key[1]+user_key[2]+user_key[3]+user_key[4]+user_key[5]+user_key[6]+user_key[7] != 7);

    assign digital_tube_sel2 = 1'b1;
    assign digital_tube2 = blank | result[31] ? `MINUS : `NONE;

    assign digital_tube0 = blank ? `MINUS : digital_tube0_orig;
    assign digital_tube1 = blank ? `MINUS : digital_tube1_orig;
    assign digital_tube_sel0 = blank ? 4'hF : digital_tube_sel0_orig;
    assign digital_tube_sel1 = blank ? 4'hF : digital_tube_sel1_orig;

    assign led_light = blank ? 32'hFFFF_FFFF : ~result;

    assign srcA = ~{ dip_switch3, dip_switch2, dip_switch1, dip_switch0 };
    assign srcB = ~{ dip_switch7, dip_switch6, dip_switch5, dip_switch4 };
    assign result = ~user_key[0] ? srcA & srcB :
                    ~user_key[1] ? srcA | srcB :
                    ~user_key[2] ? srcA ^ srcB :
                    ~user_key[3] ? srcA + srcB :
                    ~user_key[4] ? srcA - srcB :
                    ~user_key[5] ? srcA >> srcB[4:0] :
                    ~user_key[6] ? $signed($signed(srcA) >>> srcB[4:0]) :
                    ~user_key[7] ? { srcA, srcA } >> srcB[4:0] :
                    32'b0;
    assign abs = result[31] ? -result : result;

    DigitalTube digitalTube0 (
        .clk(clk_in),
        .reset(sys_rstn),
        .WD(abs[15:0]),
        .sel(digital_tube_sel0_orig),
        .code(digital_tube0_orig)
    );

    DigitalTube digitalTube1 (
        .clk(clk_in),
        .reset(sys_rstn),
        .WD(abs[31:16]),
        .sel(digital_tube_sel1_orig),
        .code(digital_tube1_orig)
    );

    assign uart_txd = 1'b1;

endmodule