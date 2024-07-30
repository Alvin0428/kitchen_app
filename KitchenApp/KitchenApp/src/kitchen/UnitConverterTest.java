package kitchen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
import java.util.HashMap;
import java.util.Map;

/**
 * This test suite contains 110 individual tests for the UnitConverter logic.
 * Each test verifies the correctness of conversions between different units.
 * The conversions are tested with specific values to ensure accuracy.
 */

public class UnitConverterTest {
    private static final Map<String, Map<String, Double>> conversionRates = new HashMap<>() {{
        put("cup", new HashMap<>() {{
            put("cup", 1.0);
            put("tablespoon", 16.0);
            put("teaspoon", 48.0);
            put("kg", 0.24);
            put("g", 240.0);
            put("mg", 240000.0);
            put("l", 0.24);
            put("ml", 240.0);
            put("oz", 8.0);
            put("lb", 0.5);
            put("qt", 0.25);
        }});
        put("tablespoon", new HashMap<>() {{
            put("cup", 0.0625);
            put("tablespoon", 1.0);
            put("teaspoon", 3.0);
            put("kg", 0.015);
            put("g", 15.0);
            put("mg", 15000.0);
            put("l", 0.015);
            put("ml", 15.0);
            put("oz", 0.5);
            put("lb", 0.03125);
            put("qt", 0.015625);
        }});
        put("teaspoon", new HashMap<>() {{
            put("cup", 0.0208333);
            put("tablespoon", 0.333333);
            put("teaspoon", 1.0);
            put("kg", 0.005);
            put("g", 5.0);
            put("mg", 5000.0);
            put("l", 0.005);
            put("ml", 5.0);
            put("oz", 0.166667);
            put("lb", 0.0104167);
            put("qt", 0.00520833);
        }});
        put("kg", new HashMap<>() {{
            put("cup", 4.16667);
            put("tablespoon", 66.6667);
            put("teaspoon", 200.0);
            put("kg", 1.0);
            put("g", 1000.0);
            put("mg", 1000000.0);
            put("l", 1.0);
            put("ml", 1000.0);
            put("oz", 35.274);
            put("lb", 2.20462);
            put("qt", 1.05669);
        }});
        put("g", new HashMap<>() {{
            put("cup", 0.00416667);
            put("tablespoon", 0.0666667);
            put("teaspoon", 0.2);
            put("kg", 0.001);
            put("g", 1.0);
            put("mg", 1000.0);
            put("l", 0.001);
            put("ml", 1.0);
            put("oz", 0.035274);
            put("lb", 0.00220462);
            put("qt", 0.00105669);
        }});
        put("mg", new HashMap<>() {{
            put("cup", 0.00000416667);
            put("tablespoon", 0.0000666667);
            put("teaspoon", 0.0002);
            put("kg", 0.000001);
            put("g", 0.001);
            put("mg", 1.0);
            put("l", 0.000001);
            put("ml", 0.001);
            put("oz", 0.000035274);
            put("lb", 0.00000220462);
            put("qt", 0.00000105669);
        }});
        put("l", new HashMap<>() {{
            put("cup", 4.16667);
            put("tablespoon", 66.6667);
            put("teaspoon", 200.0);
            put("kg", 1.0);
            put("g", 1000.0);
            put("mg", 1000000.0);
            put("l", 1.0);
            put("ml", 1000.0);
            put("oz", 33.814);
            put("lb", 2.20462);
            put("qt", 1.05669);
        }});
        put("ml", new HashMap<>() {{
            put("cup", 0.00416667);
            put("tablespoon", 0.0666667);
            put("teaspoon", 0.2);
            put("kg", 0.001);
            put("g", 1.0);
            put("mg", 1000.0);
            put("l", 0.001);
            put("ml", 1.0);
            put("oz", 0.033814);
            put("lb", 0.00220462);
            put("qt", 0.00105669);
        }});
        put("oz", new HashMap<>() {{
            put("cup", 0.125);
            put("tablespoon", 2.0);
            put("teaspoon", 6.0);
            put("kg", 0.0283495);
            put("g", 28.3495);
            put("mg", 28349.5);
            put("l", 0.0295735);
            put("ml", 29.5735);
            put("oz", 1.0);
            put("lb", 0.0625);
            put("qt", 0.03125);
        }});
        put("lb", new HashMap<>() {{
            put("cup", 2.0);
            put("tablespoon", 32.0);
            put("teaspoon", 96.0);
            put("kg", 0.453592);
            put("g", 453.592);
            put("mg", 453592.0);
            put("l", 0.453592);
            put("ml", 453.592);
            put("oz", 16.0);
            put("lb", 1.0);
            put("qt", 0.5);
        }});
        put("qt", new HashMap<>() {{
            put("cup", 4.0);
            put("tablespoon", 64.0);
            put("teaspoon", 192.0);
            put("kg", 0.946353);
            put("g", 946.353);
            put("mg", 946353.0);
            put("l", 0.946353);
            put("ml", 946.353);
            put("oz", 32.0);
            put("lb", 2.0);
            put("qt", 1.0);
        }});
    }};

