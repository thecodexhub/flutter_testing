# Unit Test

We have an abstract class `StringValidator` and a class `RegexValidator` that implements the abstract class.

```dart
abstract class StringValidator {
  bool isValid(String value);
}
```

```dart
class RegexValidator implements StringValidator {
  RegexValidator({@required this.regexSource});
  final String regexSource;

  /// Value is the input string
  /// And this method only returns true when there is a match for regexSource
  @override
  bool isValid(String value) {
    final regex = RegExp(regexSource);
    final matches = regex.allMatches(value);

    /// Check whether the match is applied for the whole length of String(value)
    for (final Match match in matches) {
    if (match.start == 0 && match.end == value.length) {
        return true;
      }
    }
    return false;
  }
}
```

Now it is easy to write tests when we have seperate class for the Business logic components. So the class that we are going to unit test looks like this: 

```dart
class AmountEditingRegexValidator extends RegexValidator {
  AmountEditingRegexValidator()
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,4}))(\\.[0-9]{0,2})?\$");
}
```

Sample unit test:

```dart
test('Empty amount returns isValid false', () {
  // Arrange (Setup)
  final amountSubmitValidator = AmountSubmitValidator();
  // Act (Run)
  final result = amountSubmitValidator.isValid('');
  // Assert (Verify)
  expect(result, false);
});
```

## Run the tests

To run this test file use this command

```console
foo@bar:~$ flutter test test/amount_validator_test.dart
```