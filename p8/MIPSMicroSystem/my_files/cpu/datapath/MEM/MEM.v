`timescale 1ns / 1ps

module MEM (
    input [31:0] regRD2_orig,
    input [31:0] WBBack,
    input [31:0] memRD_orig,
    input [1:0] byteSel,

    input [2:0] BECtrl,
    input [2:0] DECtrl,
    input regRD2Forward,

    output [3:0] byteEn,
    output [31:0] memWD,
    output [31:0] memRD,
    output [31:0] regRD2
);

    MUX2_1 #(.BITS(32)) regRD2MUX (
        .sel(regRD2Forward),
        .in0(regRD2_orig),
        .in1(WBBack),
        .out(regRD2)
    );

    BE byteEnable (
        .WD_orig(regRD2),
        .byteSel(byteSel),
        .ctrl(BECtrl),
        .byteEn(byteEn),
        .WD(memWD)
    );

    DE dataExtender (
        .RD_orig(memRD_orig),
        .byteSel(byteSel),
        .ctrl(DECtrl),
        .RD(memRD)
    );

endmodule