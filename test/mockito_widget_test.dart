import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/models/payment_model.dart';
import 'package:flutter_testing/pages/make_payment_page.dart';
import 'package:flutter_testing/payment_notifier.dart';
import 'package:flutter_testing/services/hive_database.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  // Widget maketestableWidget({Widget child, Database database}) {
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider<PaymentNotifier>(
  //         create: (_) => PaymentNotifier(),
  //       ),
  //       Provider<Database>(
  //         create: (__) => database,
  //       ),
  //     ],
  //     child: MaterialApp(
  //       home: child,
  //     ),
  //   );
  // }

  // // Given the name or amount field is empty
  // // When the user taps on the submit button
  // // Then we don't attempt to save details is Hive database
  // // And the addPayment callback is not called
  // testWidgets('name or amount is empty, donot save details',
  //     (WidgetTester tester) async {
  //   final MockDatabase mockDatabase = MockDatabase();

  //   final MakePaymentPage makePaymentPage = MakePaymentPage();

  //   await tester.pumpWidget(maketestableWidget(
  //     child: makePaymentPage,
  //     database: mockDatabase,
  //   ));

  //   await tester.tap(find.byKey(const Key('submitButton')));

  //   await mockDatabase.openBox();
  //   verifyNever(await mockDatabase
  //       .addPayment(PaymentModel(name: '', amount: null, time: null)));
  // });

  // testWidgets('name or amount is non-empty, save details',
  //     (WidgetTester tester) async {
  //   final MockDatabase mockDatabase = MockDatabase();

  //   final MakePaymentPage makePaymentPage = MakePaymentPage();

  //   await tester.pumpWidget(maketestableWidget(
  //     child: makePaymentPage,
  //     database: mockDatabase,
  //   ));

  //   final Finder nameField = find.byKey(const Key('nameField'));
  //   await tester.enterText(nameField, 'name');

  //   final Finder amountField = find.byKey(const Key('amountField'));
  //   await tester.enterText(amountField, '12');

  //   await tester.pump();
  //   await tester.tap(find.byKey(const Key('submitButton')));

  //   final isEnabled = tester
  //       .widget<ElevatedButton>(find.byKey(const Key('submitButton')))
  //       .enabled;
  //   expect(isEnabled, true);

  //   verify(mockDatabase
  //       .addPayment(PaymentModel(name: 'name', amount: 12, time: DateTime.now()))).called(1);
  // });
}
