import 'package:flutter/material.dart';
import 'package:flutter_testing/payment_notifier.dart';
import 'package:provider/provider.dart';

class RecentPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paymentNotifier = Provider.of<PaymentNotifier>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: paymentNotifier.payments.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            paymentNotifier.payments[index].name,
          ),
          subtitle: Text(
            'Paid at ${paymentNotifier.payments[index].time.toString().substring(0, 16)}',
          ),
          trailing: Text(
            '\$ ${paymentNotifier.payments[index].amount.toString()}',
          ),
        ),
      ),
    );
  }
}
