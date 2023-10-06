import 'package:flutter/material.dart';

class ThemeProvder with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(36, 124, 38, 1),
      fontFamily: 'DMSans',
      colorScheme: const ColorScheme.dark());

  static final lightTheme = ThemeData(
    primaryColor: const Color.fromRGBO(36, 124, 38, 1),
    highlightColor: const Color.fromRGBO(36, 124, 38, 1).withOpacity(0.1),
    scaffoldBackgroundColor: const Color.fromRGBO(241, 242, 245, 1),
    backgroundColor: const Color.fromRGBO(66, 32, 7, 1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Define the default font family.
    fontFamily: 'DMSans',
  );
}
