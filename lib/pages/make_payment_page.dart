import 'package:flutter/material.dart';
import 'package:flutter_testing/common_widgets/string_validator.dart';
import 'package:flutter_testing/common_widgets/validation_textfield.dart';
import 'package:flutter_testing/models/payment_model.dart';
import 'package:flutter_testing/payment_notifier.dart';
import 'package:flutter_testing/services/hive_database.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class NameEditingRegexValidator extends RegexValidator {
  NameEditingRegexValidator() : super(regexSource: "^[a-zA-Z ,.'-]+\$/i");
}

class NameSubmitValidator extends StringValidator {
  @override
  bool isValid(String value) {
    try {
      final name = value.trim();
      return name.length >= 3;
    } catch (e) {
      return false;
    }
  }
}

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

class MakePaymentPage extends StatefulWidget {
  @override
  _MakePaymentPageState createState() => _MakePaymentPageState();
}

class _MakePaymentPageState extends State<MakePaymentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController?.dispose();
    _amountController?.dispose();
    _nameFocusNode?.dispose();
    _amountFocusNode?.dispose();
    super.dispose();
  }

  void _nameSubmit(PaymentNotifier paymentNotifier) async {
    final bool isValid = NameSubmitValidator().isValid(paymentNotifier.name);
    if (isValid) {
      _nameFocusNode.unfocus();
    } else {
      FocusScope.of(context).requestFocus(_nameFocusNode);
    }
  }

  void _amountSubmit(PaymentNotifier paymentNotifier) async {
    final bool isValid =
        AmountSubmitValidator().isValid(paymentNotifier.amount);
    if (isValid) {
      _amountFocusNode.unfocus();
    } else {
      FocusScope.of(context).requestFocus(_amountFocusNode);
    }
  }

  Future<void> addPaymentDetails(PaymentModel model) async {
    // Add payment details in Hive database
    // final historyBox = Hive.box<PaymentModel>('history');
    final database = Provider.of<Database>(context, listen: false);
    await database.addPayment(model);
    // historyBox.add(model);
    // Add payment details in state
    final paymentNotifier =
        Provider.of<PaymentNotifier>(context, listen: false);
    paymentNotifier.addPayment(model);
  }

  void clearFields() {
    final paymentNotifier =
        Provider.of<PaymentNotifier>(context, listen: false);
    _amountFocusNode?.unfocus();
    _nameFocusNode?.unfocus();
    paymentNotifier.clearAll();
    _nameController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final paymentNotifier = Provider.of<PaymentNotifier>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValidationTextField(
              key: const ValueKey('nameField'),
              textEditingController: _nameController,
              focusNode: _nameFocusNode,
              inputDecoration: const InputDecoration(
                hintText: 'Enter name',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.black45),
              ),
              onChanged: paymentNotifier.updateName,
              onEditingComplete: () => _nameSubmit(paymentNotifier),
              keyboardType: TextInputType.text,
              inputFormatter: ValidatorInputFormatter(
                editingValidator: NameEditingRegexValidator(),
              ),
              stringValidator: NameSubmitValidator(),
            ),
            const SizedBox(height: 8.0),
            ValidationTextField(
              key: const ValueKey('amountField'),
              textEditingController: _amountController,
              focusNode: _amountFocusNode,
              inputDecoration: const InputDecoration(
                hintText: '\$ 9.99',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.black45),
              ),
              onChanged: paymentNotifier.updateAmount,
              onEditingComplete: () => _amountSubmit(paymentNotifier),
              keyboardType: TextInputType.number,
              inputFormatter: ValidatorInputFormatter(
                editingValidator: AmountEditingRegexValidator(),
              ),
              stringValidator: AmountSubmitValidator(),
            ),
            const SizedBox(height: 16.0),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    final paymentNotifier =
        Provider.of<PaymentNotifier>(context, listen: false);
    final bool _isValid =
        AmountSubmitValidator().isValid(paymentNotifier.amount) &&
            NameSubmitValidator().isValid(paymentNotifier.name);
    return SizedBox(
      height: 45.0,
      child: ElevatedButton(
        key: const ValueKey('submitButton'),
        onPressed: _isValid
            ? () {
                addPaymentDetails(PaymentModel(
                  name: paymentNotifier.name,
                  amount: double.parse(paymentNotifier.amount),
                  time: DateTime.now(),
                ));
                clearFields();
              }
            : null,
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
