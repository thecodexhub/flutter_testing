# Integration Test

Integration testing is conducted to evaluate the compliance of a system or component with specific functional requirements.

This is an example app, we can call a Payment App. It has two tabs. Inside `Submit` tab there are two `TextField`s that are responsible for taking the Name input and the Amount input. When the inputs validate certain Regular Expression, the `ElevatedButton` will be enabled. And after submitting, the details will be saved inside the `Recent` tab.

To write `Integration Test` create a root directory named `test_driver` and it will have two files.

Inside `app.dart` file the following code resides

```dart
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_testing/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
```

And inside `app_test.dart` we will be having the test methods

Alse there are two functions to be called inside main method `setUpAll()` and `tearDownAll()`

```dart
FlutterDriver driver;

// Connect to the Flutter driver before running any tests.
setUpAll(() async {
  driver = await FlutterDriver.connect();
});

// Close the connection to the driver after the tests have completed.
tearDownAll(() async {
  if (driver != null) {
    driver.close();
  }
});
```

Sample test:

```dart
test('Make a payment', () async {
  // Tap the Name TextField and enter a name
  await driver.tap(nameField);
  await driver.enterText('James Williamson');

  // Tap the Amount TextField and enter a value
  await driver.tap(amountField);
  await driver.enterText('147.85');

  // Tap the Submit Button
  await driver.tap(submitButton);

  // Move to the Recent Payment tab and find for the name
  // This checks if the details have been added to the Recent Payment page
  await driver.tap(recentPayment);
  await driver.waitFor(find.text('James Williamson'));
});
```

## Run the tests

Now to run the `Integration Test` run the following from the root of your project

```console
foo@bar:~$ flutter drive --target=test_driver/app.dart
```
