// rca4.v
// Sumador Ripple Carry de 4 bits (a + b + cin)
// Usa 4 instancias de full_adder encadenadas

module rca4 (
    input  wire [3:0] a,    // Primer número de 4 bits
    input  wire [3:0] b,    // Segundo número de 4 bits
    input  wire       cin,  // Acarreo de entrada (normalmente 0)
    output wire [3:0] sum,  // Suma de 4 bits
    output wire       cout  // Acarreo de salida (bit 4)
);

    // Cables internos para propagar los acarreados entre etapas
    wire [4:1] carry;   // carry[1] sale del bit 0, carry[2] del bit 1, etc.

    // Instanciación de los 4 full_adder en cadena
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : ripple_chain
            if (i == 0)
                // Primer bit: usa cin externo
                full_adder fa (
                    .a   (a[i]),
                    .b   (b[i]),
                    .cin (cin),
                    .sum (sum[i]),
                    .cout(carry[1])
                );
            else
                // Bits siguientes: usa el carry del bit anterior
                full_adder fa (
                    .a   (a[i]),
                    .b   (b[i]),
                    .cin (carry[i]),
                    .sum (sum[i]),
                    .cout(carry[i+1])
                );
        end
    endgenerate

    // El acarreo final sale del último full_adder
    assign cout = carry[4];

endmodule
