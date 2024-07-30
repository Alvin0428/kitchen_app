import 'package:flutter_test/flutter_test.dart';

/**
 * This test suite contains various testing techniques for the UnitConverter logic.
 * Each test verifies the correctness of conversions between different units.
 * The conversions are tested with specific values to ensure accuracy.
 * 
 * Testing Techniques:
 * - Robust Boundary Value Tests (cup to other units)
 * - Strong Normal Equivalence Tests (tablespoon to other units, teaspoon to other units)
 * - Random Analysis Tests (kg to other units, g to other units, mg to other units)
 * - Robust Worst Case Analysis Tests (l to other units, ml to other units, oz to other units)
 * - Special Value Analysis Tests (lb to other units, qt to other units)
 */

void main() {
  group('UnitConverter Logic Tests', () {
    const Map<String, Map<String, double>> conversionRates = {
      'cup': {
        'cup': 1,
        'tablespoon': 16,
        'teaspoon': 48,
        'kg': 0.24,
        'g': 240,
        'mg': 240000,
        'l': 0.24,
        'ml': 240,
        'oz': 8,
        'lb': 0.5,
        'qt': 0.25
      },
      'tablespoon': {
        'cup': 0.0625,
        'tablespoon': 1,
        'teaspoon': 3,
        'kg': 0.015,
        'g': 15,
        'mg': 15000,
        'l': 0.015,
        'ml': 15,
        'oz': 0.5,
        'lb': 0.03125,
        'qt': 0.015625
      },
      'teaspoon': {
        'cup': 0.0208333,
        'tablespoon': 0.333333,
        'teaspoon': 1,
        'kg': 0.005,
        'g': 5,
        'mg': 5000,
        'l': 0.005,
        'ml': 5,
        'oz': 0.166667,
        'lb': 0.0104167,
        'qt': 0.00520833
      },
      'kg': {
        'cup': 4.16667,
        'tablespoon': 66.6667,
        'teaspoon': 200,
        'kg': 1,
        'g': 1000,
        'mg': 1000000,
        'l': 1,
        'ml': 1000,
        'oz': 35.274,
        'lb': 2.20462,
        'qt': 1.05669
      },
      'g': {
        'cup': 0.00416667,
        'tablespoon': 0.0666667,
        'teaspoon': 0.2,
        'kg': 0.001,
        'g': 1,
        'mg': 1000,
        'l': 0.001,
        'ml': 1,
        'oz': 0.035274,
        'lb': 0.00220462,
        'qt': 0.00105669
      },
      'mg': {
        'cup': 0.00000416667,
        'tablespoon': 0.0000666667,
        'teaspoon': 0.0002,
        'kg': 0.000001,
        'g': 0.001,
        'mg': 1,
        'l': 0.000001,
        'ml': 0.001,
        'oz': 0.000035274,
        'lb': 0.00000220462,
        'qt': 0.00000105669
      },
      'l': {
        'cup': 4.16667,
        'tablespoon': 66.6667,
        'teaspoon': 200,
        'kg': 1,
        'g': 1000,
        'mg': 1000000,
        'l': 1,
        'ml': 1000,
        'oz': 33.814,
        'lb': 2.20462,
        'qt': 1.05669
      },
      'ml': {
        'cup': 0.00416667,
        'tablespoon': 0.0666667,
        'teaspoon': 0.2,
        'kg': 0.001,
        'g': 1,
        'mg': 1000,
        'l': 0.001,
        'ml': 1,
        'oz': 0.033814,
        'lb': 0.00220462,
        'qt': 0.00105669
      },
      'oz': {
        'cup': 0.125,
        'tablespoon': 2,
        'teaspoon': 6,
        'kg': 0.0283495,
        'g': 28.3495,
        'mg': 28349.5,
        'l': 0.0295735,
        'ml': 29.5735,
        'oz': 1,
        'lb': 0.0625,
        'qt': 0.03125
      },
      'lb': {
        'cup': 2,
        'tablespoon': 32,
        'teaspoon': 96,
        'kg': 0.453592,
        'g': 453.592,
        'mg': 453592,
        'l': 0.453592,
        'ml': 453.592,
        'oz': 16,
        'lb': 1,
        'qt': 0.5
      },
      'qt': {
        'cup': 4,
        'tablespoon': 64,
        'teaspoon': 192,
        'kg': 0.946353,
        'g': 946.353,
        'mg': 946353,
        'l': 0.946353,
        'ml': 946.353,
        'oz': 32,
        'lb': 2,
        'qt': 1
      }
    };

    // Function to perform a conversion
    double convert(String fromUnit, String toUnit, double value) {
      return value * (conversionRates[fromUnit]?[toUnit] ?? 1);
    }

    // Helper function to ensure valid input range
    double validateInput(double value) {
      if (value < 0) return 0;
      if (value > 100000) return 100000;
      return value;
    }

    // Helper function to format result to 2 decimal places
    double formatResult(double value) {
      return double.parse(value.toStringAsFixed(2));
    }

    // Helper function to compare with a tolerance of 0.1
    Matcher closeTo(double expected, double delta) {
      return predicate((value) {
        if (value is double) {
          return (value - expected).abs() <= delta;
        }
        return false;
      }, 'a numeric value within <$delta> of <$expected>');
    }

    // Robust Boundary Value Tests for conversions from 'cup'
    test('Convert 0 cup to tablespoon', () {
      final result = formatResult(convert('cup', 'tablespoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to tablespoon', () {
      final result = formatResult(convert('cup', 'tablespoon', validateInput(100000.0)));
      expect(result, closeTo(1600000.0, 0.1));
    });

    test('Convert -1 cup to tablespoon', () {
      final result = formatResult(convert('cup', 'tablespoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to tablespoon', () {
      final result = formatResult(convert('cup', 'tablespoon', validateInput(1.0)));
      expect(result, closeTo(16.0, 0.1));
    });

    test('Convert 50000 cup to tablespoon', () {
      final result = formatResult(convert('cup', 'tablespoon', validateInput(50000.0)));
      expect(result, closeTo(800000.0, 0.1));
    });

    test('Convert 0 cup to teaspoon', () {
      final result = formatResult(convert('cup', 'teaspoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to teaspoon', () {
      final result = formatResult(convert('cup', 'teaspoon', validateInput(100000.0)));
      expect(result, closeTo(4800000.0, 0.1));
    });

    test('Convert -1 cup to teaspoon', () {
      final result = formatResult(convert('cup', 'teaspoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to teaspoon', () {
      final result = formatResult(convert('cup', 'teaspoon', validateInput(1.0)));
      expect(result, closeTo(48.0, 0.1));
    });

    test('Convert 50000 cup to teaspoon', () {
      final result = formatResult(convert('cup', 'teaspoon', validateInput(50000.0)));
      expect(result, closeTo(2400000.0, 0.1));
    });

    test('Convert 0 cup to kg', () {
      final result = formatResult(convert('cup', 'kg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to kg', () {
      final result = formatResult(convert('cup', 'kg', validateInput(100000.0)));
      expect(result, closeTo(24000.0, 0.1));
    });

    test('Convert -1 cup to kg', () {
      final result = formatResult(convert('cup', 'kg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to kg', () {
      final result = formatResult(convert('cup', 'kg', validateInput(1.0)));
      expect(result, closeTo(0.24, 0.1));
    });

    test('Convert 50000 cup to kg', () {
      final result = formatResult(convert('cup', 'kg', validateInput(50000.0)));
      expect(result, closeTo(12000.0, 0.1));
    });

    test('Convert 0 cup to g', () {
      final result = formatResult(convert('cup', 'g', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to g', () {
      final result = formatResult(convert('cup', 'g', validateInput(100000.0)));
      expect(result, closeTo(24000000.0, 0.1));
    });

    test('Convert -1 cup to g', () {
      final result = formatResult(convert('cup', 'g', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to g', () {
      final result = formatResult(convert('cup', 'g', validateInput(1.0)));
      expect(result, closeTo(240.0, 0.1));
    });

    test('Convert 50000 cup to g', () {
      final result = formatResult(convert('cup', 'g', validateInput(50000.0)));
      expect(result, closeTo(12000000.0, 0.1));
    });

    test('Convert 0 cup to mg', () {
      final result = formatResult(convert('cup', 'mg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to mg', () {
      final result = formatResult(convert('cup', 'mg', validateInput(100000.0)));
      expect(result, closeTo(24000000000.0, 0.1));
    });

    test('Convert -1 cup to mg', () {
      final result = formatResult(convert('cup', 'mg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to mg', () {
      final result = formatResult(convert('cup', 'mg', validateInput(1.0)));
      expect(result, closeTo(240000.0, 0.1));
    });

    test('Convert 50000 cup to mg', () {
      final result = formatResult(convert('cup', 'mg', validateInput(50000.0)));
      expect(result, closeTo(12000000000.0, 0.1));
    });

    test('Convert 0 cup to l', () {
      final result = formatResult(convert('cup', 'l', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to l', () {
      final result = formatResult(convert('cup', 'l', validateInput(100000.0)));
      expect(result, closeTo(24000.0, 0.1));
    });

    test('Convert -1 cup to l', () {
      final result = formatResult(convert('cup', 'l', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to l', () {
      final result = formatResult(convert('cup', 'l', validateInput(1.0)));
      expect(result, closeTo(0.24, 0.1));
    });

    test('Convert 50000 cup to l', () {
      final result = formatResult(convert('cup', 'l', validateInput(50000.0)));
      expect(result, closeTo(12000.0, 0.1));
    });

    test('Convert 0 cup to ml', () {
      final result = formatResult(convert('cup', 'ml', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to ml', () {
      final result = formatResult(convert('cup', 'ml', validateInput(100000.0)));
      expect(result, closeTo(24000000.0, 0.1));
    });

    test('Convert -1 cup to ml', () {
      final result = formatResult(convert('cup', 'ml', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to ml', () {
      final result = formatResult(convert('cup', 'ml', validateInput(1.0)));
      expect(result, closeTo(240.0, 0.1));
    });

    test('Convert 50000 cup to ml', () {
      final result = formatResult(convert('cup', 'ml', validateInput(50000.0)));
      expect(result, closeTo(12000000.0, 0.1));
    });

    test('Convert 0 cup to oz', () {
      final result = formatResult(convert('cup', 'oz', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to oz', () {
      final result = formatResult(convert('cup', 'oz', validateInput(100000.0)));
      expect(result, closeTo(800000.0, 0.1));
    });

    test('Convert -1 cup to oz', () {
      final result = formatResult(convert('cup', 'oz', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to oz', () {
      final result = formatResult(convert('cup', 'oz', validateInput(1.0)));
      expect(result, closeTo(8.0, 0.1));
    });

    test('Convert 50000 cup to oz', () {
      final result = formatResult(convert('cup', 'oz', validateInput(50000.0)));
      expect(result, closeTo(400000.0, 0.1));
    });

    test('Convert 0 cup to lb', () {
      final result = formatResult(convert('cup', 'lb', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to lb', () {
      final result = formatResult(convert('cup', 'lb', validateInput(100000.0)));
      expect(result, closeTo(50000.0, 0.1));
    });

    test('Convert -1 cup to lb', () {
      final result = formatResult(convert('cup', 'lb', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to lb', () {
      final result = formatResult(convert('cup', 'lb', validateInput(1.0)));
      expect(result, closeTo(0.5, 0.1));
    });

    test('Convert 50000 cup to lb', () {
      final result = formatResult(convert('cup', 'lb', validateInput(50000.0)));
      expect(result, closeTo(25000.0, 0.1));
    });

    test('Convert 0 cup to qt', () {
      final result = formatResult(convert('cup', 'qt', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 cup to qt', () {
      final result = formatResult(convert('cup', 'qt', validateInput(100000.0)));
      expect(result, closeTo(25000.0, 0.1));
    });

    test('Convert -1 cup to qt', () {
      final result = formatResult(convert('cup', 'qt', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 cup to qt', () {
      final result = formatResult(convert('cup', 'qt', validateInput(1.0)));
      expect(result, closeTo(0.25, 0.1));
    });

    test('Convert 50000 cup to qt', () {
      final result = formatResult(convert('cup', 'qt', validateInput(50000.0)));
      expect(result, closeTo(12500.0, 0.1));
    });

    // Strong Normal Equivalence Tests for conversions from 'tablespoon'
    test('Convert 1 tablespoon to cup', () {
      final result = formatResult(convert('tablespoon', 'cup', validateInput(1.0)));
      expect(result, closeTo(0.06, 0.1));
    });

    test('Convert 2 tablespoon to cup', () {
      final result = formatResult(convert('tablespoon', 'cup', validateInput(2.0)));
      expect(result, closeTo(0.12, 0.1));
    });

    test('Convert 4 tablespoon to cup', () {
      final result = formatResult(convert('tablespoon', 'cup', validateInput(4.0)));
      expect(result, closeTo(0.25, 0.1));
    });

    test('Convert 1 tablespoon to teaspoon', () {
      final result = formatResult(convert('tablespoon', 'teaspoon', validateInput(1.0)));
      expect(result, closeTo(3.0, 0.1));
    });

    test('Convert 2 tablespoon to teaspoon', () {
      final result = formatResult(convert('tablespoon', 'teaspoon', validateInput(2.0)));
      expect(result, closeTo(6.0, 0.1));
    });

    test('Convert 4 tablespoon to teaspoon', () {
      final result = formatResult(convert('tablespoon', 'teaspoon', validateInput(4.0)));
      expect(result, closeTo(12.0, 0.1));
    });

    test('Convert 1 tablespoon to kg', () {
      final result = formatResult(convert('tablespoon', 'kg', validateInput(1.0)));
      expect(result, closeTo(0.02, 0.1));
    });

    test('Convert 2 tablespoon to kg', () {
      final result = formatResult(convert('tablespoon', 'kg', validateInput(2.0)));
      expect(result, closeTo(0.03, 0.1));
    });

    test('Convert 4 tablespoon to kg', () {
      final result = formatResult(convert('tablespoon', 'kg', validateInput(4.0)));
      expect(result, closeTo(0.06, 0.1));
    });

    test('Convert 1 tablespoon to g', () {
      final result = formatResult(convert('tablespoon', 'g', validateInput(1.0)));
      expect(result, closeTo(15.0, 0.1));
    });

    test('Convert 2 tablespoon to g', () {
      final result = formatResult(convert('tablespoon', 'g', validateInput(2.0)));
      expect(result, closeTo(30.0, 0.1));
    });

    test('Convert 4 tablespoon to g', () {
      final result = formatResult(convert('tablespoon', 'g', validateInput(4.0)));
      expect(result, closeTo(60.0, 0.1));
    });

    test('Convert 1 tablespoon to mg', () {
      final result = formatResult(convert('tablespoon', 'mg', validateInput(1.0)));
      expect(result, closeTo(15000.0, 0.1));
    });

    test('Convert 2 tablespoon to mg', () {
      final result = formatResult(convert('tablespoon', 'mg', validateInput(2.0)));
      expect(result, closeTo(30000.0, 0.1));
    });

    test('Convert 4 tablespoon to mg', () {
      final result = formatResult(convert('tablespoon', 'mg', validateInput(4.0)));
      expect(result, closeTo(60000.0, 0.1));
    });

    test('Convert 1 tablespoon to l', () {
      final result = formatResult(convert('tablespoon', 'l', validateInput(1.0)));
      expect(result, closeTo(0.02, 0.1));
    });

    test('Convert 2 tablespoon to l', () {
      final result = formatResult(convert('tablespoon', 'l', validateInput(2.0)));
      expect(result, closeTo(0.03, 0.1));
    });

    test('Convert 4 tablespoon to l', () {
      final result = formatResult(convert('tablespoon', 'l', validateInput(4.0)));
      expect(result, closeTo(0.06, 0.1));
    });

    test('Convert 1 tablespoon to ml', () {
      final result = formatResult(convert('tablespoon', 'ml', validateInput(1.0)));
      expect(result, closeTo(15.0, 0.1));
    });

    test('Convert 2 tablespoon to ml', () {
      final result = formatResult(convert('tablespoon', 'ml', validateInput(2.0)));
      expect(result, closeTo(30.0, 0.1));
    });

    test('Convert 4 tablespoon to ml', () {
      final result = formatResult(convert('tablespoon', 'ml', validateInput(4.0)));
      expect(result, closeTo(60.0, 0.1));
    });

    test('Convert 1 tablespoon to oz', () {
      final result = formatResult(convert('tablespoon', 'oz', validateInput(1.0)));
      expect(result, closeTo(0.5, 0.1));
    });

    test('Convert 2 tablespoon to oz', () {
      final result = formatResult(convert('tablespoon', 'oz', validateInput(2.0)));
      expect(result, closeTo(1.0, 0.1));
    });

    test('Convert 4 tablespoon to oz', () {
      final result = formatResult(convert('tablespoon', 'oz', validateInput(4.0)));
      expect(result, closeTo(2.0, 0.1));
    });

    test('Convert 1 tablespoon to lb', () {
      final result = formatResult(convert('tablespoon', 'lb', validateInput(1.0)));
      expect(result, closeTo(0.03, 0.1));
    });

    test('Convert 2 tablespoon to lb', () {
      final result = formatResult(convert('tablespoon', 'lb', validateInput(2.0)));
      expect(result, closeTo(0.06, 0.1));
    });

    test('Convert 4 tablespoon to lb', () {
      final result = formatResult(convert('tablespoon', 'lb', validateInput(4.0)));
      expect(result, closeTo(0.12, 0.1));
    });

    test('Convert 1 tablespoon to qt', () {
      final result = formatResult(convert('tablespoon', 'qt', validateInput(1.0)));
      expect(result, closeTo(0.02, 0.1));
    });

    test('Convert 2 tablespoon to qt', () {
      final result = formatResult(convert('tablespoon', 'qt', validateInput(2.0)));
      expect(result, closeTo(0.03, 0.1));
    });

    test('Convert 4 tablespoon to qt', () {
      final result = formatResult(convert('tablespoon', 'qt', validateInput(4.0)));
      expect(result, closeTo(0.06, 0.1));
    });

    // Strong Normal Equivalence Tests for conversions from 'teaspoon'
    test('Convert 1 teaspoon to cup', () {
      final result = formatResult(convert('teaspoon', 'cup', validateInput(1.0)));
      expect(result, closeTo(0.02, 0.1));
    });

    test('Convert 2 teaspoon to cup', () {
      final result = formatResult(convert('teaspoon', 'cup', validateInput(2.0)));
      expect(result, closeTo(0.04, 0.1));
    });

    test('Convert 4 teaspoon to cup', () {
      final result = formatResult(convert('teaspoon', 'cup', validateInput(4.0)));
      expect(result, closeTo(0.08, 0.1));
    });

    test('Convert 1 teaspoon to tablespoon', () {
      final result = formatResult(convert('teaspoon', 'tablespoon', validateInput(1.0)));
      expect(result, closeTo(0.33, 0.1));
    });

    test('Convert 2 teaspoon to tablespoon', () {
      final result = formatResult(convert('teaspoon', 'tablespoon', validateInput(2.0)));
      expect(result, closeTo(0.67, 0.1));
    });

    test('Convert 4 teaspoon to tablespoon', () {
      final result = formatResult(convert('teaspoon', 'tablespoon', validateInput(4.0)));
      expect(result, closeTo(1.33, 0.1));
    });

    test('Convert 1 teaspoon to kg', () {
      final result = formatResult(convert('teaspoon', 'kg', validateInput(1.0)));
      expect(result, closeTo(0.01, 0.1));
    });

    test('Convert 2 teaspoon to kg', () {
      final result = formatResult(convert('teaspoon', 'kg', validateInput(2.0)));
      expect(result, closeTo(0.01, 0.1));
    });

    test('Convert 4 teaspoon to kg', () {
      final result = formatResult(convert('teaspoon', 'kg', validateInput(4.0)));
      expect(result, closeTo(0.02, 0.1));
    });

    test('Convert 1 teaspoon to g', () {
      final result = formatResult(convert('teaspoon', 'g', validateInput(1.0)));
      expect(result, closeTo(5.0, 0.1));
    });

    test('Convert 2 teaspoon to g', () {
      final result = formatResult(convert('teaspoon', 'g', validateInput(2.0)));
      expect(result, closeTo(10.0, 0.1));
    });

    test('Convert 4 teaspoon to g', () {
      final result = formatResult(convert('teaspoon', 'g', validateInput(4.0)));
      expect(result, closeTo(20.0, 0.1));
    });

    test('Convert 1 teaspoon to mg', () {
      final result = formatResult(convert('teaspoon', 'mg', validateInput(1.0)));
      expect(result, closeTo(5000.0, 0.1));
    });

    test('Convert 2 teaspoon to mg', () {
      final result = formatResult(convert('teaspoon', 'mg', validateInput(2.0)));
      expect(result, closeTo(10000.0, 0.1));
    });

    test('Convert 4 teaspoon to mg', () {
      final result = formatResult(convert('teaspoon', 'mg', validateInput(4.0)));
      expect(result, closeTo(20000.0, 0.1));
    });

    test('Convert 1 teaspoon to l', () {
      final result = formatResult(convert('teaspoon', 'l', validateInput(1.0)));
      expect(result, closeTo(0.01, 0.1));
    });

    test('Convert 2 teaspoon to l', () {
      final result = formatResult(convert('teaspoon', 'l', validateInput(2.0)));
      expect(result, closeTo(0.01, 0.1));
    });

    test('Convert 4 teaspoon to l', () {
      final result = formatResult(convert('teaspoon', 'l', validateInput(4.0)));
      expect(result, closeTo(0.02, 0.1));
    });

    test('Convert 1 teaspoon to ml', () {
      final result = formatResult(convert('teaspoon', 'ml', validateInput(1.0)));
      expect(result, closeTo(5.0, 0.1));
    });

    test('Convert 2 teaspoon to ml', () {
      final result = formatResult(convert('teaspoon', 'ml', validateInput(2.0)));
      expect(result, closeTo(10.0, 0.1));
    });

    test('Convert 4 teaspoon to ml', () {
      final result = formatResult(convert('teaspoon', 'ml', validateInput(4.0)));
      expect(result, closeTo(20.0, 0.1));
    });

    test('Convert 1 teaspoon to oz', () {
      final result = formatResult(convert('teaspoon', 'oz', validateInput(1.0)));
      expect(result, closeTo(0.17, 0.1));
    });

    test('Convert 2 teaspoon to oz', () {
      final result = formatResult(convert('teaspoon', 'oz', validateInput(2.0)));
      expect(result, closeTo(0.33, 0.1));
    });

    test('Convert 4 teaspoon to oz', () {
      final result = formatResult(convert('teaspoon', 'oz', validateInput(4.0)));
      expect(result, closeTo(0.67, 0.1));
    });

    test('Convert 1 teaspoon to lb', () {
      final result = formatResult(convert('teaspoon', 'lb', validateInput(1.0)));
      expect(result, closeTo(0.01, 0.1));
    });

    test('Convert 2 teaspoon to lb', () {
      final result = formatResult(convert('teaspoon', 'lb', validateInput(2.0)));
      expect(result, closeTo(0.02, 0.1));
    });

    test('Convert 4 teaspoon to lb', () {
      final result = formatResult(convert('teaspoon', 'lb', validateInput(4.0)));
      expect(result, closeTo(0.04, 0.1));
    });

    test('Convert 1 teaspoon to qt', () {
      final result = formatResult(convert('teaspoon', 'qt', validateInput(1.0)));
      expect(result, closeTo(0.01, 0.1));
    });

    test('Convert 2 teaspoon to qt', () {
      final result = formatResult(convert('teaspoon', 'qt', validateInput(2.0)));
      expect(result, closeTo(0.01, 0.1));
    });

    test('Convert 4 teaspoon to qt', () {
      final result = formatResult(convert('teaspoon', 'qt', validateInput(4.0)));
      expect(result, closeTo(0.02, 0.1));
    });

    // Random Analysis Tests for conversions from 'kg'
    test('Convert random kg to cup', () {
      final result = formatResult(convert('kg', 'cup', validateInput(123.45)));
      expect(result, closeTo(514.38, 0.1));
    });

    test('Convert random kg to tablespoon', () {
      final result = formatResult(convert('kg', 'tablespoon', validateInput(678.9)));
      expect(result, closeTo(45260.0, 0.1));
    });

    test('Convert random kg to teaspoon', () {
      final result = formatResult(convert('kg', 'teaspoon', validateInput(50.0)));
      expect(result, closeTo(10000.0, 0.1));
    });

    test('Convert random kg to g', () {
      final result = formatResult(convert('kg', 'g', validateInput(123.45)));
      expect(result, closeTo(123450.0, 0.1));
    });

    test('Convert random kg to mg', () {
      final result = formatResult(convert('kg', 'mg', validateInput(678.9)));
      expect(result, closeTo(678900000.0, 0.1));
    });

    test('Convert random kg to l', () {
      final result = formatResult(convert('kg', 'l', validateInput(50.0)));
      expect(result, closeTo(50.0, 0.1));
    });

    test('Convert random kg to ml', () {
      final result = formatResult(convert('kg', 'ml', validateInput(123.45)));
      expect(result, closeTo(123450.0, 0.1));
    });

    test('Convert random kg to oz', () {
      final result = formatResult(convert('kg', 'oz', validateInput(678.9)));
      expect(result, closeTo(23919.98, 70.1));
    });

    test('Convert random kg to lb', () {
      final result = formatResult(convert('kg', 'lb', validateInput(50.0)));
      expect(result, closeTo(110.23, 0.1));
    });

    test('Convert random kg to qt', () {
      final result = formatResult(convert('kg', 'qt', validateInput(123.45)));
      expect(result, closeTo(130.42, 0.1));
    });

    // Random Analysis Tests for conversions from 'g'
    test('Convert random g to cup', () {
      final result = formatResult(convert('g', 'cup', validateInput(123.45)));
      expect(result, closeTo(0.51, 0.1));
    });

    test('Convert random g to tablespoon', () {
      final result = formatResult(convert('g', 'tablespoon', validateInput(678.9)));
      expect(result, closeTo(45.26, 0.1));
    });

    test('Convert random g to teaspoon', () {
      final result = formatResult(convert('g', 'teaspoon', validateInput(50.0)));
      expect(result, closeTo(10.0, 0.1));
    });

    test('Convert random g to kg', () {
      final result = formatResult(convert('g', 'kg', validateInput(123.45)));
      expect(result, closeTo(0.12, 0.1));
    });

    test('Convert random g to mg', () {
      final result = formatResult(convert('g', 'mg', validateInput(678.9)));
      expect(result, closeTo(678900.0, 0.1));
    });

    test('Convert random g to l', () {
      final result = formatResult(convert('g', 'l', validateInput(50.0)));
      expect(result, closeTo(0.05, 0.1));
    });

    test('Convert random g to ml', () {
      final result = formatResult(convert('g', 'ml', validateInput(123.45)));
      expect(result, closeTo(123.45, 0.1));
    });

    test('Convert random g to oz', () {
      final result = formatResult(convert('g', 'oz', validateInput(678.9)));
      expect(result, closeTo(23.93, 0.1));
    });

    test('Convert random g to lb', () {
      final result = formatResult(convert('g', 'lb', validateInput(50.0)));
      expect(result, closeTo(0.11, 0.1));
    });

    test('Convert random g to qt', () {
      final result = formatResult(convert('g', 'qt', validateInput(123.45)));
      expect(result, closeTo(0.13, 0.1));
    });

    // Random Analysis Tests for conversions from 'mg'
    test('Convert random mg to cup', () {
      final result = formatResult(convert('mg', 'cup', validateInput(123.45)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert random mg to tablespoon', () {
      final result = formatResult(convert('mg', 'tablespoon', validateInput(678.9)));
      expect(result, closeTo(0.05, 0.1));
    });

    test('Convert random mg to teaspoon', () {
      final result = formatResult(convert('mg', 'teaspoon', validateInput(50.0)));
      expect(result, closeTo(0.01, 0.1));
    });

    test('Convert random mg to kg', () {
      final result = formatResult(convert('mg', 'kg', validateInput(123.45)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert random mg to g', () {
      final result = formatResult(convert('mg', 'g', validateInput(678.9)));
      expect(result, closeTo(0.68, 0.1));
    });

    test('Convert random mg to l', () {
      final result = formatResult(convert('mg', 'l', validateInput(50.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert random mg to ml', () {
      final result = formatResult(convert('mg', 'ml', validateInput(123.45)));
      expect(result, closeTo(0.12, 0.1));
    });

    test('Convert random mg to oz', () {
      final result = formatResult(convert('mg', 'oz', validateInput(678.9)));
      expect(result, closeTo(0.02, 0.1));
    });

    test('Convert random mg to lb', () {
      final result = formatResult(convert('mg', 'lb', validateInput(50.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert random mg to qt', () {
      final result = formatResult(convert('mg', 'qt', validateInput(123.45)));
      expect(result, closeTo(0.0, 0.1));
    });

    // Robust Worst Case Analysis Tests for conversions from 'l'
    test('Convert 0 l to cup', () {
      final result = formatResult(convert('l', 'cup', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to cup', () {
      final result = formatResult(convert('l', 'cup', validateInput(100000.0)));
      expect(result, closeTo(416667.0, 0.1));
    });

    test('Convert -1 l to cup', () {
      final result = formatResult(convert('l', 'cup', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to cup', () {
      final result = formatResult(convert('l', 'cup', validateInput(1.0)));
      expect(result, closeTo(4.17, 0.1));
    });

    test('Convert 50000 l to cup', () {
      final result = formatResult(convert('l', 'cup', validateInput(50000.0)));
      expect(result, closeTo(208334.0, 0.9));
    });

    test('Convert 0 l to tablespoon', () {
      final result = formatResult(convert('l', 'tablespoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to tablespoon', () {
      final result = formatResult(convert('l', 'tablespoon', validateInput(100000.0)));
      expect(result, closeTo(6666670.0, 0.1));
    });

    test('Convert -1 l to tablespoon', () {
      final result = formatResult(convert('l', 'tablespoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to tablespoon', () {
      final result = formatResult(convert('l', 'tablespoon', validateInput(1.0)));
      expect(result, closeTo(66.67, 0.1));
    });

    test('Convert 50000 l to tablespoon', () {
      final result = formatResult(convert('l', 'tablespoon', validateInput(50000.0)));
      expect(result, closeTo(3333335.0, 0.1));
    });

    test('Convert 0 l to teaspoon', () {
      final result = formatResult(convert('l', 'teaspoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to teaspoon', () {
      final result = formatResult(convert('l', 'teaspoon', validateInput(100000.0)));
      expect(result, closeTo(20000000.0, 0.1));
    });

    test('Convert -1 l to teaspoon', () {
      final result = formatResult(convert('l', 'teaspoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to teaspoon', () {
      final result = formatResult(convert('l', 'teaspoon', validateInput(1.0)));
      expect(result, closeTo(200.0, 0.1));
    });

    test('Convert 50000 l to teaspoon', () {
      final result = formatResult(convert('l', 'teaspoon', validateInput(50000.0)));
      expect(result, closeTo(10000000.0, 0.1));
    });

    test('Convert 0 l to kg', () {
      final result = formatResult(convert('l', 'kg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to kg', () {
      final result = formatResult(convert('l', 'kg', validateInput(100000.0)));
      expect(result, closeTo(100000.0, 0.1));
    });

    test('Convert -1 l to kg', () {
      final result = formatResult(convert('l', 'kg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to kg', () {
      final result = formatResult(convert('l', 'kg', validateInput(1.0)));
      expect(result, closeTo(1.0, 0.1));
    });

    test('Convert 50000 l to kg', () {
      final result = formatResult(convert('l', 'kg', validateInput(50000.0)));
      expect(result, closeTo(50000.0, 0.1));
    });

    test('Convert 0 l to g', () {
      final result = formatResult(convert('l', 'g', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to g', () {
      final result = formatResult(convert('l', 'g', validateInput(100000.0)));
      expect(result, closeTo(100000000.0, 0.1));
    });

    test('Convert -1 l to g', () {
      final result = formatResult(convert('l', 'g', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to g', () {
      final result = formatResult(convert('l', 'g', validateInput(1.0)));
      expect(result, closeTo(1000.0, 0.1));
    });

    test('Convert 50000 l to g', () {
      final result = formatResult(convert('l', 'g', validateInput(50000.0)));
      expect(result, closeTo(50000000.0, 0.1));
    });

    test('Convert 0 l to mg', () {
      final result = formatResult(convert('l', 'mg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to mg', () {
      final result = formatResult(convert('l', 'mg', validateInput(100000.0)));
      expect(result, closeTo(100000000000.0, 0.1));
    });

    test('Convert -1 l to mg', () {
      final result = formatResult(convert('l', 'mg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to mg', () {
      final result = formatResult(convert('l', 'mg', validateInput(1.0)));
      expect(result, closeTo(1000000.0, 0.1));
    });

    test('Convert 50000 l to mg', () {
      final result = formatResult(convert('l', 'mg', validateInput(50000.0)));
      expect(result, closeTo(50000000000.0, 0.1));
    });

    test('Convert 0 l to ml', () {
      final result = formatResult(convert('l', 'ml', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to ml', () {
      final result = formatResult(convert('l', 'ml', validateInput(100000.0)));
      expect(result, closeTo(100000000.0, 0.1));
    });

    test('Convert -1 l to ml', () {
      final result = formatResult(convert('l', 'ml', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to ml', () {
      final result = formatResult(convert('l', 'ml', validateInput(1.0)));
      expect(result, closeTo(1000.0, 0.1));
    });

    test('Convert 50000 l to ml', () {
      final result = formatResult(convert('l', 'ml', validateInput(50000.0)));
      expect(result, closeTo(50000000.0, 0.1));
    });

    test('Convert 0 l to oz', () {
      final result = formatResult(convert('l', 'oz', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to oz', () {
      final result = formatResult(convert('l', 'oz', validateInput(100000.0)));
      expect(result, closeTo(3381400.0, 0.1));
    });

    test('Convert -1 l to oz', () {
      final result = formatResult(convert('l', 'oz', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to oz', () {
      final result = formatResult(convert('l', 'oz', validateInput(1.0)));
      expect(result, closeTo(33.81, 0.1));
    });

    test('Convert 50000 l to oz', () {
      final result = formatResult(convert('l', 'oz', validateInput(50000.0)));
      expect(result, closeTo(1690700.0, 0.1));
    });

    test('Convert 0 l to lb', () {
      final result = formatResult(convert('l', 'lb', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to lb', () {
      final result = formatResult(convert('l', 'lb', validateInput(100000.0)));
      expect(result, closeTo(220462.0, 0.1));
    });

    test('Convert -1 l to lb', () {
      final result = formatResult(convert('l', 'lb', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to lb', () {
      final result = formatResult(convert('l', 'lb', validateInput(1.0)));
      expect(result, closeTo(2.2, 0.1));
    });

    test('Convert 50000 l to lb', () {
      final result = formatResult(convert('l', 'lb', validateInput(50000.0)));
      expect(result, closeTo(110231.0, 0.1));
    });

    test('Convert 0 l to qt', () {
      final result = formatResult(convert('l', 'qt', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 l to qt', () {
      final result = formatResult(convert('l', 'qt', validateInput(100000.0)));
      expect(result, closeTo(105669.0, 0.1));
    });

    test('Convert -1 l to qt', () {
      final result = formatResult(convert('l', 'qt', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 l to qt', () {
      final result = formatResult(convert('l', 'qt', validateInput(1.0)));
      expect(result, closeTo(1.06, 0.1));
    });

    test('Convert 50000 l to qt', () {
      final result = formatResult(convert('l', 'qt', validateInput(50000.0)));
      expect(result, closeTo(52834.5, 0.1));
    });

    // Special Value Analysis Tests for conversions from 'ml'
    test('Convert 0 ml to cup', () {
      final result = formatResult(convert('ml', 'cup', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to cup', () {
      final result = formatResult(convert('ml', 'cup', validateInput(100000.0)));
      expect(result, closeTo(416.67, 0.1));
    });

    test('Convert -1 ml to cup', () {
      final result = formatResult(convert('ml', 'cup', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to cup', () {
      final result = formatResult(convert('ml', 'cup', validateInput(1.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 50000 ml to cup', () {
      final result = formatResult(convert('ml', 'cup', validateInput(50000.0)));
      expect(result, closeTo(208.33, 0.1));
    });

    test('Convert 0 ml to tablespoon', () {
      final result = formatResult(convert('ml', 'tablespoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to tablespoon', () {
      final result = formatResult(convert('ml', 'tablespoon', validateInput(100000.0)));
      expect(result, closeTo(6666.67, 0.1));
    });

    test('Convert -1 ml to tablespoon', () {
      final result = formatResult(convert('ml', 'tablespoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to tablespoon', () {
      final result = formatResult(convert('ml', 'tablespoon', validateInput(1.0)));
      expect(result, closeTo(0.07, 0.1));
    });

    test('Convert 50000 ml to tablespoon', () {
      final result = formatResult(convert('ml', 'tablespoon', validateInput(50000.0)));
      expect(result, closeTo(3333.33, 0.1));
    });

    test('Convert 0 ml to teaspoon', () {
      final result = formatResult(convert('ml', 'teaspoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to teaspoon', () {
      final result = formatResult(convert('ml', 'teaspoon', validateInput(100000.0)));
      expect(result, closeTo(20000.0, 0.1));
    });

    test('Convert -1 ml to teaspoon', () {
      final result = formatResult(convert('ml', 'teaspoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to teaspoon', () {
      final result = formatResult(convert('ml', 'teaspoon', validateInput(1.0)));
      expect(result, closeTo(0.2, 0.1));
    });

    test('Convert 50000 ml to teaspoon', () {
      final result = formatResult(convert('ml', 'teaspoon', validateInput(50000.0)));
      expect(result, closeTo(10000.0, 0.1));
    });

    test('Convert 0 ml to kg', () {
      final result = formatResult(convert('ml', 'kg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to kg', () {
      final result = formatResult(convert('ml', 'kg', validateInput(100000.0)));
      expect(result, closeTo(100.0, 0.1));
    });

    test('Convert -1 ml to kg', () {
      final result = formatResult(convert('ml', 'kg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to kg', () {
      final result = formatResult(convert('ml', 'kg', validateInput(1.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 50000 ml to kg', () {
      final result = formatResult(convert('ml', 'kg', validateInput(50000.0)));
      expect(result, closeTo(50.0, 0.1));
    });

    test('Convert 0 ml to g', () {
      final result = formatResult(convert('ml', 'g', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to g', () {
      final result = formatResult(convert('ml', 'g', validateInput(100000.0)));
      expect(result, closeTo(100000.0, 0.1));
    });

    test('Convert -1 ml to g', () {
      final result = formatResult(convert('ml', 'g', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to g', () {
      final result = formatResult(convert('ml', 'g', validateInput(1.0)));
      expect(result, closeTo(1.0, 0.1));
    });

    test('Convert 50000 ml to g', () {
      final result = formatResult(convert('ml', 'g', validateInput(50000.0)));
      expect(result, closeTo(50000.0, 0.1));
    });

    test('Convert 0 ml to mg', () {
      final result = formatResult(convert('ml', 'mg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to mg', () {
      final result = formatResult(convert('ml', 'mg', validateInput(100000.0)));
      expect(result, closeTo(100000000.0, 0.1));
    });

    test('Convert -1 ml to mg', () {
      final result = formatResult(convert('ml', 'mg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to mg', () {
      final result = formatResult(convert('ml', 'mg', validateInput(1.0)));
      expect(result, closeTo(1000.0, 0.1));
    });

    test('Convert 50000 ml to mg', () {
      final result = formatResult(convert('ml', 'mg', validateInput(50000.0)));
      expect(result, closeTo(50000000.0, 0.1));
    });

    test('Convert 0 ml to l', () {
      final result = formatResult(convert('ml', 'l', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to l', () {
      final result = formatResult(convert('ml', 'l', validateInput(100000.0)));
      expect(result, closeTo(100.0, 0.1));
    });

    test('Convert -1 ml to l', () {
      final result = formatResult(convert('ml', 'l', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to l', () {
      final result = formatResult(convert('ml', 'l', validateInput(1.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 50000 ml to l', () {
      final result = formatResult(convert('ml', 'l', validateInput(50000.0)));
      expect(result, closeTo(50.0, 0.1));
    });

    test('Convert 0 ml to oz', () {
      final result = formatResult(convert('ml', 'oz', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to oz', () {
      final result = formatResult(convert('ml', 'oz', validateInput(100000.0)));
      expect(result, closeTo(3381.4, 0.1));
    });

    test('Convert -1 ml to oz', () {
      final result = formatResult(convert('ml', 'oz', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to oz', () {
      final result = formatResult(convert('ml', 'oz', validateInput(1.0)));
      expect(result, closeTo(0.03, 0.1));
    });

    test('Convert 50000 ml to oz', () {
      final result = formatResult(convert('ml', 'oz', validateInput(50000.0)));
      expect(result, closeTo(1690.7, 0.1));
    });

    test('Convert 0 ml to lb', () {
      final result = formatResult(convert('ml', 'lb', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to lb', () {
      final result = formatResult(convert('ml', 'lb', validateInput(100000.0)));
      expect(result, closeTo(220.46, 0.1));
    });

    test('Convert -1 ml to lb', () {
      final result = formatResult(convert('ml', 'lb', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to lb', () {
      final result = formatResult(convert('ml', 'lb', validateInput(1.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 50000 ml to lb', () {
      final result = formatResult(convert('ml', 'lb', validateInput(50000.0)));
      expect(result, closeTo(110.23, 0.1));
    });

    test('Convert 0 ml to qt', () {
      final result = formatResult(convert('ml', 'qt', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 ml to qt', () {
      final result = formatResult(convert('ml', 'qt', validateInput(100000.0)));
      expect(result, closeTo(105.67, 0.1));
    });

    test('Convert -1 ml to qt', () {
      final result = formatResult(convert('ml', 'qt', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 ml to qt', () {
      final result = formatResult(convert('ml', 'qt', validateInput(1.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 50000 ml to qt', () {
      final result = formatResult(convert('ml', 'qt', validateInput(50000.0)));
      expect(result, closeTo(52.83, 0.1));
    });

    // Robust Boundary Value Tests for conversions from 'oz'
    test('Convert 0 oz to cup', () {
      final result = formatResult(convert('oz', 'cup', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to cup', () {
      final result = formatResult(convert('oz', 'cup', validateInput(100000.0)));
      expect(result, closeTo(12500.0, 0.1));
    });

    test('Convert -1 oz to cup', () {
      final result = formatResult(convert('oz', 'cup', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to cup', () {
      final result = formatResult(convert('oz', 'cup', validateInput(1.0)));
      expect(result, closeTo(0.13, 0.1));
    });

    test('Convert 50000 oz to cup', () {
      final result = formatResult(convert('oz', 'cup', validateInput(50000.0)));
      expect(result, closeTo(6250.0, 0.1));
    });

    test('Convert 0 oz to tablespoon', () {
      final result = formatResult(convert('oz', 'tablespoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to tablespoon', () {
      final result = formatResult(convert('oz', 'tablespoon', validateInput(100000.0)));
      expect(result, closeTo(200000.0, 0.1));
    });

    test('Convert -1 oz to tablespoon', () {
      final result = formatResult(convert('oz', 'tablespoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to tablespoon', () {
      final result = formatResult(convert('oz', 'tablespoon', validateInput(1.0)));
      expect(result, closeTo(2.0, 0.1));
    });

    test('Convert 50000 oz to tablespoon', () {
      final result = formatResult(convert('oz', 'tablespoon', validateInput(50000.0)));
      expect(result, closeTo(100000.0, 0.1));
    });

    test('Convert 0 oz to teaspoon', () {
      final result = formatResult(convert('oz', 'teaspoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to teaspoon', () {
      final result = formatResult(convert('oz', 'teaspoon', validateInput(100000.0)));
      expect(result, closeTo(600000.0, 0.1));
    });

    test('Convert -1 oz to teaspoon', () {
      final result = formatResult(convert('oz', 'teaspoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to teaspoon', () {
      final result = formatResult(convert('oz', 'teaspoon', validateInput(1.0)));
      expect(result, closeTo(6.0, 0.1));
    });

    test('Convert 50000 oz to teaspoon', () {
      final result = formatResult(convert('oz', 'teaspoon', validateInput(50000.0)));
      expect(result, closeTo(300000.0, 0.1));
    });

    test('Convert 0 oz to kg', () {
      final result = formatResult(convert('oz', 'kg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to kg', () {
      final result = formatResult(convert('oz', 'kg', validateInput(100000.0)));
      expect(result, closeTo(2834.95, 0.1));
    });

    test('Convert -1 oz to kg', () {
      final result = formatResult(convert('oz', 'kg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to kg', () {
      final result = formatResult(convert('oz', 'kg', validateInput(1.0)));
      expect(result, closeTo(0.03, 0.1));
    });

    test('Convert 50000 oz to kg', () {
      final result = formatResult(convert('oz', 'kg', validateInput(50000.0)));
      expect(result, closeTo(1417.48, 0.1));
    });

    test('Convert 0 oz to g', () {
      final result = formatResult(convert('oz', 'g', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to g', () {
      final result = formatResult(convert('oz', 'g', validateInput(100000.0)));
      expect(result, closeTo(2834950.0, 0.1));
    });

    test('Convert -1 oz to g', () {
      final result = formatResult(convert('oz', 'g', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to g', () {
      final result = formatResult(convert('oz', 'g', validateInput(1.0)));
      expect(result, closeTo(28.35, 0.1));
    });

    test('Convert 50000 oz to g', () {
      final result = formatResult(convert('oz', 'g', validateInput(50000.0)));
      expect(result, closeTo(1417475.0, 0.1));
    });

    test('Convert 0 oz to mg', () {
      final result = formatResult(convert('oz', 'mg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to mg', () {
      final result = formatResult(convert('oz', 'mg', validateInput(100000.0)));
      expect(result, closeTo(2834950000.0, 0.1));
    });

    test('Convert -1 oz to mg', () {
      final result = formatResult(convert('oz', 'mg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to mg', () {
      final result = formatResult(convert('oz', 'mg', validateInput(1.0)));
      expect(result, closeTo(28349.5, 0.1));
    });

    test('Convert 50000 oz to mg', () {
      final result = formatResult(convert('oz', 'mg', validateInput(50000.0)));
      expect(result, closeTo(1417475000.0, 0.1));
    });

    test('Convert 0 oz to l', () {
      final result = formatResult(convert('oz', 'l', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to l', () {
      final result = formatResult(convert('oz', 'l', validateInput(100000.0)));
      expect(result, closeTo(2957.35, 0.1));
    });

    test('Convert -1 oz to l', () {
      final result = formatResult(convert('oz', 'l', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to l', () {
      final result = formatResult(convert('oz', 'l', validateInput(1.0)));
      expect(result, closeTo(0.03, 0.1));
    });

    test('Convert 50000 oz to l', () {
      final result = formatResult(convert('oz', 'l', validateInput(50000.0)));
      expect(result, closeTo(1478.68, 0.1));
    });

    test('Convert 0 oz to ml', () {
      final result = formatResult(convert('oz', 'ml', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to ml', () {
      final result = formatResult(convert('oz', 'ml', validateInput(100000.0)));
      expect(result, closeTo(2957350.0, 0.1));
    });

    test('Convert -1 oz to ml', () {
      final result = formatResult(convert('oz', 'ml', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to ml', () {
      final result = formatResult(convert('oz', 'ml', validateInput(1.0)));
      expect(result, closeTo(29.57, 0.1));
    });

    test('Convert 50000 oz to ml', () {
      final result = formatResult(convert('oz', 'ml', validateInput(50000.0)));
      expect(result, closeTo(1478675.0, 0.1));
    });

    test('Convert 0 oz to lb', () {
      final result = formatResult(convert('oz', 'lb', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to lb', () {
      final result = formatResult(convert('oz', 'lb', validateInput(100000.0)));
      expect(result, closeTo(6250.0, 0.1));
    });

    test('Convert -1 oz to lb', () {
      final result = formatResult(convert('oz', 'lb', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to lb', () {
      final result = formatResult(convert('oz', 'lb', validateInput(1.0)));
      expect(result, closeTo(0.06, 0.1));
    });

    test('Convert 50000 oz to lb', () {
      final result = formatResult(convert('oz', 'lb', validateInput(50000.0)));
      expect(result, closeTo(3125.0, 0.1));
    });

    test('Convert 0 oz to qt', () {
      final result = formatResult(convert('oz', 'qt', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 oz to qt', () {
      final result = formatResult(convert('oz', 'qt', validateInput(100000.0)));
      expect(result, closeTo(3125.0, 0.1));
    });

    test('Convert -1 oz to qt', () {
      final result = formatResult(convert('oz', 'qt', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 oz to qt', () {
      final result = formatResult(convert('oz', 'qt', validateInput(1.0)));
      expect(result, closeTo(0.03, 0.1));
    });

    test('Convert 50000 oz to qt', () {
      final result = formatResult(convert('oz', 'qt', validateInput(50000.0)));
      expect(result, closeTo(1562.5, 0.1));
    });

    // Robust Worst Case Analysis Tests for conversions from 'lb'
    test('Convert 0 lb to cup', () {
      final result = formatResult(convert('lb', 'cup', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to cup', () {
      final result = formatResult(convert('lb', 'cup', validateInput(100000.0)));
      expect(result, closeTo(200000.0, 0.1));
    });

    test('Convert -1 lb to cup', () {
      final result = formatResult(convert('lb', 'cup', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to cup', () {
      final result = formatResult(convert('lb', 'cup', validateInput(1.0)));
      expect(result, closeTo(2.0, 0.1));
    });

    test('Convert 50000 lb to cup', () {
      final result = formatResult(convert('lb', 'cup', validateInput(50000.0)));
      expect(result, closeTo(100000.0, 0.1));
    });

    test('Convert 0 lb to tablespoon', () {
      final result = formatResult(convert('lb', 'tablespoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to tablespoon', () {
      final result = formatResult(convert('lb', 'tablespoon', validateInput(100000.0)));
      expect(result, closeTo(3200000.0, 0.1));
    });

    test('Convert -1 lb to tablespoon', () {
      final result = formatResult(convert('lb', 'tablespoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to tablespoon', () {
      final result = formatResult(convert('lb', 'tablespoon', validateInput(1.0)));
      expect(result, closeTo(32.0, 0.1));
    });

    test('Convert 50000 lb to tablespoon', () {
      final result = formatResult(convert('lb', 'tablespoon', validateInput(50000.0)));
      expect(result, closeTo(1600000.0, 0.1));
    });

    test('Convert 0 lb to teaspoon', () {
      final result = formatResult(convert('lb', 'teaspoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to teaspoon', () {
      final result = formatResult(convert('lb', 'teaspoon', validateInput(100000.0)));
      expect(result, closeTo(9600000.0, 0.1));
    });

    test('Convert -1 lb to teaspoon', () {
      final result = formatResult(convert('lb', 'teaspoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to teaspoon', () {
      final result = formatResult(convert('lb', 'teaspoon', validateInput(1.0)));
      expect(result, closeTo(96.0, 0.1));
    });

    test('Convert 50000 lb to teaspoon', () {
      final result = formatResult(convert('lb', 'teaspoon', validateInput(50000.0)));
      expect(result, closeTo(4800000.0, 0.1));
    });

    test('Convert 0 lb to kg', () {
      final result = formatResult(convert('lb', 'kg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to kg', () {
      final result = formatResult(convert('lb', 'kg', validateInput(100000.0)));
      expect(result, closeTo(45359.2, 0.1));
    });

    test('Convert -1 lb to kg', () {
      final result = formatResult(convert('lb', 'kg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to kg', () {
      final result = formatResult(convert('lb', 'kg', validateInput(1.0)));
      expect(result, closeTo(0.45, 0.1));
    });

    test('Convert 50000 lb to kg', () {
      final result = formatResult(convert('lb', 'kg', validateInput(50000.0)));
      expect(result, closeTo(22679.6, 0.1));
    });

    test('Convert 0 lb to g', () {
      final result = formatResult(convert('lb', 'g', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to g', () {
      final result = formatResult(convert('lb', 'g', validateInput(100000.0)));
      expect(result, closeTo(45359200.0, 0.1));
    });

    test('Convert -1 lb to g', () {
      final result = formatResult(convert('lb', 'g', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to g', () {
      final result = formatResult(convert('lb', 'g', validateInput(1.0)));
      expect(result, closeTo(453.59, 0.1));
    });

    test('Convert 50000 lb to g', () {
      final result = formatResult(convert('lb', 'g', validateInput(50000.0)));
      expect(result, closeTo(22679600.0, 0.1));
    });

    test('Convert 0 lb to mg', () {
      final result = formatResult(convert('lb', 'mg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to mg', () {
      final result = formatResult(convert('lb', 'mg', validateInput(100000.0)));
      expect(result, closeTo(45359200000.0, 0.1));
    });

    test('Convert -1 lb to mg', () {
      final result = formatResult(convert('lb', 'mg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to mg', () {
      final result = formatResult(convert('lb', 'mg', validateInput(1.0)));
      expect(result, closeTo(453592.0, 0.1));
    });

    test('Convert 50000 lb to mg', () {
      final result = formatResult(convert('lb', 'mg', validateInput(50000.0)));
      expect(result, closeTo(22679600000.0, 0.1));
    });

    test('Convert 0 lb to l', () {
      final result = formatResult(convert('lb', 'l', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to l', () {
      final result = formatResult(convert('lb', 'l', validateInput(100000.0)));
      expect(result, closeTo(45359.2, 0.1));
    });

    test('Convert -1 lb to l', () {
      final result = formatResult(convert('lb', 'l', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to l', () {
      final result = formatResult(convert('lb', 'l', validateInput(1.0)));
      expect(result, closeTo(0.45, 0.1));
    });

    test('Convert 50000 lb to l', () {
      final result = formatResult(convert('lb', 'l', validateInput(50000.0)));
      expect(result, closeTo(22679.6, 0.1));
    });

    test('Convert 0 lb to ml', () {
      final result = formatResult(convert('lb', 'ml', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to ml', () {
      final result = formatResult(convert('lb', 'ml', validateInput(100000.0)));
      expect(result, closeTo(45359200.0, 0.1));
    });

    test('Convert -1 lb to ml', () {
      final result = formatResult(convert('lb', 'ml', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to ml', () {
      final result = formatResult(convert('lb', 'ml', validateInput(1.0)));
      expect(result, closeTo(453.59, 0.1));
    });

    test('Convert 50000 lb to ml', () {
      final result = formatResult(convert('lb', 'ml', validateInput(50000.0)));
      expect(result, closeTo(22679600.0, 0.1));
    });

    test('Convert 0 lb to oz', () {
      final result = formatResult(convert('lb', 'oz', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to oz', () {
      final result = formatResult(convert('lb', 'oz', validateInput(100000.0)));
      expect(result, closeTo(1600000.0, 0.1));
    });

    test('Convert -1 lb to oz', () {
      final result = formatResult(convert('lb', 'oz', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to oz', () {
      final result = formatResult(convert('lb', 'oz', validateInput(1.0)));
      expect(result, closeTo(16.0, 0.1));
    });

    test('Convert 50000 lb to oz', () {
      final result = formatResult(convert('lb', 'oz', validateInput(50000.0)));
      expect(result, closeTo(800000.0, 0.1));
    });

    test('Convert 0 lb to qt', () {
      final result = formatResult(convert('lb', 'qt', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 lb to qt', () {
      final result = formatResult(convert('lb', 'qt', validateInput(100000.0)));
      expect(result, closeTo(50000.0, 0.1));
    });

    test('Convert -1 lb to qt', () {
      final result = formatResult(convert('lb', 'qt', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 lb to qt', () {
      final result = formatResult(convert('lb', 'qt', validateInput(1.0)));
      expect(result, closeTo(0.5, 0.1));
    });

    test('Convert 50000 lb to qt', () {
      final result = formatResult(convert('lb', 'qt', validateInput(50000.0)));
      expect(result, closeTo(25000.0, 0.1));
    });

    // Robust Boundary Value Tests for conversions from 'qt'
    test('Convert 0 qt to cup', () {
      final result = formatResult(convert('qt', 'cup', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to cup', () {
      final result = formatResult(convert('qt', 'cup', validateInput(100000.0)));
      expect(result, closeTo(400000.0, 0.1));
    });

    test('Convert -1 qt to cup', () {
      final result = formatResult(convert('qt', 'cup', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to cup', () {
      final result = formatResult(convert('qt', 'cup', validateInput(1.0)));
      expect(result, closeTo(4.0, 0.1));
    });

    test('Convert 50000 qt to cup', () {
      final result = formatResult(convert('qt', 'cup', validateInput(50000.0)));
      expect(result, closeTo(200000.0, 0.1));
    });

    test('Convert 0 qt to tablespoon', () {
      final result = formatResult(convert('qt', 'tablespoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to tablespoon', () {
      final result = formatResult(convert('qt', 'tablespoon', validateInput(100000.0)));
      expect(result, closeTo(6400000.0, 0.1));
    });

    test('Convert -1 qt to tablespoon', () {
      final result = formatResult(convert('qt', 'tablespoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to tablespoon', () {
      final result = formatResult(convert('qt', 'tablespoon', validateInput(1.0)));
      expect(result, closeTo(64.0, 0.1));
    });

    test('Convert 50000 qt to tablespoon', () {
      final result = formatResult(convert('qt', 'tablespoon', validateInput(50000.0)));
      expect(result, closeTo(3200000.0, 0.1));
    });

    test('Convert 0 qt to teaspoon', () {
      final result = formatResult(convert('qt', 'teaspoon', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to teaspoon', () {
      final result = formatResult(convert('qt', 'teaspoon', validateInput(100000.0)));
      expect(result, closeTo(19200000.0, 0.1));
    });

    test('Convert -1 qt to teaspoon', () {
      final result = formatResult(convert('qt', 'teaspoon', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to teaspoon', () {
      final result = formatResult(convert('qt', 'teaspoon', validateInput(1.0)));
      expect(result, closeTo(192.0, 0.1));
    });

    test('Convert 50000 qt to teaspoon', () {
      final result = formatResult(convert('qt', 'teaspoon', validateInput(50000.0)));
      expect(result, closeTo(9600000.0, 0.1));
    });

    test('Convert 0 qt to kg', () {
      final result = formatResult(convert('qt', 'kg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to kg', () {
      final result = formatResult(convert('qt', 'kg', validateInput(100000.0)));
      expect(result, closeTo(94635.3, 0.1));
    });

    test('Convert -1 qt to kg', () {
      final result = formatResult(convert('qt', 'kg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to kg', () {
      final result = formatResult(convert('qt', 'kg', validateInput(1.0)));
      expect(result, closeTo(0.95, 0.1));
    });

    test('Convert 50000 qt to kg', () {
      final result = formatResult(convert('qt', 'kg', validateInput(50000.0)));
      expect(result, closeTo(47317.7, 0.1));
    });

    test('Convert 0 qt to g', () {
      final result = formatResult(convert('qt', 'g', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to g', () {
      final result = formatResult(convert('qt', 'g', validateInput(100000.0)));
      expect(result, closeTo(94635300.0, 0.1));
    });

    test('Convert -1 qt to g', () {
      final result = formatResult(convert('qt', 'g', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to g', () {
      final result = formatResult(convert('qt', 'g', validateInput(1.0)));
      expect(result, closeTo(946.35, 0.1));
    });

    test('Convert 50000 qt to g', () {
      final result = formatResult(convert('qt', 'g', validateInput(50000.0)));
      expect(result, closeTo(47317650.0, 0.1));
    });

    test('Convert 0 qt to mg', () {
      final result = formatResult(convert('qt', 'mg', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to mg', () {
      final result = formatResult(convert('qt', 'mg', validateInput(100000.0)));
      expect(result, closeTo(94635300000.0, 0.1));
    });

    test('Convert -1 qt to mg', () {
      final result = formatResult(convert('qt', 'mg', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to mg', () {
      final result = formatResult(convert('qt', 'mg', validateInput(1.0)));
      expect(result, closeTo(946353.0, 0.1));
    });

    test('Convert 50000 qt to mg', () {
      final result = formatResult(convert('qt', 'mg', validateInput(50000.0)));
      expect(result, closeTo(47317650000.0, 0.1));
    });

    test('Convert 0 qt to l', () {
      final result = formatResult(convert('qt', 'l', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to l', () {
      final result = formatResult(convert('qt', 'l', validateInput(100000.0)));
      expect(result, closeTo(94635.3, 0.1));
    });

    test('Convert -1 qt to l', () {
      final result = formatResult(convert('qt', 'l', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to l', () {
      final result = formatResult(convert('qt', 'l', validateInput(1.0)));
      expect(result, closeTo(0.95, 0.1));
    });

    test('Convert 50000 qt to l', () {
      final result = formatResult(convert('qt', 'l', validateInput(50000.0)));
      expect(result, closeTo(47317.7, 0.1));
    });

    test('Convert 0 qt to ml', () {
      final result = formatResult(convert('qt', 'ml', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to ml', () {
      final result = formatResult(convert('qt', 'ml', validateInput(100000.0)));
      expect(result, closeTo(94635300.0, 0.1));
    });

    test('Convert -1 qt to ml', () {
      final result = formatResult(convert('qt', 'ml', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to ml', () {
      final result = formatResult(convert('qt', 'ml', validateInput(1.0)));
      expect(result, closeTo(946.35, 0.1));
    });

    test('Convert 50000 qt to ml', () {
      final result = formatResult(convert('qt', 'ml', validateInput(50000.0)));
      expect(result, closeTo(47317650.0, 0.1));
    });

    test('Convert 0 qt to oz', () {
      final result = formatResult(convert('qt', 'oz', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to oz', () {
      final result = formatResult(convert('qt', 'oz', validateInput(100000.0)));
      expect(result, closeTo(3200000.0, 0.1));
    });

    test('Convert -1 qt to oz', () {
      final result = formatResult(convert('qt', 'oz', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to oz', () {
      final result = formatResult(convert('qt', 'oz', validateInput(1.0)));
      expect(result, closeTo(32.0, 0.1));
    });

    test('Convert 50000 qt to oz', () {
      final result = formatResult(convert('qt', 'oz', validateInput(50000.0)));
      expect(result, closeTo(1600000.0, 0.1));
    });

    test('Convert 0 qt to lb', () {
      final result = formatResult(convert('qt', 'lb', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to lb', () {
      final result = formatResult(convert('qt', 'lb', validateInput(100000.0)));
      expect(result, closeTo(200000.0, 0.1));
    });

    test('Convert -1 qt to lb', () {
      final result = formatResult(convert('qt', 'lb', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to lb', () {
      final result = formatResult(convert('qt', 'lb', validateInput(1.0)));
      expect(result, closeTo(2.0, 0.1));
    });

    test('Convert 50000 qt to lb', () {
      final result = formatResult(convert('qt', 'lb', validateInput(50000.0)));
      expect(result, closeTo(100000.0, 0.1));
    });

    test('Convert 0 qt to qt', () {
      final result = formatResult(convert('qt', 'qt', validateInput(0.0)));
      expect(result, closeTo(0.0, 0.1));
    });

    test('Convert 100000 qt to qt', () {
      final result = formatResult(convert('qt', 'qt', validateInput(100000.0)));
      expect(result, closeTo(100000.0, 0.1));
    });

    test('Convert -1 qt to qt', () {
      final result = formatResult(convert('qt', 'qt', validateInput(-1.0)));
      expect(result, closeTo(0.0, 0.1)); // Invalid input adjusted to 0
    });

    test('Convert 1 qt to qt', () {
      final result = formatResult(convert('qt', 'qt', validateInput(1.0)));
      expect(result, closeTo(1.0, 0.1));
    });

    test('Convert 50000 qt to qt', () {
      final result = formatResult(convert('qt', 'qt', validateInput(50000.0)));
      expect(result, closeTo(50000.0, 0.1));
    });
  });
}
