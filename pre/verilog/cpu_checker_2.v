`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:52 09/18/2021 
// Design Name: 
// Module Name:    cpu_checker 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`define S0 	4'b0000	//before ^
`define S1	4'b0001 //^ time
`define S2 	4'b0010	//@ pc
`define S3 	4'b0011 //: spc
`define S4 	4'b0100 //& grf
`define S5 	4'b0101 //star addr
`define S6 	4'b0110 //spc
`define S7 	4'b0111 //<
`define S8 	4'b1000 //= spc
`define S9 	4'b1001 //data
`define S10 4'b1010 //#

module cpu_checker(
    input clk,
    input reset,
    input [7:0] char,
    input [15:0] freq,
    output [1:0] format_type,
    output [3:0] error_code
    );

    reg [3:0] state;
	reg [31:0] cnt;
	reg is_reg;
	reg [11:0] _time;
    reg [31:0] pc;
    reg [31:0] addr;
    reg [11:0] grf;
    reg time_error;
    reg pc_error;
    reg addr_error;
    reg grf_error;

	initial begin
		state <= `S0;
		cnt <= 0;
		is_reg <= 0;
        _time <= 0;
        pc <= 0;
        addr <= 0;
        grf <= 0;
        time_error <= 0;
        pc_error <= 0;
        addr_error <= 0;
        grf_error <= 0;
	end
	
	always @(posedge clk) begin
		if (reset) begin
			state <= `S0;
			cnt <= 0;
		end
		else
			case (state)
				`S0: begin
						if (char == "^")
							state <= `S1;
						else
							state <= `S0;
					end
				`S1: begin
						if (char >= "0" && char <= "9") begin
							state <= `S1;
							cnt <= cnt + 1;
                            _time <= (_time << 3) + (_time << 1) + char - "0";
						end
						else begin
							if (char == "@" && cnt >= 1 && cnt <= 4) begin
								state <= `S2;
                                time_error <= (_time & ((freq >> 1) - 1)) != 0; //equals mod only when (freq >> 1) = 2 ^ n
                            end
							else
								state <= `S0;
							cnt <= 0;
                            _time <= 0;
						end
					end
				`S2: begin
						if ((char >= "0" && char <= "9") || (char >= "a" && char <= "f")) begin
							state <= `S2;
							cnt <= cnt + 1;
                            pc <= (pc << 4) + ((char >= "0" && char <= "9") ? char - "0" : char - "a" + 10);
						end
						else begin
							if (char == ":" && cnt == 8) begin
								state <= `S3;
                                pc_error <= pc < 32'h3000 || pc > 32'h4fff || (pc & 2'b11) != 0;
                            end
							else
								state <= `S0;
							cnt <= 0;
                            pc <= 0;
						end
					end
				`S3: begin
						if (char == " ")
							state <= `S3;
						else if (char == "$")
							state <= `S4;
						else if (char == 8'd42)
						    state <= `S5;
						else
							state <= `S0;
					end
				`S4: begin
						is_reg <= 1;
						if (char >= "0" && char <= "9") begin
							state <= `S4;
							cnt <= cnt + 1;
                            grf <= (grf << 3) + (grf << 1) + char - "0";
						end
						else begin
							if (char == " " && cnt >= 1 && cnt <= 4)
                                state <= `S6;
							else if (char == "<" && cnt >= 1 && cnt <= 4)
								state <= `S7;
							else
								state <= `S0;
							cnt <= 0;
							grf_error <= grf > 31;
							addr_error <= 0;
                            grf <= 0;
						end
					end
				`S5: begin
						is_reg <= 0;
						if ((char >= "0" && char <= "9") || (char >= "a" && char <= "f")) begin
							state <= `S5;
							cnt <= cnt + 1;
                            addr <= (addr << 4) + ((char >= "0" && char <= "9") ? char - "0" : char - "a" + 10);
						end
						else begin
							if (char == " " && cnt == 8)
                                state <= `S6;
							else if (char == "<" && cnt == 8)
								state <= `S7;
							else
								state <= `S0;
							cnt <= 0;
							addr_error <= addr > 32'h2fff || (addr & 2'b11) != 0;
							grf_error <= 0;
                            addr <= 0;
						end
					end
				`S6: begin
						if (char == " ")
							state <= `S6;
						else if (char == "<")
							state <= `S7;
						else
							state <= `S0;
					end
				`S7: begin
						if (char == "=")
							state <= `S8;
						else
							state <= `S0;
					end
				`S8: begin
						if (char == " ")
							state <= `S8;
						else if ((char >= "0" && char <= "9") || (char >= "a" && char <= "f")) begin
							state <= `S9;
							cnt <= 1;
						end
						else
							state <= `S0;
					end
				`S9: begin
						if ((char >= "0" && char <= "9") || (char >= "a" && char <= "f")) begin
							state <= `S9;
							cnt <= cnt + 1;
						end
						else begin
							if (char == "#" && cnt == 8)
								state <= `S10;
							else
								state <= `S0;
							cnt <= 0;
						end
					end
				`S10: begin
						if (char == "^")
							state <= `S1;
						else
							state <= `S0;
					end
			endcase
	end
	
	assign format_type = (state != `S10) ? 2'b00 :
                        is_reg ? 2'b01 : 2'b10;
    assign error_code = (state != `S10) ? 4'b0000 :
						{ grf_error, addr_error, pc_error, time_error };

endmodule
