// full_adder.v
// Sumador completo de 1 bit (a + b + cin)
// Construido jerárquicamente usando dos half_adder

module full_adder (
    input  wire a,      // Bit a
    input  wire b,      // Bit b
    input  wire cin,    // Acarreo de entrada
    output wire sum,    // Suma de 1 bit
    output wire cout    // Acarreo de salida
);

    // Cables internos para conectar los dos half_adder
    wire sum1;   // salida suma del primer half_adder
    wire carry1; // acarreo del primer half_adder
    wire carry2; // acarreo del segundo half_adder

    // Primera etapa: suma a y b (ignora cin por ahora)
    half_adder ha1 (
        .a   (a),
        .b   (b),
        .sum (sum1),
        .cout(carry1)
    );

    // Segunda etapa: suma el resultado anterior con cin
    half_adder ha2 (
        .a   (sum1),
        .b   (cin),
        .sum (sum),
        .cout(carry2)
    );

    // Acarreo final: OR entre los dos acarreos generados
    assign cout = carry1 | carry2;

endmodule
