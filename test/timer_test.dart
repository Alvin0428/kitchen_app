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

    testWidgets('Add Timer', (WidgetTester tester) async {
      // Test adding a timer
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

    testWidgets('Start Timer', (WidgetTester tester) async {
      // Test starting a timer
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

    testWidgets('Stop Timer', (WidgetTester tester) async {
      // Test stopping a timer
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

    testWidgets('Reset Timer', (WidgetTester tester) async {
      // Test resetting a timer
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

    testWidgets('Delete Timer', (WidgetTester tester) async {
      // Test deleting a timer
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

    testWidgets('Check Timer Completion Message', (WidgetTester tester) async {
      // Test that the completion message appears when a timer completes
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
  });
}
