import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/make_payment_page.dart';

void main() {
  // Submit validation test
  group('AmountSubmitValidator Test - ', () {
    test('Empty amount returns isValid false', () {
      // Arrange (Setup)
      final amountSubmitValidator = AmountSubmitValidator();
      // Act (Run)
      final result = amountSubmitValidator.isValid('');
      // Assert (Verify)
      expect(result, false);
    });

    test('String amount returns isValid false', () {
      final amountSubmitValidator = AmountSubmitValidator();
      final result = amountSubmitValidator.isValid('Hello');
      expect(result, false);
    });

    test('Zero amount returns isValid false', () {
      final amountSubmitValidator = AmountSubmitValidator();
      final result = amountSubmitValidator.isValid('0');
      expect(result, false);
    });

    test('Decimal amount returns isValid true', () {
      final amountSubmitValidator = AmountSubmitValidator();
      final result = amountSubmitValidator.isValid('17.50');
      expect(result, true);
    });
  });

  // Regex test
  group('AmountEditingRegexValidator Test - ', () {
    test('Regex validation test with empty input returns true', () {
      final amountEditingRegexValidator = AmountEditingRegexValidator();
      final result = amountEditingRegexValidator.isValid('');
      expect(result, true);
    });

    test('Regex validation test with non-number input returns false', () {
      final amountEditingRegexValidator = AmountEditingRegexValidator();
      final result = amountEditingRegexValidator.isValid('hello');
      expect(result, false);
    });

    test('Regex validation test with zero input returns true', () {
      final amountEditingRegexValidator = AmountEditingRegexValidator();
      final result = amountEditingRegexValidator.isValid('0');
      expect(result, true);
    });

    test('Regex validation test with decimal input returns true', () {
      final amountEditingRegexValidator = AmountEditingRegexValidator();
      final result = amountEditingRegexValidator.isValid('17.50');
      expect(result, true);
    });
  });
}
