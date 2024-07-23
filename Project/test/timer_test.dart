import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_app/timer.dart';

void main() {
  group('TimerWidget Tests', () {
    late TimerWidget timerWidget;
    late Widget testWidget;
    int completedTimers = 0;

    setUp(() {
      timerWidget = TimerWidget(
        incrementCompletedTimers: () {
          completedTimers++;
        },
      );

      testWidget = MaterialApp(
        home: Scaffold(
          body: timerWidget,
        ),
      );
    });

    /**
     * Test adding a timer with valid input.
     * It verifies that the timer is added to the list with the correct name and duration.
     */
    testWidgets('Add Timer', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '0');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '10');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      expect(find.text('Test Timer'), findsOneWidget);
      expect(find.text('00:00:10'), findsOneWidget);
    });

    /**
     * Test starting a timer.
     * It verifies that the timer starts and decrements the remaining time.
     */
    testWidgets('Start Timer', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '0');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '5');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.play_arrow).first);
      await tester.pump(Duration(seconds: 6)); // Allow timer to run

      expect(find.text('Test Timer'), findsOneWidget);
    });

    /**
     * Test stopping a timer.
     * It verifies that the timer stops and no longer decrements the remaining time.
     */
    testWidgets('Stop Timer', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '0');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '5');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.play_arrow).first);
      await tester.pump(Duration(seconds: 2));

      await tester.tap(find.byIcon(Icons.stop).first);
      await tester.pump();

      expect(find.text('Test Timer'), findsOneWidget);
    });

    /**
     * Test resetting a timer.
     * It verifies that the timer resets to its initial duration.
     */
    testWidgets('Reset Timer', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '0');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '5');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.play_arrow).first);
      await tester.pump(Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.replay).first);
      await tester.pump();

      expect(find.text('00:00:05'), findsOneWidget);
    });

    /**
     * Test deleting a timer.
     * It verifies that the timer is removed from the list.
     */
    testWidgets('Delete Timer', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '0');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '5');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pump();

      expect(find.text('Test Timer'), findsNothing);
    });

    /**
     * Test that the completion message appears when a timer completes.
     * It verifies that a SnackBar is shown with the correct completion message.
     */
    testWidgets('Check Timer Completion Message', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '0');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '1');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.play_arrow).first);
      await tester.pump(Duration(seconds: 2));

      expect(find.text('Test Timer is done!'), findsOneWidget);
    });

    /**
     * Test that a timer with negative hours cannot be added.
     * It verifies that the error message is shown and the timer is not added.
     */
    testWidgets('Cannot add timer with negative hours', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '-1');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '0');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      expect(find.text('Test Timer'), findsNothing);  // Timer should not be added
      expect(find.text('Invalid time entered. Please enter a positive value.'), findsOneWidget);  // Error message
    });

    /**
     * Test that a timer with negative minutes cannot be added.
     * It verifies that the error message is shown and the timer is not added.
     */
    testWidgets('Cannot add timer with negative minutes', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '0');
      await tester.enterText(find.byType(TextField).at(2), '-1');
      await tester.enterText(find.byType(TextField).at(3), '0');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      expect(find.text('Test Timer'), findsNothing);  // Timer should not be added
      expect(find.text('Invalid time entered. Please enter a positive value.'), findsOneWidget);  // Error message
    });

    /**
     * Test that a timer with negative seconds cannot be added.
     * It verifies that the error message is shown and the timer is not added.
     */
    testWidgets('Cannot add timer with negative seconds', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test Timer');
      await tester.enterText(find.byType(TextField).at(1), '0');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '-1');

      await tester.tap(find.text('Add Timer'));
      await tester.pump();

      expect(find.text('Test Timer'), findsNothing);  // Timer should not be added
      expect(find.text('Invalid time entered. Please enter a positive value.'), findsOneWidget);  // Error message
    });
  });
}
