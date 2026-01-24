module clb (
    `ifdef USE_POWER_PINS
    inout VPWR,
    inout VGND,
    `endif

    input  wire clk_i,
    input  wire rst_ni,
    input  wire [16:0] ui_PAD2CORE,
    output wire [16:0] uo_CORE2PAD
);

    wire A          = ui_PAD2CORE[0];
    wire B          = ui_PAD2CORE[1];
    wire [1:0] mode = ui_PAD2CORE[3:2];

    reg [3:0] lut_config;
    always @(*) begin
        case (mode)
            2'b00: lut_config = 4'b1000;
            2'b01: lut_config = 4'b1110;
            2'b10: lut_config = 4'b0110;
            default: lut_config = 4'b0000;
        endcase end
     reg Y_reg;
    always @(*) begin
        case ({A, B})
            2'b00: Y_reg = lut_config[0];
            2'b01: Y_reg = lut_config[1];
            2'b10: Y_reg = lut_config[2];
            2'b11: Y_reg = lut_config[3];
            default: Y_reg = 1'b0;
        endcase
    end

    assign uo_CORE2PAD[0]    = Y_reg;
    assign uo_CORE2PAD[16:1] = 16'b0;

endmodule
