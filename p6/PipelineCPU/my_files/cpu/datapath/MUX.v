`timescale 1ns / 1ps

module MUX2_1 #(parameter BITS = 32) (
        input sel,
        input [BITS-1:0] in0,
        input [BITS-1:0] in1,
        output [BITS-1:0] out
);
    
    assign out = sel == 1'b0 ? in0 : in1;

endmodule

module MUX4_1 #(parameter BITS = 32) (
        input [1:0] sel,
        input [BITS-1:0] in0,
        input [BITS-1:0] in1,
        input [BITS-1:0] in2,
        input [BITS-1:0] in3,
        output [BITS-1:0] out
);
    
    assign out = (sel == 2'b00) ? in0 :
                 (sel == 2'b01) ? in1 :
                 (sel == 2'b10) ? in2 :
                 in3;

endmodule

module MUX8_1 #(parameter BITS = 32) (
        input [2:0] sel,
        input [BITS-1:0] in0,
        input [BITS-1:0] in1,
        input [BITS-1:0] in2,
        input [BITS-1:0] in3,
        input [BITS-1:0] in4,
        input [BITS-1:0] in5,
        input [BITS-1:0] in6,
        input [BITS-1:0] in7,
        output [BITS-1:0] out
);
    
    assign out = (sel == 3'b000) ? in0 :
                 (sel == 3'b001) ? in1 :
                 (sel == 3'b010) ? in2 :
                 (sel == 3'b011) ? in3 :
                 (sel == 3'b101) ? in4 :
                 (sel == 3'b101) ? in5 :
                 (sel == 3'b110) ? in6 :
                 in7;

endmodule