import 'package:flutter/material.dart';

class NavigationStateProvider with ChangeNotifier {
  int _selectedIndex = 0;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void navigateToSearch() {
    navigatorKey.currentState?.pushNamed('/search');
    setSelectedIndex(2);
  }
}