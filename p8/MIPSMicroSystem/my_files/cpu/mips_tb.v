`timescale 1ns / 1ps

module mips_tb;

	// Inputs
	reg clk_in;
	reg sys_rstn;
	reg [7:0] dip_switch0;
	reg [7:0] dip_switch1;
	reg [7:0] dip_switch2;
	reg [7:0] dip_switch3;
	reg [7:0] dip_switch4;
	reg [7:0] dip_switch5;
	reg [7:0] dip_switch6;
	reg [7:0] dip_switch7;
	reg [7:0] user_key;
	reg uart_rxd;

	// Outputs
	wire [31:0] led_light;
	wire [7:0] digital_tube2;
	wire digital_tube_sel2;
	wire [7:0] digital_tube1;
	wire [3:0] digital_tube_sel1;
	wire [7:0] digital_tube0;
	wire [3:0] digital_tube_sel0;
	wire uart_txd;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk_in(clk_in), 
		.sys_rstn(sys_rstn), 
		.dip_switch0(dip_switch0), 
		.dip_switch1(dip_switch1), 
		.dip_switch2(dip_switch2), 
		.dip_switch3(dip_switch3), 
		.dip_switch4(dip_switch4), 
		.dip_switch5(dip_switch5), 
		.dip_switch6(dip_switch6), 
		.dip_switch7(dip_switch7), 
		.user_key(user_key), 
		.led_light(led_light), 
		.digital_tube2(digital_tube2), 
		.digital_tube_sel2(digital_tube_sel2), 
		.digital_tube1(digital_tube1), 
		.digital_tube_sel1(digital_tube_sel1), 
		.digital_tube0(digital_tube0), 
		.digital_tube_sel0(digital_tube_sel0), 
		.uart_rxd(uart_rxd), 
		.uart_txd(uart_txd)
	);

	initial begin
		// Initialize Inputs
		clk_in = 0;
		sys_rstn = 0;
		dip_switch0 = 8'b11111111;
		dip_switch1 = 8'hff;
		dip_switch2 = 8'hff;
		dip_switch3 = 8'hff;
		dip_switch4 = 8'b11111111;
		dip_switch5 = 8'hff;
		dip_switch6 = 8'hff;
		dip_switch7 = 8'hff;
		user_key = 8'b11111111;
		uart_rxd = 1'b1;

		// Wait 100 ns for global reset to finish
		#100;
        sys_rstn = 1;
		// Add stimulus here
		uart_rxd = 1'b0;
		#7800
		uart_rxd = 1'b1;
		#7800
		uart_rxd = 1'b1;
		#7800
		uart_rxd = 1'b0;
		#7800
		uart_rxd = 1'b1;
		#7800
		uart_rxd = 1'b1;
		#7800
		uart_rxd = 1'b0;
		#7800
		uart_rxd = 1'b1;
		#7800
		uart_rxd = 1'b1;
		#7800
		uart_rxd = 1'b1;
	end
      always #12 clk_in = ~clk_in;
endmodule

