`timescale 1ns / 1ps

module fpga(
    `ifdef USE_POWER_PINS
    inout VPWR,
    inout VGND,
    `endif
    input  wire clk_i,
    input  wire rst_ni,
    input  wire [16:0] ui_PAD2CORE,
    output wire [16:0] uo_CORE2PAD
);

    parameter CLK_FREQ  = 11_059_200;
    parameter BAUD_RATE = 9600;

    wire uart_rx = ui_PAD2CORE[0];
    wire [1:0] user_inputs = ui_PAD2CORE[2:1];

    wire [51:0] config_bits;
    wire        config_done;
    wire        config_error;
    wire        fabric_out;

    uart_config #(
        .CLK_FREQ  (CLK_FREQ),
        .BAUD_RATE (BAUD_RATE)
    ) uart_inst (
        .clk          (clk_i),
        .rst_n        (rst_ni),
        .uart_rx      (uart_rx),
        .config_bits  (config_bits),
        .config_done  (config_done),
        .config_error (config_error)
    );

    fabric_2x2 fabric_inst (
        .clk          (clk_i),
        .rst_n        (rst_ni),
        .config_bits  (config_bits),
        .user_inputs  (user_inputs),
        .user_output  (fabric_out)
    );

    assign uo_CORE2PAD[0] = config_done & fabric_out;
    assign uo_CORE2PAD[16:1] = 16'b0;

endmodule
