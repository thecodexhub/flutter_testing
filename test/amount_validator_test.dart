import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/home_page.dart';

void main() {

  // Submit validation test
  test('Empty amount returns isValid false', () {
    final result = AmountSubmitValidator().isValid('');
    expect(result, false);
  });

  test('String amount returns isValid false', () {
    final result = AmountSubmitValidator().isValid('Hello');
    expect(result, false);
  });

  test('Zero amount returns isValid false', () {
    final result = AmountSubmitValidator().isValid('0');
    expect(result, false);
  });

  test('Decimal amount returns isValid true', () {
    final result = AmountSubmitValidator().isValid('17.50');
    expect(result, true);
  });

  // Regex test
  test('Regex validation test with empty input returns true', () {
    final result = AmountEditingRegexValidator().isValid('');
    expect(result, true);
  });

  test('Regex validation test with non-number input returns false', () {
    final result = AmountEditingRegexValidator().isValid('hello');
    expect(result, false);
  });

  test('Regex validation test with zero input returns true', () {
    final result = AmountEditingRegexValidator().isValid('0');
    expect(result, true);
  });

  test('Regex validation test with decimal input returns true', () {
    final result = AmountEditingRegexValidator().isValid('17.50');
    expect(result, true);
  });
}