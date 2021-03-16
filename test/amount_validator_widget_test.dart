import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/pages/make_payment_page.dart';
import 'package:flutter_testing/payment_notifier.dart';
import 'package:flutter_testing/services/hive_database.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  // If we don't use MaterialApp widget as the ancestor of our tesable widget, We'll get some error like
  // `No MediaQuery widget ancestor found. Scaffold widgets require a MediaQuery widget ancestor.`
  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentNotifier>(
          create: (_) => PaymentNotifier(),
        ),
        Provider<Database>(
          create: (__) => MockDatabase(),
        ),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  group('MakePaymentPage() - ', () {
    testWidgets(
        'Add a number to ValidationTextField and the submit button is enabled',
        (WidgetTester tester) async {
      // Create the widget
      await tester.pumpWidget(createTestableWidget(MakePaymentPage()));
      // Enter some value to the ValidationTextField
      await tester.enterText(
          find.byKey(const Key('nameField')), 'The Codex Hub');
      await tester.enterText(find.byKey(const Key('amountField')), '18');
      // Rebuild the widget after the state has changed.
      await tester.pump();
      // Check if submit button is enabled
      final isEnabled =
          tester.widget<ElevatedButton>(find.byKey(const Key('submitButton'))).enabled;
      expect(isEnabled, true);
    });

    testWidgets(
        'Add a string to ValidationTextField and the submit button is disabled',
        (WidgetTester tester) async {
      // Create the widget
      await tester.pumpWidget(createTestableWidget(MakePaymentPage()));
      // Enter some value to the ValidationTextField
      await tester.enterText(
          find.byKey(const Key('nameField')), 'The Codex Hub');
      await tester.enterText(
          find.byKey(const Key('amountField')), 'The Codex Hub');
      // Rebuild the widget after the state has changed.
      await tester.pump();
      // Check if submit button is enabled
      final isEnabled =
          tester.widget<ElevatedButton>(find.byKey(const Key('submitButton'))).enabled;
      expect(isEnabled, false);
    });

    testWidgets(
        'Add a number with 3 decimal places to ValidationTextField and the submit button is disabled',
        (WidgetTester tester) async {
      // Create the widget
      await tester.pumpWidget(createTestableWidget(MakePaymentPage()));
      // Enter some value to the ValidationTextField
      await tester.enterText(
          find.byKey(const Key('nameField')), 'The Codex Hub');
      await tester.enterText(find.byKey(const Key('amountField')), '7.476');
      // Rebuild the widget after the state has changed.
      await tester.pump();
      // Check if submit button is enabled
      final isEnabled =
          tester.widget<ElevatedButton>(find.byKey(const Key('submitButton'))).enabled;
      expect(isEnabled, false);
    });
  });
}
