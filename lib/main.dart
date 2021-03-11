import 'package:flutter/material.dart';
import 'package:flutter_testing/bottom_nav_bar/bottom_nav_bar_app.dart';
import 'package:flutter_testing/payment_notifier.dart';
import 'package:flutter_testing/models/payment_model.dart';
import 'package:flutter_testing/services/hive_database.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDirectory.path);
  Hive.registerAdapter(PaymentModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentNotifier>(
          create: (_) => PaymentNotifier(),
        ),
        Provider<Database>(
          create: (__) => HiveDatabase(),
        ),
      ],
      child: Consumer<Database>(
        builder: (context, database, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              appBarTheme: const AppBarTheme(
                elevation: 2.0,
                centerTitle: true,
              ),
            ),
            home: FutureBuilder(
              future: database.openBox(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return BottomNavBarApp();
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
