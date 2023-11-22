import 'package:flutter/material.dart';

class LightMode extends ChangeNotifier {
  bool _darkMode = false;
  ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
    ),
  );

  void toggleTheme() {
    _darkMode = !_darkMode;
    themeData = _darkMode
        ? ThemeData.dark()
        : ThemeData(
            brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[800],
              // elevation: 0.0,
            ),
          );
    notifyListeners();
  }
}
