`timescale 1ns / 1ps

module tb_clb;

    reg         clk_i;
    reg         rst_ni;
    reg  [16:0] ui_PAD2CORE;
    wire [16:0] uo_CORE2PAD;

    integer errors = 0;

    clb dut (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .ui_PAD2CORE(ui_PAD2CORE),
        .uo_CORE2PAD(uo_CORE2PAD)
    );

    always #5 clk_i = ~clk_i;

    task run_test;
        input [1:0] mode;
        input [1:0] ab;
        input exp;
        begin
            ui_PAD2CORE[3:2] = mode;
            ui_PAD2CORE[1:0] = ab;
            #1;
            if (uo_CORE2PAD[0] !== exp) begin
                $display("ERROR | mode=%b ab=%b exp=%b got=%b",
                          mode, ab, exp, uo_CORE2PAD[0]);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        clk_i = 0;
        rst_ni = 0;
        ui_PAD2CORE = 0;

        $dumpfile("tb_clb.vcd");
        $dumpvars(0, tb_clb);

        #20 rst_ni = 1;

        run_test(2'b00, 2'b00, 0);
        run_test(2'b00, 2'b01, 0);
        run_test(2'b00, 2'b10, 0);
        run_test(2'b00, 2'b11, 1);

        run_test(2'b01, 2'b00, 0);
        run_test(2'b01, 2'b01, 1);
        run_test(2'b01, 2'b10, 1);
        run_test(2'b01, 2'b11, 1);

        run_test(2'b10, 2'b00, 0);
        run_test(2'b10, 2'b01, 1);
        run_test(2'b10, 2'b10, 1);
        run_test(2'b10, 2'b11, 0);

        run_test(2'b11, 2'b00, 0);
        run_test(2'b11, 2'b01, 0);
        run_test(2'b11, 2'b10, 0);
        run_test(2'b11, 2'b11, 0);

       $finish;
    end

endmodule

