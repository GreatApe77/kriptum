import 'package:flutter/material.dart';

class CreateWalletStepsController extends ChangeNotifier {
   int _step = 0;

  int get step => _step;

  void nextStep() {
    _step++;
    notifyListeners();
  }
  void previousStep(){
    _step--;
    notifyListeners();
  }
}
