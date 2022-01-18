module SimpleLED (
    input clk_in,
    input sys_rstn,
    output [31:0] led_light
);

    // Counter
    localparam PERIOD = 32'd25_000_000; // clk is 25MHz

    reg [31:0] counter;

    always @(posedge clk_in) begin
        if (~sys_rstn) 
            counter <= 0;
        else begin
            if (counter + 1 == PERIOD)
                counter <= 0;
            else
                counter <= counter + 1;
        end
    end

    // LED
    reg [31:0] led;

    always @(posedge clk_in) begin
        if (~sys_rstn)
            led <= 32'b1; // åˆå§‹æœ€å³ä¾§ LED äº®
        else begin
            if (counter + 1 == PERIOD)  // è®¡æ—¶å™¨è®¡æ»¡ä¸€ä¸ªå‘¨æœŸ
                led <= {led[30:0], led[31]}; // å¾ªçŽ¯å·¦ç§» 1 ä½
        end
    end

    assign led_light = ~led; // åè½¬ç”µå¹³ï¼Œè¿žæŽ¥åˆ°çœŸæ­£çš„ LED å¼•è„šè¾“å‡º

endmodule
