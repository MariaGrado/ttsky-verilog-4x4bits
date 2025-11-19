`timescale 1ns/1ps
`default_nettype none

module tb;
    reg clk;
    reg rst_n;
    reg ena;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Instancia del diseño
    tt_um_multiplicador_4x4 dut (
        .ui_in   (ui_in),
        .uo_out  (uo_out),
        .uio_in  (uio_in),
        .uio_out (uio_out),
        .uio_oe  (uio_oe),
        .ena     (ena),
        .clk     (clk),
        .rst_n   (rst_n)
    );

    initial begin
        $dumpfile("tb.fst");
        $dumpvars(0, tb);

        clk = 0;
        rst_n = 0;
        ena = 1;
        uio_in = 8'b0;
        #20 rst_n = 1;

        // Pruebas rápidas
        ui_in = 8'h00; #40; assert(uo_out == 8'd0);
        ui_in = 8'h11; #40; assert(uo_out == 8'd1);   // 1×1
        ui_in = 8'h28; #40; assert(uo_out == 8'd16);  // 2×8
        ui_in = 8'hF3; #40; assert(uo_out == 8'd45);  // 15×3
        ui_in = 8'hFF; #40; assert(uo_out == 8'd225); // ement 15×15

        $display("¡Todas las pruebas pasaron!");
        $finish;
    end

    always #5 clk = ~clk;
endmodule
