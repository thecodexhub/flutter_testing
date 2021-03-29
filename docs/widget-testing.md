# Widget Test

We have a stateful class `MakePaymentPage` and it has an AppBar and a `Column` that contains a `TextField` and an `ElevatedButton` to check whether the input string validates certain Regular Expression (here it is a number upto two decimal places) and if it does so the submit button (ElevatedButton) will be enabled.

We'll write 3 tests to check if the UI behaves as intended.

Sample Widget test:

```dart
testWidgets('Description',
    (WidgetTester tester) async {
  // Create the widget that has to be tested.
  // The pumpWidget method form tester builds the widget.

  // Create the finders.
  // Also you can find a widget with a specific Key or any instance of this widget.

  // To verify the the text widget appears exactly once
  // Use `findsOneWidget` matcher

});
```

1. Enter a number with 2 decimals in ValidationTextField and the submit button will be enabled.

```dart
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
```

2. Enter a String in ValidationTextField and the submit button will not be enabled.

```dart
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
```

3. Enter a number with three decimals in ValidationTextField and the submit button will not be enabled.

```dart
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
```

## Run the tests

To run this test file use this command

```console
foo@bar:~$ flutter test test/amount_validator_widget_test.dart
```
