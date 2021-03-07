import 'package:flutter/material.dart';
import 'package:flutter_testing/bottom_nav_bar/bottom_nav_bar_app.dart';
import 'package:flutter_testing/payment_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentNotifier>(
      create: (_) => PaymentNotifier(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          appBarTheme: const AppBarTheme(
            elevation: 2.0,
            centerTitle: true,
          ),
        ),
        home: BottomNavBarApp(),
      ),
    );
  }
}
