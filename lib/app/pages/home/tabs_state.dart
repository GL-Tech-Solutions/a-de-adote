import 'package:flutter/material.dart';

class TabsState extends ChangeNotifier {
  int currentTab = 0;

  void setTabIndex(int index) {
    currentTab = index;
    notifyListeners();
  }
}
