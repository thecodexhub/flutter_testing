import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class StringValidator {
  bool isValid(String value);
}

class RegexValidator implements StringValidator {
  RegexValidator({@required this.regexSource});
  final String regexSource;

  /// Value is the input string
  /// And this method only returns true when there is a match for regexSource
  @override
  bool isValid(String value) {
    try {
      final regex = RegExp(regexSource);
      final matches = regex.allMatches(value);

      /// Check whether the match is applied for the whole length of String(value)
      for (final Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      assert(false, e.toString());
      return true;
    }
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  ValidatorInputFormatter({@required this.editingValidator});
  final StringValidator editingValidator;

  /// Inside a textfield we type any text and it passes the validation of 
  /// StringValidator and then if we type any character which is invalid
  /// then this ValidatorInputFormatter would return the oldValue.
  /// That means any modification applied to the TextField input which is invalid
  /// won't be reflected in the text of TextField.
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final bool oldValueValid = editingValidator.isValid(oldValue.text);
    final bool newValueValid = editingValidator.isValid(newValue.text);
    // return the oldValue when the newValue becomes invalid
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    // otherwise return the newValue. This means newValue is also valid
    // according to the StringValidator class.
    return newValue;
  }
}
