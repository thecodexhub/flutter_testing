import 'package:flutter/foundation.dart';
import 'package:flutter_testing/models/payment_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class Database {
  Future<Box<PaymentModel>> openBox();
  Future<void> addPayment(PaymentModel model);
  ValueListenable<Box<PaymentModel>> listenablePayments();
  Future<void> deletePayment(int key);
}

class HiveDatabase implements Database {
  @override
  Future<Box<PaymentModel>> openBox() {
    return Hive.openBox<PaymentModel>('history');
  }

  @override
  Future<void> addPayment(PaymentModel model) async {
    await Hive.box<PaymentModel>('history').add(model);
  }

  @override
  ValueListenable<Box<PaymentModel>> listenablePayments() {
    return Hive.box<PaymentModel>('history').listenable();
  }

  @override
  Future<void> deletePayment(int key) async {
    await Hive.box<PaymentModel>('history').delete(key);
  }
}
