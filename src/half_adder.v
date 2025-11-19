// half_adder.v
// Sumador de medio bit (1 bit + 1 bit → suma y acarreo)
// Se usa como bloque básico para construir sumadores completos

module half_adder (
    input  wire a,      // Entrada bit 0
    input  wire b,       // Entrada bit 1
    output wire sum,    // Salida suma (XOR)
    output wire cout    // Salida acarreo (AND)
);

    assign sum  = a ^ b;   // XOR para la suma
    assign cout = a & b;   // AND para el acarreo

endmodule
