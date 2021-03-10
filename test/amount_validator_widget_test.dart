import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/pages/make_payment_page.dart';
import 'package:flutter_testing/common_widgets/validation_textfield.dart';

void main() {
  // If we don't use MaterialApp widget as the ancestor of our tesable widget, We'll get some error like
  // `No MediaQuery widget ancestor found. Scaffold widgets require a MediaQuery widget ancestor.`
  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  group('MakePaymentPage() - ', () {
    testWidgets('Make Payment Page has an AppBar title',
        (WidgetTester tester) async {
      // Create the widget that has to be tested.
      // The pumpWidget method form tester builds the widget.
      await tester.pumpWidget(createTestableWidget(MakePaymentPage()));
      // Create the finders.
      // Also you can find a widget with a specific Key or any instance of this widget.
      final titleFinder = find.text('Make a Payment');
      // To verify the the text widget appears exactly once
      // Use `findsOneWidget` matcher
      expect(titleFinder, findsOneWidget);
    });

    testWidgets(
        'Add a number to ValidationTextField and the submit button is enabled',
        (WidgetTester tester) async {
      // Create the widget
      await tester.pumpWidget(createTestableWidget(MakePaymentPage()));
      // Enter some value to the ValidationTextField
      await tester.enterText(find.byType(ValidationTextField), '18.99');
      // Rebuild the widget after the state has changed.
      await tester.pump();
      // Check if submit button is enabled
      final isEnabled =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled;
      expect(isEnabled, true);
    });

    testWidgets(
        'Add a string to ValidationTextField and the submit button is disabled',
        (WidgetTester tester) async {
      // Create the widget
      await tester.pumpWidget(createTestableWidget(MakePaymentPage()));
      // Enter some value to the ValidationTextField
      await tester.enterText(find.byType(ValidationTextField), 'The Codex Hub');
      // Rebuild the widget after the state has changed.
      await tester.pump();
      // Check if submit button is enabled
      final isEnabled =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled;
      expect(isEnabled, false);
    });

    testWidgets(
        'Add a number with 3 decimal places to ValidationTextField and the submit button is disabled',
        (WidgetTester tester) async {
      // Create the widget
      await tester.pumpWidget(createTestableWidget(MakePaymentPage()));
      // Enter some value to the ValidationTextField
      await tester.enterText(find.byType(ValidationTextField), '7.476');
      // Rebuild the widget after the state has changed.
      await tester.pump();
      // Check if submit button is enabled
      final isEnabled =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled;
      expect(isEnabled, false);
    });
  });
}
