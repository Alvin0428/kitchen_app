import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_app/main.dart';
import 'package:kitchen_app/recipe.dart';

void main() {
  group('RecipeWidget Tests', () {
    late Widget testWidget;

    setUp(() {
      testWidget = MaterialApp(
        home: Scaffold(
          body: HomePage(), // Assuming HomePage is where recipes are listed
        ),
      );
    });

    testWidgets('Load Recipes', (WidgetTester tester) async {
      // Test loading recipes and displaying them in the UI
      await tester.pumpWidget(testWidget);

      // Check for the presence of some recipe names
      expect(find.text('Fried Rice'), findsOneWidget);
      expect(find.text('Spaghetti Bolognese'), findsOneWidget);
      expect(find.text('Pancakes'), findsOneWidget);
    });

    testWidgets('Display Recipe Ingredients and Steps', (WidgetTester tester) async {
      // Test selecting a recipe and displaying its ingredients and steps
      await tester.pumpWidget(testWidget);

      // Select the "Fried Rice" recipe
      await tester.tap(find.text('Fried Rice'));
      await tester.pumpAndSettle();

      // Check if ingredients and steps for "Fried Rice" are displayed
      expect(find.text('Rice: 2 cups'), findsOneWidget);
      expect(find.text('Mixed vegetables: 1 cup'), findsOneWidget);
      expect(find.text('Heat oil in a large skillet over medium heat.'), findsOneWidget);
      expect(find.text('Add garlic and sauté until fragrant.'), findsOneWidget);
    });
  });
}
