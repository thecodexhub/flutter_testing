import 'package:flutter/material.dart';
import 'package:flutter_testing/string_validator.dart';
import 'package:flutter_testing/validation_textfield.dart';

class AmountEditingRegexValidator extends RegexValidator {
  AmountEditingRegexValidator()
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,4}))(\\.[0-9]{0,2})?\$");
}

class AmountSubmitValidator extends StringValidator {
  @override
  bool isValid(String value) {
    try {
      final number = double.parse(value);
      return number > 0.0;
    } catch (e) {
      return false;
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make a Payment')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValidationTextField(
              inputDecoration: const InputDecoration(
                hintText: '\$ 9.99',
                hintStyle: TextStyle(fontSize: 30.0, color: Colors.black45),
              ),
              onSubmit: (value) => print(value),
              submitText: 'Submit',
              keyboardType: TextInputType.number,
              inputFormatter: ValidatorInputFormatter(
                editingValidator: AmountEditingRegexValidator(),
              ),
              stringValidator: AmountSubmitValidator(),
            ),
          ],
        ),
      ),
    );
  }
}
