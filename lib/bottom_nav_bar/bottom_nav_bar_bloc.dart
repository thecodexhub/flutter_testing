import 'dart:async';

enum BottomNavBarItem { submit, recent, history }

class BottomNavBarBloc {
  final StreamController<BottomNavBarItem> _bottomNavBarController =
      StreamController<BottomNavBarItem>.broadcast();

  Stream<BottomNavBarItem> get bottomNavBarStream =>
      _bottomNavBarController.stream;

  BottomNavBarItem defaultItem = BottomNavBarItem.submit;

  void changeBottomNavBarItem(int itemIndex) {
    switch (itemIndex) {
      case 0:
        _bottomNavBarController.sink.add(BottomNavBarItem.submit);
        break;
      case 1:
        _bottomNavBarController.sink.add(BottomNavBarItem.recent);
        break;
      case 2:
        _bottomNavBarController.sink.add(BottomNavBarItem.history);
        break;
    }
  }

  void dispose() {
    _bottomNavBarController?.close();
  }
}
