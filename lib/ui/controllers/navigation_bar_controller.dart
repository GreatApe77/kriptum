import 'package:flutter/material.dart';

class NavigationBarController extends ChangeNotifier {
  int _selectPage = 0;

  int get selectedPage => _selectPage;
  void navigateToScreen(int screenIndex){
    _selectPage = screenIndex;
    notifyListeners();
  }
}