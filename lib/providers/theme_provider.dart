import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  // Getter for current theme
  ThemeData get currentTheme => _currentTheme;

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      surface: Colors.white,
      background: Colors.grey[100]!,
    ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.indigo,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.indigoAccent,
      secondary: Colors.purpleAccent,
      surface: Color(0xFF1F1F1F),
      background: Color(0xFF121212),
    ),
  );

  // Professional theme
  static final ThemeData professionalTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blueGrey,
      secondary: Colors.blueGrey[300]!,
      surface: Colors.white,
      background: Colors.grey[50]!,
    ),
  );

  // Fun theme for kids
  static final ThemeData funTheme = ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.yellow[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.purple,
      secondary: Colors.orange,
      surface: Colors.yellow[50]!,
      background: Colors.yellow[100]!,
    ),
  );

  // Set theme method
  void setTheme(String themeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', themeName);

    switch (themeName) {
      case 'light':
        _currentTheme = lightTheme;
        break;
      case 'dark':
        _currentTheme = darkTheme;
        break;
      case 'professional':
        _currentTheme = professionalTheme;
        break;
      case 'fun':
        _currentTheme = funTheme;
        break;
      default:
        _currentTheme = lightTheme;
    }
    notifyListeners();
  }

  // Initialize theme from shared preferences
  Future<void> initPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeName = prefs.getString('theme');

    if (themeName != null) {
      setTheme(themeName);
    }
  }
}