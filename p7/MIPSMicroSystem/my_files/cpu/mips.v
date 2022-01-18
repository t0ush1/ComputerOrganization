`timescale 1ns / 1ps

module mips (
    input clk,
    input reset,
    input interrupt,
    output [31:0] macroscopic_pc,

    output [31:0] i_inst_addr,
    input  [31:0] i_inst_rdata,

    output [31:0] m_data_addr,
    input  [31:0] m_data_rdata,
    output [31:0] m_data_wdata,
    output [3 :0] m_data_byteen,

    output [31:0] m_inst_addr,

    output w_grf_we,
    output [4 :0] w_grf_addr,
    output [31:0] w_grf_wdata,

    output [31:0] w_inst_addr
);

    wire [31:0] memAddr;
    wire [3:0] DMByteEn;
    wire [31:0] memRD;
    wire [3:0] byteEn;
    wire TC1IntReq;
    wire TC2IntReq;
    wire [31:0] TC1RD;
    wire [31:0] TC2RD;
    wire TC1Write;
    wire TC2Write;
    wire respTbInt;

    assign macroscopic_pc = m_inst_addr;
    assign m_data_addr = respTbInt ? 32'h7f20 : memAddr;
    assign m_data_byteen = respTbInt ? 4'b1111 : DMByteEn;

    CPU centralProgressingUnit (
        .clk(clk),
        .reset(reset),
        .HWInt({ 3'b0, interrupt, TC2IntReq, TC1IntReq }),
        .instr_F(i_inst_rdata),
        .memRD(memRD),
        .PC_F(i_inst_addr),
        .memAddr(memAddr),
        .memWD(m_data_wdata),
        .byteEn(byteEn),
        .PC_M(m_inst_addr),
        .regWrite(w_grf_we),
        .regAddr(w_grf_addr),
        .regWD(w_grf_wdata),
        .PC_W(w_inst_addr),
        .respTbInt(respTbInt)
    );

    Bridge bridge(
        .addr(m_data_addr),
        .byteEn(byteEn),
        .DMRD(m_data_rdata),
        .TC1RD(TC1RD),
        .TC2RD(TC2RD),
        .DMByteEn(DMByteEn),
        .TC1Write(TC1Write),
        .TC2Write(TC2Write),
        .RD(memRD)
    );

    TC timerCounter1(
        .clk(clk),
        .reset(reset),
        .Addr(m_data_addr[31:2]),
        .WE(TC1Write),
        .Din(m_data_wdata),
        .Dout(TC1RD),
        .IRQ(TC1IntReq)
    );

    TC timerCounter2(
        .clk(clk),
        .reset(reset),
        .Addr(m_data_addr[31:2]),
        .WE(TC2Write),
        .Din(m_data_wdata),
        .Dout(TC2RD),
        .IRQ(TC2IntReq)
    );

endmodule