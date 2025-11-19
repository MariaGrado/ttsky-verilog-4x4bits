// multiplier_core.v
// Multiplicador combinacional unsigned 4 bits × 4 bits → 8 bits
// Usa método de array (shift and add) con rca4 para sumar parciales

module multiplier_core (
    input  wire [3:0] a,        // Multiplicando  (4 bits)
    input  wire [3:0] b,        // Multiplicador (4 bits)
    output wire [7:0] product   // Producto 8 bits
);

    // Productos parciales (cada uno es a & b[i], desplazado i posiciones)
    wire [7:0] pp0, pp1, pp2, pp3;

    assign pp0 = {4'b0, (a & {4{b[0]}})};  // bit 0: sin shift
    assign pp1 =  {3'b0, (a & {4{b[1]}}), 1'b0};  // shift 1
    assign pp2 =  {2'b0, (a & {4{b[2]}}), 2'b0};  // shift 2
    assign pp3 =  {1'b0, (a & {4{b[3]}}), 3'b0};  // shift 3

    // Sumas intermedias y acarreos
    wire [3:0] sum1, sum2, sum3;
    wire       c1, c2, c3;

    // Etapa 1: pp0 + pp1
    rca4 add1 (
        .a   (pp0[7:4]),
        .b   (pp1[7:4]),
        .cin (1'b0),
        .sum (sum1),
        .cout(c1)
    );
    assign product[3:0] = pp0[3:0] + pp1[3:0];  // bits bajos directos (sin carry)

    // Etapa 2: resultado anterior + pp2
    rca4 add2 (
        .a   (sum1),
        .b   (pp2[7:4]),
        .cin (c1),
        .sum (sum2),
        .cout(c2)
    );
    assign product[7:4] = sum2;

    // Etapa 3: resultado anterior + pp3 (solo los 4 bits altos + carry)
    rca4 add3 (
        .a   (product[7:4]),
        .b   (pp3[7:4]),
        .cin (c2),
        .sum (sum3),
        .cout(c3)
    );
    // La salida final incluye el último carry si hubiera overflow (unsigned 8 bits)
    assign product[7:4] = sum3;

    // Si quieres ver el bit 8 (overflow) puedes sacarlo por un pin extra más adelante
    // assign overflow = c3;

endmodule
