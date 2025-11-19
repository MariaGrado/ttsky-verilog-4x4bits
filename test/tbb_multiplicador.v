`timescale 1ns/1ps
module tb_multiplicador;
    reg [7:0] ui_in;
    wire [7:0] uo_out;

    tt_um_multiplicador_4x4 dut (.ui_in(ui_in), .uo_out(uo_out), .ena(1'b1), .clk(1'b0), .rst_n(1'b1), .uio_in(8'b0));

    initial begin
        $display("a  b  →  producto  (esperado)");
        #10 ui_in = 8'h00; #10 $display("%d × %d → %d", ui_in[3:0], ui_in[7:4], uo_out);
        #10 ui_in = 8'h11; #10 $display("%d × %d → %d  (1×1)", ui_in[3:0], ui_in[7:4], uo_out);
        #10 ui_in = 8'h28; #10 $display("%d × %d → %d  (2×8)", ui_in[3:0], ui_in[7:4], uo_out);
        #10 ui_in = 8'hF3; #10 $display("%d × %d → %d  (15×3)", ui_in[3:0], ui_in[7:4], uo_out);
        #10 ui_in = 8'hFF; #10 $display("%d × %d → %d  (15×15)", ui_in[3:0], ui_in[7:4], uo_out);
        #20 $finish;
    end
endmodule
