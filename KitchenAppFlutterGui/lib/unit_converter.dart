import 'package:flutter/material.dart';

class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'cup';
  String _toUnit = 'tablespoon';
  String _result = '';

  static const Map<String, Map<String, double>> conversionRates = {
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

  void _convert() {
    final value = double.tryParse(_inputController.text);
    if (value != null) {
      final convertedValue = value * (conversionRates[_fromUnit]![_toUnit] ?? 1);
      setState(() {
        _result = '$value $_fromUnit = ${convertedValue.toStringAsFixed(2)} $_toUnit';
      });
    } else {
      setState(() {
        _result = 'Please enter a valid number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _inputController,
          decoration: InputDecoration(
            labelText: 'Enter value',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          keyboardType: TextInputType.number,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: _fromUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    _fromUnit = newValue!;
                  });
                },
                items: conversionRates.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 20),
            Text('to', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(width: 20),
            Expanded(
              child: DropdownButton<String>(
                value: _toUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    _toUnit = newValue!;
                  });
                },
                items: conversionRates.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: _convert,
          child: Text('Convert'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[600],
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        Text(_result, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}