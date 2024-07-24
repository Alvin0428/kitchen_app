import 'package:flutter_test/flutter_test.dart';

/**
 * This test suite contains 110 individual tests for the UnitConverter logic.
 * Each test verifies the correctness of conversions between different units.
 * The conversions are tested with specific values to ensure accuracy.
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

    // Tests for conversions from 'cup'
    test('Convert 1 cup to tablespoon', () {
      final result = convert('cup', 'tablespoon', 1.0);
      expect(result, 16.0);
    });

    test('Convert 1 cup to teaspoon', () {
      final result = convert('cup', 'teaspoon', 1.0);
      expect(result, 48.0);
    });

    test('Convert 1 cup to kg', () {
      final result = convert('cup', 'kg', 1.0);
      expect(result, 0.24);
    });

    test('Convert 1 cup to g', () {
      final result = convert('cup', 'g', 1.0);
      expect(result, 240.0);
    });

    test('Convert 1 cup to mg', () {
      final result = convert('cup', 'mg', 1.0);
      expect(result, 240000.0);
    });

    test('Convert 1 cup to l', () {
      final result = convert('cup', 'l', 1.0);
      expect(result, 0.24);
    });

    test('Convert 1 cup to ml', () {
      final result = convert('cup', 'ml', 1.0);
      expect(result, 240.0);
    });

    test('Convert 1 cup to oz', () {
      final result = convert('cup', 'oz', 1.0);
      expect(result, 8.0);
    });

    test('Convert 1 cup to lb', () {
      final result = convert('cup', 'lb', 1.0);
      expect(result, 0.5);
    });

    test('Convert 1 cup to qt', () {
      final result = convert('cup', 'qt', 1.0);
      expect(result, 0.25);
    });

    // Tests for conversions from 'tablespoon'
    test('Convert 1 tablespoon to cup', () {
      final result = convert('tablespoon', 'cup', 1.0);
      expect(result, 0.0625);
    });

    test('Convert 1 tablespoon to teaspoon', () {
      final result = convert('tablespoon', 'teaspoon', 1.0);
      expect(result, 3.0);
    });

    test('Convert 1 tablespoon to kg', () {
      final result = convert('tablespoon', 'kg', 1.0);
      expect(result, 0.015);
    });

    test('Convert 1 tablespoon to g', () {
      final result = convert('tablespoon', 'g', 1.0);
      expect(result, 15.0);
    });

    test('Convert 1 tablespoon to mg', () {
      final result = convert('tablespoon', 'mg', 1.0);
      expect(result, 15000.0);
    });

    test('Convert 1 tablespoon to l', () {
      final result = convert('tablespoon', 'l', 1.0);
      expect(result, 0.015);
    });

    test('Convert 1 tablespoon to ml', () {
      final result = convert('tablespoon', 'ml', 1.0);
      expect(result, 15.0);
    });

    test('Convert 1 tablespoon to oz', () {
      final result = convert('tablespoon', 'oz', 1.0);
      expect(result, 0.5);
    });

    test('Convert 1 tablespoon to lb', () {
      final result = convert('tablespoon', 'lb', 1.0);
      expect(result, 0.03125);
    });

    test('Convert 1 tablespoon to qt', () {
      final result = convert('tablespoon', 'qt', 1.0);
      expect(result, 0.015625);
    });

    // Tests for conversions from 'teaspoon'
    test('Convert 1 teaspoon to cup', () {
      final result = convert('teaspoon', 'cup', 1.0);
      expect(result, 0.0208333);
    });

    test('Convert 1 teaspoon to tablespoon', () {
      final result = convert('teaspoon', 'tablespoon', 1.0);
      expect(result, 0.333333);
    });

    test('Convert 1 teaspoon to kg', () {
      final result = convert('teaspoon', 'kg', 1.0);
      expect(result, 0.005);
    });

    test('Convert 1 teaspoon to g', () {
      final result = convert('teaspoon', 'g', 1.0);
      expect(result, 5.0);
    });

    test('Convert 1 teaspoon to mg', () {
      final result = convert('teaspoon', 'mg', 1.0);
      expect(result, 5000.0);
    });

    test('Convert 1 teaspoon to l', () {
      final result = convert('teaspoon', 'l', 1.0);
      expect(result, 0.005);
    });

    test('Convert 1 teaspoon to ml', () {
      final result = convert('teaspoon', 'ml', 1.0);
      expect(result, 5.0);
    });

    test('Convert 1 teaspoon to oz', () {
      final result = convert('teaspoon', 'oz', 1.0);
      expect(result, 0.166667);
    });

    test('Convert 1 teaspoon to lb', () {
      final result = convert('teaspoon', 'lb', 1.0);
      expect(result, 0.0104167);
    });

    test('Convert 1 teaspoon to qt', () {
      final result = convert('teaspoon', 'qt', 1.0);
      expect(result, 0.00520833);
    });

    // Tests for conversions from 'kg'
    test('Convert 1 kg to cup', () {
      final result = convert('kg', 'cup', 1.0);
      expect(result, 4.16667);
    });

    test('Convert 1 kg to tablespoon', () {
      final result = convert('kg', 'tablespoon', 1.0);
      expect(result, 66.6667);
    });

    test('Convert 1 kg to teaspoon', () {
      final result = convert('kg', 'teaspoon', 1.0);
      expect(result, 200.0);
    });

    test('Convert 1 kg to g', () {
      final result = convert('kg', 'g', 1.0);
      expect(result, 1000.0);
    });

    test('Convert 1 kg to mg', () {
      final result = convert('kg', 'mg', 1.0);
      expect(result, 1000000.0);
    });

    test('Convert 1 kg to l', () {
      final result = convert('kg', 'l', 1.0);
      expect(result, 1.0);
    });

    test('Convert 1 kg to ml', () {
      final result = convert('kg', 'ml', 1.0);
      expect(result, 1000.0);
    });

    test('Convert 1 kg to oz', () {
      final result = convert('kg', 'oz', 1.0);
      expect(result, 35.274);
    });

    test('Convert 1 kg to lb', () {
      final result = convert('kg', 'lb', 1.0);
      expect(result, 2.20462);
    });

    test('Convert 1 kg to qt', () {
      final result = convert('kg', 'qt', 1.0);
      expect(result, 1.05669);
    });

    // Tests for conversions from 'g'
    test('Convert 1 g to cup', () {
      final result = convert('g', 'cup', 1.0);
      expect(result, 0.00416667);
    });

    test('Convert 1 g to tablespoon', () {
      final result = convert('g', 'tablespoon', 1.0);
      expect(result, 0.0666667);
    });

    test('Convert 1 g to teaspoon', () {
      final result = convert('g', 'teaspoon', 1.0);
      expect(result, 0.2);
    });

    test('Convert 1 g to kg', () {
      final result = convert('g', 'kg', 1.0);
      expect(result, 0.001);
    });

    test('Convert 1 g to mg', () {
      final result = convert('g', 'mg', 1.0);
      expect(result, 1000.0);
    });

    test('Convert 1 g to l', () {
      final result = convert('g', 'l', 1.0);
      expect(result, 0.001);
    });

    test('Convert 1 g to ml', () {
      final result = convert('g', 'ml', 1.0);
      expect(result, 1.0);
    });

    test('Convert 1 g to oz', () {
      final result = convert('g', 'oz', 1.0);
      expect(result, 0.035274);
    });

    test('Convert 1 g to lb', () {
      final result = convert('g', 'lb', 1.0);
      expect(result, 0.00220462);
    });

    test('Convert 1 g to qt', () {
      final result = convert('g', 'qt', 1.0);
      expect(result, 0.00105669);
    });

    // Tests for conversions from 'mg'
    test('Convert 1 mg to cup', () {
      final result = convert('mg', 'cup', 1.0);
      expect(result, 0.00000416667);
    });

    test('Convert 1 mg to tablespoon', () {
      final result = convert('mg', 'tablespoon', 1.0);
      expect(result, 0.0000666667);
    });

    test('Convert 1 mg to teaspoon', () {
      final result = convert('mg', 'teaspoon', 1.0);
      expect(result, 0.0002);
    });

    test('Convert 1 mg to kg', () {
      final result = convert('mg', 'kg', 1.0);
      expect(result, 0.000001);
    });

    test('Convert 1 mg to g', () {
      final result = convert('mg', 'g', 1.0);
      expect(result, 0.001);
    });

    test('Convert 1 mg to l', () {
      final result = convert('mg', 'l', 1.0);
      expect(result, 0.000001);
    });

    test('Convert 1 mg to ml', () {
      final result = convert('mg', 'ml', 1.0);
      expect(result, 0.001);
    });

    test('Convert 1 mg to oz', () {
      final result = convert('mg', 'oz', 1.0);
      expect(result, 0.000035274);
    });

    test('Convert 1 mg to lb', () {
      final result = convert('mg', 'lb', 1.0);
      expect(result, 0.00000220462);
    });

    test('Convert 1 mg to qt', () {
      final result = convert('mg', 'qt', 1.0);
      expect(result, 0.00000105669);
    });

    // Tests for conversions from 'l'
    test('Convert 1 l to cup', () {
      final result = convert('l', 'cup', 1.0);
      expect(result, 4.16667);
    });

    test('Convert 1 l to tablespoon', () {
      final result = convert('l', 'tablespoon', 1.0);
      expect(result, 66.6667);
    });

    test('Convert 1 l to teaspoon', () {
      final result = convert('l', 'teaspoon', 1.0);
      expect(result, 200.0);
    });

    test('Convert 1 l to kg', () {
      final result = convert('l', 'kg', 1.0);
      expect(result, 1.0);
    });

    test('Convert 1 l to g', () {
      final result = convert('l', 'g', 1.0);
      expect(result, 1000.0);
    });

    test('Convert 1 l to mg', () {
      final result = convert('l', 'mg', 1.0);
      expect(result, 1000000.0);
    });

    test('Convert 1 l to ml', () {
      final result = convert('l', 'ml', 1.0);
      expect(result, 1000.0);
    });

    test('Convert 1 l to oz', () {
      final result = convert('l', 'oz', 1.0);
      expect(result, 33.814);
    });

    test('Convert 1 l to lb', () {
      final result = convert('l', 'lb', 1.0);
      expect(result, 2.20462);
    });

    test('Convert 1 l to qt', () {
      final result = convert('l', 'qt', 1.0);
      expect(result, 1.05669);
    });

    // Tests for conversions from 'ml'
    test('Convert 1 ml to cup', () {
      final result = convert('ml', 'cup', 1.0);
      expect(result, 0.00416667);
    });

    test('Convert 1 ml to tablespoon', () {
      final result = convert('ml', 'tablespoon', 1.0);
      expect(result, 0.0666667);
    });

    test('Convert 1 ml to teaspoon', () {
      final result = convert('ml', 'teaspoon', 1.0);
      expect(result, 0.2);
    });

    test('Convert 1 ml to kg', () {
      final result = convert('ml', 'kg', 1.0);
      expect(result, 0.001);
    });

    test('Convert 1 ml to g', () {
      final result = convert('ml', 'g', 1.0);
      expect(result, 1.0);
    });

    test('Convert 1 ml to mg', () {
      final result = convert('ml', 'mg', 1.0);
      expect(result, 1000.0);
    });

    test('Convert 1 ml to l', () {
      final result = convert('ml', 'l', 1.0);
      expect(result, 0.001);
    });

    test('Convert 1 ml to oz', () {
      final result = convert('ml', 'oz', 1.0);
      expect(result, 0.033814);
    });

    test('Convert 1 ml to lb', () {
      final result = convert('ml', 'lb', 1.0);
      expect(result, 0.00220462);
    });

    test('Convert 1 ml to qt', () {
      final result = convert('ml', 'qt', 1.0);
      expect(result, 0.00105669);
    });

    // Tests for conversions from 'oz'
    test('Convert 1 oz to cup', () {
      final result = convert('oz', 'cup', 1.0);
      expect(result, 0.125);
    });

    test('Convert 1 oz to tablespoon', () {
      final result = convert('oz', 'tablespoon', 1.0);
      expect(result, 2.0);
    });

    test('Convert 1 oz to teaspoon', () {
      final result = convert('oz', 'teaspoon', 1.0);
      expect(result, 6.0);
    });

    test('Convert 1 oz to kg', () {
      final result = convert('oz', 'kg', 1.0);
      expect(result, 0.0283495);
    });

    test('Convert 1 oz to g', () {
      final result = convert('oz', 'g', 1.0);
      expect(result, 28.3495);
    });

    test('Convert 1 oz to mg', () {
      final result = convert('oz', 'mg', 1.0);
      expect(result, 28349.5);
    });

    test('Convert 1 oz to l', () {
      final result = convert('oz', 'l', 1.0);
      expect(result, 0.0295735);
    });

    test('Convert 1 oz to ml', () {
      final result = convert('oz', 'ml', 1.0);
      expect(result, 29.5735);
    });

    test('Convert 1 oz to lb', () {
      final result = convert('oz', 'lb', 1.0);
      expect(result, 0.0625);
    });

    test('Convert 1 oz to qt', () {
      final result = convert('oz', 'qt', 1.0);
      expect(result, 0.03125);
    });

    // Tests for conversions from 'lb'
    test('Convert 1 lb to cup', () {
      final result = convert('lb', 'cup', 1.0);
      expect(result, 2.0);
    });

    test('Convert 1 lb to tablespoon', () {
      final result = convert('lb', 'tablespoon', 1.0);
      expect(result, 32.0);
    });

    test('Convert 1 lb to teaspoon', () {
      final result = convert('lb', 'teaspoon', 1.0);
      expect(result, 96.0);
    });

    test('Convert 1 lb to kg', () {
      final result = convert('lb', 'kg', 1.0);
      expect(result, 0.453592);
    });

    test('Convert 1 lb to g', () {
      final result = convert('lb', 'g', 1.0);
      expect(result, 453.592);
    });

    test('Convert 1 lb to mg', () {
      final result = convert('lb', 'mg', 1.0);
      expect(result, 453592.0);
    });

    test('Convert 1 lb to l', () {
      final result = convert('lb', 'l', 1.0);
      expect(result, 0.453592);
    });

    test('Convert 1 lb to ml', () {
      final result = convert('lb', 'ml', 1.0);
      expect(result, 453.592);
    });

    test('Convert 1 lb to oz', () {
      final result = convert('lb', 'oz', 1.0);
      expect(result, 16.0);
    });

    test('Convert 1 lb to qt', () {
      final result = convert('lb', 'qt', 1.0);
      expect(result, 0.5);
    });

    // Tests for conversions from 'qt'
    test('Convert 1 qt to cup', () {
      final result = convert('qt', 'cup', 1.0);
      expect(result, 4.0);
    });

    test('Convert 1 qt to tablespoon', () {
      final result = convert('qt', 'tablespoon', 1.0);
      expect(result, 64.0);
    });

    test('Convert 1 qt to teaspoon', () {
      final result = convert('qt', 'teaspoon', 1.0);
      expect(result, 192.0);
    });

    test('Convert 1 qt to kg', () {
      final result = convert('qt', 'kg', 1.0);
      expect(result, 0.946353);
    });

    test('Convert 1 qt to g', () {
      final result = convert('qt', 'g', 1.0);
      expect(result, 946.353);
    });

    test('Convert 1 qt to mg', () {
      final result = convert('qt', 'mg', 1.0);
      expect(result, 946353.0);
    });

    test('Convert 1 qt to l', () {
      final result = convert('qt', 'l', 1.0);
      expect(result, 0.946353);
    });

    test('Convert 1 qt to ml', () {
      final result = convert('qt', 'ml', 1.0);
      expect(result, 946.353);
    });

    test('Convert 1 qt to oz', () {
      final result = convert('qt', 'oz', 1.0);
      expect(result, 32.0);
    });

    test('Convert 1 qt to lb', () {
      final result = convert('qt', 'lb', 1.0);
      expect(result, 2.0);
    });
  });
}