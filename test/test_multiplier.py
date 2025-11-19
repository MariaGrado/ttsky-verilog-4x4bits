# test_multiplier.py
import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def multiplier_test(dut):
    """Prueba completa del multiplicador 4x4 combinacional"""

    # Reset inicial (aunque no lo usemos)
    dut.rst_n.value = 0
    await Timer(10, units="ns")
    dut.rst_n.value = 1
    dut.ena.value = 1

    # Función helper para probar
    def test_mul(a, b):
        dut.ui_in.value = (b << 4) | a
        await Timer(10, units="ns")  # tiempo para propagación combinacional
        expected = a * b
        assert dut.uo_out.value == expected, f"Error: {a} × {b} = {dut.uo_out.value} ≠ {expected}"

    # Pruebas
    test_mul(0, 0)      # 0×0 = 0
    test_mul(1, 1)      # 1×1 = 1
    test_mul(2, 8)      # 2×8 = 16
    test_mul(15, 3)     # 15×3 = 45
    test_mul(10, 6)     # 10×6 = 60
    test_mul(15, 15)    # 15×15 = 225

    print("¡Todas las pruebas del multiplicador 4×4 pasaron!")
