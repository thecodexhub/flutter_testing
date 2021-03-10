import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:flutter_testing/models/payment_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryPaymentPage extends StatefulWidget {
  @override
  _HistoryPaymentPageState createState() => _HistoryPaymentPageState();
}

class _HistoryPaymentPageState extends State<HistoryPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<PaymentModel>('history').listenable(),
      builder: (context, Box<PaymentModel> historyBox, _) {
        if (historyBox.values.isEmpty) {
          return const Center(child: Text('No Data'));
        }
        return ListView.builder(
          itemCount: historyBox.values.length,
          itemBuilder: (context, index) {
            final history = historyBox.getAt(index);
            return ListTile(
              title: Text(history.name),
              subtitle: Text(history.time.toString().substring(0, 16)),
              trailing: Text('\$ ${history.amount}'),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
