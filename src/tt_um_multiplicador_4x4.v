// tt_um_multiplicador_4x4.v
// Top-level para Tiny Tapeout - Multiplicador 4x4 bits unsigned
// Entradas: ui_in[7:0] → {a[3:0], b[3:0]}
// Salidas:  uo_out[7:0] → product[7:0]

`default_nettype none

module tt_um_multiplicador_4x4 (
    input  wire [7:0] ui_in,    // Entradas dedicadas (a y b)
    output wire [7:0] uo_out,   // Salidas dedicadas (producto)
    input  wire [7:0] uio_in,   // IOs de entrada (no usamos)
    output wire [7:0] uio_out,  // IOs de salida (no usamos)
    output wire [7:0] uio_oe,   // Dirección de IOs (0 = salida, 1 = entrada)
    input  wire       ena,      // siempre 1 cuando está alimentado
    input  wire       clk,      // clock (no lo usamos, es combinacional)
    input  wire       rst_n     // reset activo en bajo (no lo usamos)
);

    // =================================================================
    // Asignación simple de pines (tú puedes cambiarla como quieras)
    // =================================================================
    wire [3:0] a = ui_in[3:0];     // bits 0-3 → multiplicando
    wire [3:0] b = ui_in[7:4];     // bits 4-7 → multiplicador

    wire [7:0] product;

    // Instancia del núcleo del multiplicador
    multiplier_core mul (
        .a(a),
        .b(b),
        .product(product)
    );

    // Salida directa del producto
    assign uo_out = product;

    // Pines bidireccionales no usados → los ponemos como entrada (high-Z)
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;  // 0 = high-Z (entrada)

    // Buenas prácticas del template
    wire _unused = &{ena, clk, rst_n, uio_in};

endmodule
