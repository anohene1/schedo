import 'package:flutter/material.dart';
import 'package:schedo_final/main.dart';
import '../view/themes/themes.dart';

class MyTheme with ChangeNotifier {
  static bool _isLight = true;

  ThemeData currentTheme() {
    return _isLight ? lightTheme() : darkTheme();
  }

  void switchTheme() {
    _isLight = !_isLight;
    notifyListeners();
  }
}