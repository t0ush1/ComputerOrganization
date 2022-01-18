`timescale 1ns / 1ps

module mips (
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

    wire clk;
    wire clk_IMDM;
    wire reset;

    wire [31:0] PC;
    wire [31:0] instr;
    
    wire [31:0] memAddr;
    wire [31:0] memWD;
    wire [31:0] memRD;
    wire [3:0] byteEn;
    
    wire [3:0] DMByteEn;
    wire [31:0] DMRD;

    wire TCWrite;
    wire [31:0] TCRD;
    wire TCIntReq;

    wire [3:0] DTByteEn;
    wire [31:0] DTRD;

    wire UARTWrite;
    wire [31:0] UARTRD;
    wire UARTIntReq;
    wire respUARTInt;

    wire [3:0] IOByteEn;
    wire [31:0] IORD;

    assign reset = ~sys_rstn;

    Clock clock (
        .clk_fpga(clk_in),
        .clk_cpu(clk),
		.clk_IMDM(clk_IMDM)
    );

    CPU centralProgressingUnit (
        .clk(clk),
        .reset(reset),
        .HWInt({ 3'b0, UARTIntReq, 1'b0, TCIntReq }),
        .instr_F(instr),
        .memRD(memRD),
        .PC_F(PC),
        .memAddr(memAddr),
        .memWD(memWD),
        .byteEn(byteEn),
        .PC_M(),
        .regAddr(),
        .regWD(),
        .PC_W(),
        .respUARTInt(respUARTInt)
    );

    IM instructionMemoty (
        .clka(clk_IMDM),
        .addra(PC[13:2] - 12'hc00),
        .douta(instr)
    );

    Bridge bridge(
        .addr(memAddr),
        .byteEn(byteEn),
        .DMRD(DMRD),
        .TCRD(TCRD),
        .DTRD(DTRD),
        .UARTRD(UARTRD),
        .IORD(IORD),
        .DMByteEn(DMByteEn),
        .TCWrite(TCWrite),
        .DTByteEn(DTByteEn),
        .UARTWrite(UARTWrite),
        .IOByteEn(IOByteEn),
        .RD(memRD)
    );

    DM dataMemory (
        .clka(clk_IMDM),
        .wea(DMByteEn),
        .addra(memAddr[13:2]),
        .dina(memWD),
        .douta(DMRD)
    );

    TC timerCounter(
        .clk(clk),
        .reset(reset),
        .Addr(memAddr[3:2]),
        .WE(TCWrite),
        .Din(memWD),
        .Dout(TCRD),
        .IRQ(TCIntReq)
    );

    DT digitalTube (
        .clk(clk),
        .reset(reset),
        .byteEn(DTByteEn),
        .Addr(memAddr[2]),
        .WD_orig(memWD),
        .RD(DTRD),
        .code0(digital_tube0),
        .code1(digital_tube1),
        .code2(digital_tube2),
        .sel0(digital_tube_sel0),
        .sel1(digital_tube_sel1),
        .sel2(digital_tube_sel2)
    );

    MiniUART uart (
        .CLK_I(clk),
        .DAT_I(memWD),
        .DAT_O(UARTRD),
        .RST_I(reset),
        .ADD_I(memAddr[4:2]),
        .STB_I(1'b1),
        .WE_I(UARTWrite),
        .ACK_O(),
        .RxD(uart_rxd),
        .TxD(uart_txd),
        .interrupt(UARTIntReq),
        .respInt(respUARTInt)
    );

    IO inputOutput (
        .clk(clk),
        .reset(reset),
        .byteEn(IOByteEn),
        .Addr(memAddr[4:2] - 3'b100),
        .WD_orig(memWD),
        .dips0_3({ dip_switch3, dip_switch2, dip_switch1, dip_switch0 }),
        .dips4_7({ dip_switch7, dip_switch6, dip_switch5, dip_switch4 }),
        .key(user_key),
        .RD(IORD),
        .LED(led_light)
    );

endmodule