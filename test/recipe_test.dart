import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_app/main.dart';
import 'package:kitchen_app/recipe.dart';

/**
 * Unit tests for the RecipeWidget in the kitchen app.
 * 
 * This test suite contains tests to verify the functionality of loading and displaying recipes,
 * as well as displaying recipe ingredients and steps.
 */
void main() {
  group('RecipeWidget Tests', () {
    late Widget testWidget;

    /**
     * Sets up the test environment by initializing the testWidget with the MaterialApp and HomePage.
     */
    setUp(() {
      testWidget = MaterialApp(
        home: Scaffold(
          body: HomePage(), // Assuming HomePage is where recipes are listed
        ),
      );
    });

    /**
     * Test to verify that recipes are loaded and displayed correctly in the UI.
     */
    testWidgets('Load Recipes', (WidgetTester tester) async {
      // Pump the testWidget into the widget tree
      await tester.pumpWidget(testWidget);

      // Check for the presence of some recipe names
      expect(find.text('Fried Rice'), findsOneWidget);
      expect(find.text('Spaghetti Bolognese'), findsOneWidget);
      expect(find.text('Pancakes'), findsOneWidget);
    });

    /**
     * Test to verify that selecting a recipe displays its ingredients and steps correctly.
     */
    testWidgets('Display Recipe Ingredients and Steps', (WidgetTester tester) async {
      // Pump the testWidget into the widget tree
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
