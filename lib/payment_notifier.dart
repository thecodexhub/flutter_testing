import 'package:flutter/material.dart';
import 'package:flutter_testing/models/payment_model.dart';

class PaymentNotifier extends ChangeNotifier {
  String _name = '';
  String _amount = '';
  final List<PaymentModel> _payments = [];

  String get name => _name;
  String get amount => _amount;
  List<PaymentModel> get payments => _payments;

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updateAmount(String amount) {
    _amount = amount;
    notifyListeners();
  }

  void clearAll() {
    _name = '';
    _amount = '';
    notifyListeners();
  }

  void addPayment(PaymentModel payment) {
    _payments.add(payment);
    notifyListeners();
  }

  void removePayment(PaymentModel payment) {
    _payments.remove(payment);
    notifyListeners();
  }
}
