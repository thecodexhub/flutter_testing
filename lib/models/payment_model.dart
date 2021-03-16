import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'payment_model.g.dart';

@HiveType(typeId: 0)
class PaymentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime time;

  PaymentModel({
    @required this.name,
    @required this.amount,
    @required this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentModel &&
          other.name == name &&
          other.amount == amount &&
          other.time == time;

  @override
  int get hashCode => hashValues(name, amount, time);
}