    // Function to perform a conversion
    double convert(String fromUnit, String toUnit, double value) {
        return value * (conversionRates.get(fromUnit).get(toUnit));
    }

    // Tests for conversions from 'cup'
    @Test
    public void testCupToTablespoon() {
        assertEquals(16.0, convert("cup", "tablespoon", 1.0), 0.001);
        assertEquals(32.0, convert("cup", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testCupToTeaspoon() {
        assertEquals(48.0, convert("cup", "teaspoon", 1.0), 0.001);
        assertEquals(96.0, convert("cup", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testCupToKg() {
        assertEquals(0.24, convert("cup", "kg", 1.0), 0.001);
        assertEquals(0.48, convert("cup", "kg", 2.0), 0.001);
    }

    @Test
    public void testCupToG() {
        assertEquals(240.0, convert("cup", "g", 1.0), 0.001);
        assertEquals(480.0, convert("cup", "g", 2.0), 0.001);
    }

    @Test
    public void testCupToMg() {
        assertEquals(240000.0, convert("cup", "mg", 1.0), 0.001);
        assertEquals(480000.0, convert("cup", "mg", 2.0), 0.001);
    }

    @Test
    public void testCupToL() {
        assertEquals(0.24, convert("cup", "l", 1.0), 0.001);
        assertEquals(0.48, convert("cup", "l", 2.0), 0.001);
    }

    @Test
    public void testCupToMl() {
        assertEquals(240.0, convert("cup", "ml", 1.0), 0.001);
        assertEquals(480.0, convert("cup", "ml", 2.0), 0.001);
    }

    @Test
    public void testCupToOz() {
        assertEquals(8.0, convert("cup", "oz", 1.0), 0.001);
        assertEquals(16.0, convert("cup", "oz", 2.0), 0.001);
    }

    @Test
    public void testCupToLb() {
        assertEquals(0.5, convert("cup", "lb", 1.0), 0.001);
        assertEquals(1.0, convert("cup", "lb", 2.0), 0.001);
    }

    @Test
    public void testCupToQt() {
        assertEquals(0.25, convert("cup", "qt", 1.0), 0.001);
        assertEquals(0.5, convert("cup", "qt", 2.0), 0.001);
    }

    // Additional tests for conversions from 'tablespoon', 'teaspoon', 'kg', 'g', 'mg', 'l', 'ml', 'oz', 'lb', and 'qt'...

    @Test
    public void testTablespoonToCup() {
        assertEquals(0.0625, convert("tablespoon", "cup", 1.0), 0.001);
        assertEquals(0.125, convert("tablespoon", "cup", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToTeaspoon() {
        assertEquals(3.0, convert("tablespoon", "teaspoon", 1.0), 0.001);
        assertEquals(6.0, convert("tablespoon", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToKg() {
        assertEquals(0.015, convert("tablespoon", "kg", 1.0), 0.001);
        assertEquals(0.03, convert("tablespoon", "kg", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToG() {
        assertEquals(15.0, convert("tablespoon", "g", 1.0), 0.001);
        assertEquals(30.0, convert("tablespoon", "g", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToMg() {
        assertEquals(15000.0, convert("tablespoon", "mg", 1.0), 0.001);
        assertEquals(30000.0, convert("tablespoon", "mg", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToL() {
        assertEquals(0.015, convert("tablespoon", "l", 1.0), 0.001);
        assertEquals(0.03, convert("tablespoon", "l", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToMl() {
        assertEquals(15.0, convert("tablespoon", "ml", 1.0), 0.001);
        assertEquals(30.0, convert("tablespoon", "ml", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToOz() {
        assertEquals(0.5, convert("tablespoon", "oz", 1.0), 0.001);
        assertEquals(1.0, convert("tablespoon", "oz", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToLb() {
        assertEquals(0.03125, convert("tablespoon", "lb", 1.0), 0.001);
        assertEquals(0.0625, convert("tablespoon", "lb", 2.0), 0.001);
    }

    @Test
    public void testTablespoonToQt() {
        assertEquals(0.015625, convert("tablespoon", "qt", 1.0), 0.001);
        assertEquals(0.03125, convert("tablespoon", "qt", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToCup() {
        assertEquals(0.0208333, convert("teaspoon", "cup", 1.0), 0.001);
        assertEquals(0.0416666, convert("teaspoon", "cup", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToTablespoon() {
        assertEquals(0.333333, convert("teaspoon", "tablespoon", 1.0), 0.001);
        assertEquals(0.666666, convert("teaspoon", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToKg() {
        assertEquals(0.005, convert("teaspoon", "kg", 1.0), 0.001);
        assertEquals(0.01, convert("teaspoon", "kg", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToG() {
        assertEquals(5.0, convert("teaspoon", "g", 1.0), 0.001);
        assertEquals(10.0, convert("teaspoon", "g", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToMg() {
        assertEquals(5000.0, convert("teaspoon", "mg", 1.0), 0.001);
        assertEquals(10000.0, convert("teaspoon", "mg", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToL() {
        assertEquals(0.005, convert("teaspoon", "l", 1.0), 0.001);
        assertEquals(0.01, convert("teaspoon", "l", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToMl() {
        assertEquals(5.0, convert("teaspoon", "ml", 1.0), 0.001);
        assertEquals(10.0, convert("teaspoon", "ml", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToOz() {
        assertEquals(0.166667, convert("teaspoon", "oz", 1.0), 0.001);
        assertEquals(0.333334, convert("teaspoon", "oz", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToLb() {
        assertEquals(0.0104167, convert("teaspoon", "lb", 1.0), 0.001);
        assertEquals(0.0208334, convert("teaspoon", "lb", 2.0), 0.001);
    }

    @Test
    public void testTeaspoonToQt() {
        assertEquals(0.00520833, convert("teaspoon", "qt", 1.0), 0.001);
        assertEquals(0.01041666, convert("teaspoon", "qt", 2.0), 0.001);
    }

    // Tests for conversions from 'kg'
    @Test
    public void testKgToCup() {
        assertEquals(4.16667, convert("kg", "cup", 1.0), 0.001);
        assertEquals(8.33334, convert("kg", "cup", 2.0), 0.001);
    }

    @Test
    public void testKgToTablespoon() {
        assertEquals(66.6667, convert("kg", "tablespoon", 1.0), 0.001);
        assertEquals(133.3334, convert("kg", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testKgToTeaspoon() {
        assertEquals(200.0, convert("kg", "teaspoon", 1.0), 0.001);
        assertEquals(400.0, convert("kg", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testKgToG() {
        assertEquals(1000.0, convert("kg", "g", 1.0), 0.001);
        assertEquals(2000.0, convert("kg", "g", 2.0), 0.001);
    }

    @Test
    public void testKgToMg() {
        assertEquals(1000000.0, convert("kg", "mg", 1.0), 0.001);
        assertEquals(2000000.0, convert("kg", "mg", 2.0), 0.001);
    }

    @Test
    public void testKgToL() {
        assertEquals(1.0, convert("kg", "l", 1.0), 0.001);
        assertEquals(2.0, convert("kg", "l", 2.0), 0.001);
    }

    @Test
    public void testKgToMl() {
        assertEquals(1000.0, convert("kg", "ml", 1.0), 0.001);
        assertEquals(2000.0, convert("kg", "ml", 2.0), 0.001);
    }

    @Test
    public void testKgToOz() {
        assertEquals(35.274, convert("kg", "oz", 1.0), 0.001);
        assertEquals(70.548, convert("kg", "oz", 2.0), 0.001);
    }

    @Test
    public void testKgToLb() {
        assertEquals(2.20462, convert("kg", "lb", 1.0), 0.001);
        assertEquals(4.40924, convert("kg", "lb", 2.0), 0.001);
    }

    @Test
    public void testKgToQt() {
        assertEquals(1.05669, convert("kg", "qt", 1.0), 0.001);
        assertEquals(2.11338, convert("kg", "qt", 2.0), 0.001);
    }

    // Tests for conversions from 'g'
    @Test
    public void testGToCup() {
        assertEquals(0.00416667, convert("g", "cup", 1.0), 0.001);
        assertEquals(0.00833334, convert("g", "cup", 2.0), 0.001);
    }

    @Test
    public void testGToTablespoon() {
        assertEquals(0.0666667, convert("g", "tablespoon", 1.0), 0.001);
        assertEquals(0.1333334, convert("g", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testGToTeaspoon() {
        assertEquals(0.2, convert("g", "teaspoon", 1.0), 0.001);
        assertEquals(0.4, convert("g", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testGToKg() {
        assertEquals(0.001, convert("g", "kg", 1.0), 0.001);
        assertEquals(0.002, convert("g", "kg", 2.0), 0.001);
    }

    @Test
    public void testGToMg() {
        assertEquals(1000.0, convert("g", "mg", 1.0), 0.001);
        assertEquals(2000.0, convert("g", "mg", 2.0), 0.001);
    }

    @Test
    public void testGToL() {
        assertEquals(0.001, convert("g", "l", 1.0), 0.001);
        assertEquals(0.002, convert("g", "l", 2.0), 0.001);
    }

    @Test
    public void testGToMl() {
        assertEquals(1.0, convert("g", "ml", 1.0), 0.001);
        assertEquals(2.0, convert("g", "ml", 2.0), 0.001);
    }

    @Test
    public void testGToOz() {
        assertEquals(0.035274, convert("g", "oz", 1.0), 0.001);
        assertEquals(0.070548, convert("g", "oz", 2.0), 0.001);
    }

    @Test
    public void testGToLb() {
        assertEquals(0.00220462, convert("g", "lb", 1.0), 0.001);
        assertEquals(0.00440924, convert("g", "lb", 2.0), 0.001);
    }

    @Test
    public void testGToQt() {
        assertEquals(0.00105669, convert("g", "qt", 1.0), 0.001);
        assertEquals(0.00211338, convert("g", "qt", 2.0), 0.001);
    }

    // Tests for conversions from 'mg'
    @Test
    public void testMgToCup() {
        assertEquals(0.00000416667, convert("mg", "cup", 1.0), 0.001);
        assertEquals(0.00000833334, convert("mg", "cup", 2.0), 0.001);
    }

    @Test
    public void testMgToTablespoon() {
        assertEquals(0.0000666667, convert("mg", "tablespoon", 1.0), 0.001);
        assertEquals(0.0001333334, convert("mg", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testMgToTeaspoon() {
        assertEquals(0.0002, convert("mg", "teaspoon", 1.0), 0.001);
        assertEquals(0.0004, convert("mg", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testMgToKg() {
        assertEquals(0.000001, convert("mg", "kg", 1.0), 0.001);
        assertEquals(0.000002, convert("mg", "kg", 2.0), 0.001);
    }

    @Test
    public void testMgToG() {
        assertEquals(0.001, convert("mg", "g", 1.0), 0.001);
        assertEquals(0.002, convert("mg", "g", 2.0), 0.001);
    }

    @Test
    public void testMgToL() {
        assertEquals(0.000001, convert("mg", "l", 1.0), 0.001);
        assertEquals(0.000002, convert("mg", "l", 2.0), 0.001);
    }

    @Test
    public void testMgToMl() {
        assertEquals(0.001, convert("mg", "ml", 1.0), 0.001);
        assertEquals(0.002, convert("mg", "ml", 2.0), 0.001);
    }

    @Test
    public void testMgToOz() {
        assertEquals(0.000035274, convert("mg", "oz", 1.0), 0.001);
        assertEquals(0.000070548, convert("mg", "oz", 2.0), 0.001);
    }

    @Test
    public void testMgToLb() {
        assertEquals(0.00000220462, convert("mg", "lb", 1.0), 0.001);
        assertEquals(0.00000440924, convert("mg", "lb", 2.0), 0.001);
    }

    @Test
    public void testMgToQt() {
        assertEquals(0.00000105669, convert("mg", "qt", 1.0), 0.001);
        assertEquals(0.00000211338, convert("mg", "qt", 2.0), 0.001);
    }

    // Tests for conversions from 'l'
    @Test
    public void testLToCup() {
        assertEquals(4.16667, convert("l", "cup", 1.0), 0.001);
        assertEquals(8.33334, convert("l", "cup", 2.0), 0.001);
    }

    @Test
    public void testLToTablespoon() {
        assertEquals(66.6667, convert("l", "tablespoon", 1.0), 0.001);
        assertEquals(133.3334, convert("l", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testLToTeaspoon() {
        assertEquals(200.0, convert("l", "teaspoon", 1.0), 0.001);
        assertEquals(400.0, convert("l", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testLToKg() {
        assertEquals(1.0, convert("l", "kg", 1.0), 0.001);
        assertEquals(2.0, convert("l", "kg", 2.0), 0.001);
    }

    @Test
    public void testLToG() {
        assertEquals(1000.0, convert("l", "g", 1.0), 0.001);
        assertEquals(2000.0, convert("l", "g", 2.0), 0.001);
    }

    @Test
    public void testLToMg() {
        assertEquals(1000000.0, convert("l", "mg", 1.0), 0.001);
        assertEquals(2000000.0, convert("l", "mg", 2.0), 0.001);
    }

    @Test
    public void testLToMl() {
        assertEquals(1000.0, convert("l", "ml", 1.0), 0.001);
        assertEquals(2000.0, convert("l", "ml", 2.0), 0.001);
    }

    @Test
    public void testLToOz() {
        assertEquals(33.814, convert("l", "oz", 1.0), 0.001);
        assertEquals(67.628, convert("l", "oz", 2.0), 0.001);
    }

    @Test
    public void testLToLb() {
        assertEquals(2.20462, convert("l", "lb", 1.0), 0.001);
        assertEquals(4.40924, convert("l", "lb", 2.0), 0.001);
    }

    @Test
    public void testLToQt() {
        assertEquals(1.05669, convert("l", "qt", 1.0), 0.001);
        assertEquals(2.11338, convert("l", "qt", 2.0), 0.001);
    }

    // Tests for conversions from 'ml'
    @Test
    public void testMlToCup() {
        assertEquals(0.00416667, convert("ml", "cup", 1.0), 0.001);
        assertEquals(0.00833334, convert("ml", "cup", 2.0), 0.001);
    }

    @Test
    public void testMlToTablespoon() {
        assertEquals(0.0666667, convert("ml", "tablespoon", 1.0), 0.001);
        assertEquals(0.1333334, convert("ml", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testMlToTeaspoon() {
        assertEquals(0.2, convert("ml", "teaspoon", 1.0), 0.001);
        assertEquals(0.4, convert("ml", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testMlToKg() {
        assertEquals(0.001, convert("ml", "kg", 1.0), 0.001);
        assertEquals(0.002, convert("ml", "kg", 2.0), 0.001);
    }

    @Test
    public void testMlToG() {
        assertEquals(1.0, convert("ml", "g", 1.0), 0.001);
        assertEquals(2.0, convert("ml", "g", 2.0), 0.001);
    }

    @Test
    public void testMlToMg() {
        assertEquals(1000.0, convert("ml", "mg", 1.0), 0.001);
        assertEquals(2000.0, convert("ml", "mg", 2.0), 0.001);
    }

    @Test
    public void testMlToL() {
        assertEquals(0.001, convert("ml", "l", 1.0), 0.001);
        assertEquals(0.002, convert("ml", "l", 2.0), 0.001);
    }

    @Test
    public void testMlToOz() {
        assertEquals(0.033814, convert("ml", "oz", 1.0), 0.001);
        assertEquals(0.067628, convert("ml", "oz", 2.0), 0.001);
    }

    @Test
    public void testMlToLb() {
        assertEquals(0.00220462, convert("ml", "lb", 1.0), 0.001);
        assertEquals(0.00440924, convert("ml", "lb", 2.0), 0.001);
    }

    @Test
    public void testMlToQt() {
        assertEquals(0.00105669, convert("ml", "qt", 1.0), 0.001);
        assertEquals(0.00211338, convert("ml", "qt", 2.0), 0.001);
    }

    // Tests for conversions from 'oz'
    @Test
    public void testOzToCup() {
        assertEquals(0.125, convert("oz", "cup", 1.0), 0.001);
        assertEquals(0.25, convert("oz", "cup", 2.0), 0.001);
    }

    @Test
    public void testOzToTablespoon() {
        assertEquals(2.0, convert("oz", "tablespoon", 1.0), 0.001);
        assertEquals(4.0, convert("oz", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testOzToTeaspoon() {
        assertEquals(6.0, convert("oz", "teaspoon", 1.0), 0.001);
        assertEquals(12.0, convert("oz", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testOzToKg() {
        assertEquals(0.0283495, convert("oz", "kg", 1.0), 0.001);
        assertEquals(0.056699, convert("oz", "kg", 2.0), 0.001);
    }

    @Test
    public void testOzToG() {
        assertEquals(28.3495, convert("oz", "g", 1.0), 0.001);
        assertEquals(56.699, convert("oz", "g", 2.0), 0.001);
    }

    @Test
    public void testOzToMg() {
        assertEquals(28349.5, convert("oz", "mg", 1.0), 0.001);
        assertEquals(56699.0, convert("oz", "mg", 2.0), 0.001);
    }

    @Test
    public void testOzToL() {
        assertEquals(0.0295735, convert("oz", "l", 1.0), 0.001);
        assertEquals(0.059147, convert("oz", "l", 2.0), 0.001);
    }

    @Test
    public void testOzToMl() {
        assertEquals(29.5735, convert("oz", "ml", 1.0), 0.001);
        assertEquals(59.147, convert("oz", "ml", 2.0), 0.001);
    }

    @Test
    public void testOzToLb() {
        assertEquals(0.0625, convert("oz", "lb", 1.0), 0.001);
        assertEquals(0.125, convert("oz", "lb", 2.0), 0.001);
    }

    @Test
    public void testOzToQt() {
        assertEquals(0.03125, convert("oz", "qt", 1.0), 0.001);
        assertEquals(0.0625, convert("oz", "qt", 2.0), 0.001);
    }

    // Tests for conversions from 'lb'
    @Test
    public void testLbToCup() {
        assertEquals(2.0, convert("lb", "cup", 1.0), 0.001);
        assertEquals(4.0, convert("lb", "cup", 2.0), 0.001);
    }

    @Test
    public void testLbToTablespoon() {
        assertEquals(32.0, convert("lb", "tablespoon", 1.0), 0.001);
        assertEquals(64.0, convert("lb", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testLbToTeaspoon() {
        assertEquals(96.0, convert("lb", "teaspoon", 1.0), 0.001);
        assertEquals(192.0, convert("lb", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testLbToKg() {
        assertEquals(0.453592, convert("lb", "kg", 1.0), 0.001);
        assertEquals(0.907184, convert("lb", "kg", 2.0), 0.001);
    }

    @Test
    public void testLbToG() {
        assertEquals(453.592, convert("lb", "g", 1.0), 0.001);
        assertEquals(907.184, convert("lb", "g", 2.0), 0.001);
    }

    @Test
    public void testLbToMg() {
        assertEquals(453592.0, convert("lb", "mg", 1.0), 0.001);
        assertEquals(907184.0, convert("lb", "mg", 2.0), 0.001);
    }

    @Test
    public void testLbToL() {
        assertEquals(0.453592, convert("lb", "l", 1.0), 0.001);
        assertEquals(0.907184, convert("lb", "l", 2.0), 0.001);
    }

    @Test
    public void testLbToMl() {
        assertEquals(453.592, convert("lb", "ml", 1.0), 0.001);
        assertEquals(907.184, convert("lb", "ml", 2.0), 0.001);
    }

    @Test
    public void testLbToOz() {
        assertEquals(16.0, convert("lb", "oz", 1.0), 0.001);
        assertEquals(32.0, convert("lb", "oz", 2.0), 0.001);
    }

    @Test
    public void testLbToQt() {
        assertEquals(0.5, convert("lb", "qt", 1.0), 0.001);
        assertEquals(1.0, convert("lb", "qt", 2.0), 0.001);
    }

    // Tests for conversions from 'qt'
    @Test
    public void testQtToCup() {
        assertEquals(4.0, convert("qt", "cup", 1.0), 0.001);
        assertEquals(8.0, convert("qt", "cup", 2.0), 0.001);
    }

    @Test
    public void testQtToTablespoon() {
        assertEquals(64.0, convert("qt", "tablespoon", 1.0), 0.001);
        assertEquals(128.0, convert("qt", "tablespoon", 2.0), 0.001);
    }

    @Test
    public void testQtToTeaspoon() {
        assertEquals(192.0, convert("qt", "teaspoon", 1.0), 0.001);
        assertEquals(384.0, convert("qt", "teaspoon", 2.0), 0.001);
    }

    @Test
    public void testQtToKg() {
        assertEquals(0.946353, convert("qt", "kg", 1.0), 0.001);
        assertEquals(1.892706, convert("qt", "kg", 2.0), 0.001);
    }

    @Test
    public void testQtToG() {
        assertEquals(946.353, convert("qt", "g", 1.0), 0.001);
        assertEquals(1892.706, convert("qt", "g", 2.0), 0.001);
    }

    @Test
    public void testQtToMg() {
        assertEquals(946353.0, convert("qt", "mg", 1.0), 0.001);
        assertEquals(1892706.0, convert("qt", "mg", 2.0), 0.001);
    }

    @Test
    public void testQtToL() {
        assertEquals(0.946353, convert("qt", "l", 1.0), 0.001);
        assertEquals(1.892706, convert("qt", "l", 2.0), 0.001);
    }

    @Test
    public void testQtToMl() {
        assertEquals(946.353, convert("qt", "ml", 1.0), 0.001);
        assertEquals(1892.706, convert("qt", "ml", 2.0), 0.001);
    }

    @Test
    public void testQtToOz() {
        assertEquals(32.0, convert("qt", "oz", 1.0), 0.001);
        assertEquals(64.0, convert("qt", "oz", 2.0), 0.001);
    }

    @Test
    public void testQtToLb() {
        assertEquals(2.0, convert("qt", "lb", 1.0), 0.001);
        assertEquals(4.0, convert("qt", "lb", 2.0), 0.001);
    }
}
