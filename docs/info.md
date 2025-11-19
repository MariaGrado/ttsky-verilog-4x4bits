<!---
Tiny Tapeout datasheet for María Grado – Multiplicador 4×4 bits jerárquico
-->

## How it works

Este proyecto implementa un **multiplicador combinacional unsigned de 4 bits × 4 bits** con salida de 8 bits usando el clásico algoritmo de “shift and add”.

Está diseñado con **5 módulos Verilog jerárquicos** para demostrar claramente la interacción entre archivos .v:

1. `half_adder.v` → suma de 1 bit sin carry-in  
2. `full_adder.v` → suma de 1 bit con carry-in (instancia 2× half_adder)  
3. `rca4.v` → sumador ripple-carry de 4 bits (instancia 4× full_adder en cadena)  
4. `multiplier_core.v` → genera 4 productos parciales y los suma secuencialmente usando 3 instancias de rca4  
5. `tt_um_multiplicador_4x4.v` → top-level que conecta todo al padframe de Tiny Tapeout

Todo es **100 % combinacional** (sin flip-flops ni reloj), por lo que la salida aparece inmediatamente después de aplicar las entradas.

## How to test

- **Entradas** (`ui_in[7:0]`):  
  – Bits 3:0 → multiplicando **a** (4 bits)  
  – Bits 7:4 → multiplicador **b** (4 bits)  

- **Salida** (`uo_out[7:0]`): producto a × b (8 bits)

Ejemplos de prueba (resultado inmediato):

| a (hex) | b (hex) | a × b (decimal) | uo_out esperado (hex) |
|--------|--------|------------------|------------------------|
| 4'h0   | 4'h0   | 0 × 0 = 0        | 8'h00                  |
| 4'h1   | 4'h1   | 1 × 1 = 1        | 8'h01                  |
| 4'hA   | 4'h6   | 10 × 6 = 60      | 8'h3C                  |
| 4'hF   | 4'hF   | 15 × 15 = 225    | 8'hE1                  |

Puedes probarlo en Wokwi, en la simulación cocotb del repo o directamente en el chip físico cuando llegue.

## External hardware

**Ninguno requerido**  
El diseño es 100 % autónomo. Solo necesita alimentación y las 8 entradas/salidas del tile de Tiny Tapeout.  
No usa pines bidireccionales (uio), reloj ni reset.
