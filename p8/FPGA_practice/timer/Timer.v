`define BEGIN 2'b00
`define UP 2'b01
`define DOWN 2'b10

module Timer (
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

    reg [1:0] state;
    reg [31:0] cnt;
    reg [31:0] cycle;
    reg [31:0] cycleCnt;
    reg ligntOn;

    assign led_light = ligntOn ? 32'h0 : 32'hFFFF_FFFF;

    always @(posedge clk_in) begin
        if (~sys_rstn) begin
            state <= `BEGIN;
            cnt <= 0;
            cycle <= 0;
            cycleCnt <= 0;
            ligntOn <= 0;
        end
        else begin
            if (cycleCnt < cycle)
                cycleCnt <= cycleCnt + 1;
            else begin
                cycleCnt <= 0;
                case (state)
                    `BEGIN: begin
                        cycle <= user_key[2:1] == 2'b11 ? 32'd6250000 :
                                user_key[2:1] == 2'b10 ? 32'd12500000 :
                                user_key[2:1] == 2'b01 ? 32'd25000000 :
                                32'd50000000;
                        ligntOn <= 0;
                        if (user_key[0]) begin
                            state <= `UP;
                            cnt <= 0;
                        end else if (dip_switch7 & dip_switch6 & dip_switch5 & dip_switch4 != 8'hFF) begin
                            state <= `DOWN;
                            cnt <= ~{ dip_switch7, dip_switch6, dip_switch5, dip_switch4 };
                        end
                    end
                    `UP: begin
                        if (cnt >= ~{ dip_switch3, dip_switch2, dip_switch1, dip_switch0 })
                            state <= `BEGIN;
                        else
                            cnt <= cnt + 1;
                    end
                    `DOWN: begin
                        if (cnt == 0) begin
                            state <= `BEGIN;
                            ligntOn <= 1'b1;
                        end else
                            cnt <= cnt - 1;
                    end
                endcase
            end
        end
    end

    DigitalTube digitalTube0 (
        .clk(clk_in),
        .reset(sys_rstn),
        .WD(cnt[15:0]),
        .sel(digital_tube_sel0),
        .code(digital_tube0)
    );

    DigitalTube digitalTube1 (
        .clk(clk_in),
        .reset(sys_rstn),
        .WD(cnt[31:16]),
        .sel(digital_tube_sel1),
        .code(digital_tube1)
    );

    assign uart_txd = 1'b1;
    assign digital_tube_sel2 = 1'b1;
    assign digital_tube2 = 8'hFF;

endmodule