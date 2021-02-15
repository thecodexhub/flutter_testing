import 'package:flutter/material.dart';
import 'package:flutter_testing/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: AppBarTheme(
          elevation: 2.0,
          centerTitle: true,
        ),
      ),
      home: HomePage(),
    );
  }
}
