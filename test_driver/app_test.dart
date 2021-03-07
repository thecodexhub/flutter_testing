// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Testing - Payment App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final nameField = find.byValueKey('nameField');
    final amountField = find.byValueKey('amountField');
    final submitButton = find.byValueKey('submitButton');

    // BottomNavigationBarItem has specific tooltip
    final submitPayment = find.byTooltip('Submit');
    final recentPayment = find.byTooltip('Recent');

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

      // Move to the Submit tab and Enter a name to the Name TextField
      // By checking the name we can confirm that after adding of one details
      // the form is reset.
      await driver.tap(submitPayment);
      await driver.tap(nameField);
      await driver.enterText('Andre Goetze');
      await driver.waitFor(find.text('Andre Goetze'));
    });

  });
}
