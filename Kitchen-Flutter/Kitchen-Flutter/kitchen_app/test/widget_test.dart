import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_app/main.dart';
import 'package:kitchen_app/recipe.dart';
import 'package:kitchen_app/unit_converter.dart';
import 'package:kitchen_app/timer.dart';

void main() {
  testWidgets('Recipe selection and display', (WidgetTester tester) async {
    await tester.pumpWidget(KitchenApp());

    expect(find.text('Fried Rice'), findsOneWidget);
    expect(find.text('Spaghetti Bolognese'), findsOneWidget);

    await tester.tap(find.text('Spaghetti Bolognese'));
    await tester.pump();

    expect(find.text('Spaghetti'), findsOneWidget);
  });

  testWidgets('Unit conversion', (WidgetTester tester) async {
    await tester.pumpWidget(UnitConverter());

    await tester.enterText(find.byType(TextField).first, '1');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    expect(find.text('1 cup = 16.00 tablespoon'), findsOneWidget);
  });

  testWidgets('Timer functionality', (WidgetTester tester) async {
    await tester.pumpWidget(TimerWidget());

    await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
    await tester.enterText(find.byType(TextField).at(1), '0');
    await tester.enterText(find.byType(TextField).at(2), '0');
    await tester.enterText(find.byType(TextField).at(3), '10');
    await tester.tap(find.text('Add Timer'));
    await tester.pump();

    expect(find.text('Test Timer'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_arrow).first);
    await tester.pump(const Duration(seconds: 5));

    expect(find.text('00:00:05'), findsOneWidget);
  });
}
