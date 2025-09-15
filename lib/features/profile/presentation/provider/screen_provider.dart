import 'package:flutter/material.dart';

class ScreenProvider extends ValueNotifier {
  
  ScreenProvider() : super(0);

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
