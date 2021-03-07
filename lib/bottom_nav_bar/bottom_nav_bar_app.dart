import 'package:flutter/material.dart';
import 'package:flutter_testing/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:flutter_testing/make_payment_page.dart';
import 'package:flutter_testing/recent_payment_page.dart';

class BottomNavBarApp extends StatefulWidget {
  @override
  _BottomNavBarAppState createState() => _BottomNavBarAppState();
}

class _BottomNavBarAppState extends State<BottomNavBarApp> {
  BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.dispose();
    super.dispose();
  }

  AppBar _buildAppBar(String text) {
    return AppBar(
      title: Text(text),
    );
  }

  Widget _buildBottomNavigationBar(BottomNavBarItem item) {
    return BottomNavigationBar(
      currentIndex: item.index,
      onTap: _bottomNavBarBloc.changeBottomNavBarItem,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: 'Submit',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.details_outlined),
          label: 'Recent',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BottomNavBarItem>(
      stream: _bottomNavBarBloc.bottomNavBarStream,
      initialData: _bottomNavBarBloc.defaultItem,
      builder: (content, snapshot) {
        final item = snapshot.data;
        switch (snapshot.data) {
          case BottomNavBarItem.submit:
            return _submitPaymentArea(item);
            break;
          case BottomNavBarItem.recent:
            return _recentPaymentArea(item);
            break;
          default:
            return _submitPaymentArea(item);
            break;
        }
      },
    );
  }

  Widget _submitPaymentArea(BottomNavBarItem item) {
    return Scaffold(
      appBar: _buildAppBar('Make Payment'),
      bottomNavigationBar: _buildBottomNavigationBar(item),
      body: MakePaymentPage(),
    );
  }

  Widget _recentPaymentArea(BottomNavBarItem item) {
    return Scaffold(
      appBar: _buildAppBar('Recent Payment'),
      bottomNavigationBar: _buildBottomNavigationBar(item),
      body: RecentPaymentPage(),
    );
  }
}
