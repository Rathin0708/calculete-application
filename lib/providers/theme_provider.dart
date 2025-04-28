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

  // Colorful vibrant theme
  static final ThemeData colorfulTheme = ThemeData(
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF8F0FF),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFE040FB),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFFE040FB),
      secondary: Color(0xFF00E5FF),
      surface: Color(0xFFF8F0FF),
      background: Color(0xFFF0F8FF),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFE040FB),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFB39DDB),
  );

  // Mint theme
  static final ThemeData mintTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFE0F2F1),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF00BFA5),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF00BFA5),
      secondary: Color(0xFF1DE9B6),
      surface: Colors.white,
      background: Color(0xFFE0F2F1),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF00BFA5),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFF80CBC4),
  );

  // Deep Ocean theme
  static final ThemeData deepOceanTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF0D47A1),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF002171),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF2196F3),
      secondary: Color(0xFF90CAF9),
      surface: Color(0xFF0D47A1),
      background: Color(0xFF002171),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF90CAF9),
    ),
    cardColor: Color(0xFF1565C0),
    dividerColor: Color(0xFF90CAF9),
  );

  // Sunset theme
  static final ThemeData sunsetTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFF8E1),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFF7043),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFFFF7043),
      secondary: Color(0xFFFFB74D),
      surface: Colors.white,
      background: Color(0xFFFFF8E1),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFFF7043),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFFFCC80),
  );

  // Forest theme
  static final ThemeData forestTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFE8F5E9),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF2E7D32),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF2E7D32),
      secondary: Color(0xFF66BB6A),
      surface: Colors.white,
      background: Color(0xFFE8F5E9),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF2E7D32),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFF81C784),
  );

  // Berry theme
  static final ThemeData berryTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF3E5F5),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF9C27B0),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF9C27B0),
      secondary: Color(0xFFE1BEE7),
      surface: Colors.white,
      background: Color(0xFFF3E5F5),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF9C27B0),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFCE93D8),
  );

  // Coffee theme
  static final ThemeData coffeeTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFEFEBE9),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF795548),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF795548),
      secondary: Color(0xFFBCAAA4),
      surface: Colors.white,
      background: Color(0xFFEFEBE9),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF795548),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFD7CCC8),
  );

  // Midnight theme
  static final ThemeData midnightTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF263238),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF102027),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF29B6F6),
      secondary: Color(0xFF0277BD),
      surface: Color(0xFF263238),
      background: Color(0xFF102027),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF29B6F6),
    ),
    cardColor: Color(0xFF37474F),
    dividerColor: Color(0xFF546E7A),
  );

  // Lavender theme
  static final ThemeData lavenderTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFEDE7F6),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF673AB7),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF673AB7),
      secondary: Color(0xFF9575CD),
      surface: Colors.white,
      background: Color(0xFFEDE7F6),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF673AB7),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFB39DDB),
  );

  // Coral theme
  static final ThemeData coralTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFEBEE),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFE91E63),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFFE91E63),
      secondary: Color(0xFFF48FB1),
      surface: Colors.white,
      background: Color(0xFFFFEBEE),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFE91E63),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFF8BBD0),
  );

  // Amber theme
  static final ThemeData amberTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFF8E1),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFA000),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFFFFA000),
      secondary: Color(0xFFFFD54F),
      surface: Colors.white,
      background: Color(0xFFFFF8E1),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFFFA000),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFFFE082),
  );

  // Aqua theme
  static final ThemeData aquaTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFE0F7FA),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF00ACC1),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF00ACC1),
      secondary: Color(0xFF4DD0E1),
      surface: Colors.white,
      background: Color(0xFFE0F7FA),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF00ACC1),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFF80DEEA),
  );

  // Ruby theme
  static final ThemeData rubyTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFEBEE),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFD32F2F),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFFD32F2F),
      secondary: Color(0xFFEF5350),
      surface: Colors.white,
      background: Color(0xFFFFEBEE),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFD32F2F),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFEF9A9A),
  );

  // Emerald theme
  static final ThemeData emeraldTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFE8F5E9),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF00897B),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF00897B),
      secondary: Color(0xFF26A69A),
      surface: Colors.white,
      background: Color(0xFFE8F5E9),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF00897B),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFF80CBC4),
  );

  // Royal theme
  static final ThemeData royalTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFE8EAF6),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF3F51B5),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF3F51B5),
      secondary: Color(0xFF7986CB),
      surface: Colors.white,
      background: Color(0xFFE8EAF6),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF3F51B5),
    ),
    cardColor: Colors.white,
    dividerColor: Color(0xFFC5CAE9),
  );

  // Rainbow theme (easter egg)
  static final ThemeData rainbowTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF8C00FF),
      // Purple
      secondary: Color(0xFFFF00DD),
      // Pink
      surface: Colors.black,
      background: Colors.black,
      error: Colors.redAccent,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFFFFFF00),
      // Yellow
      onBackground: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF00DDFF), // Cyan
    ),
    cardColor: Colors.black,
    dividerColor: Color(0xFFFF5500),
    // Orange
    textTheme: TextTheme(
      titleLarge: TextStyle(color: Color(0xFFFF00DD)), // Pink
      bodyLarge: TextStyle(color: Color(0xFFFFFF00)), // Yellow
      bodyMedium: TextStyle(color: Color(0xFF00DDFF)), // Cyan
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
      case 'colorful':
        _currentTheme = colorfulTheme;
        break;
      case 'mint':
        _currentTheme = mintTheme;
        break;
      case 'deep_ocean':
        _currentTheme = deepOceanTheme;
        break;
      case 'sunset':
        _currentTheme = sunsetTheme;
        break;
      case 'forest':
        _currentTheme = forestTheme;
        break;
      case 'berry':
        _currentTheme = berryTheme;
        break;
      case 'coffee':
        _currentTheme = coffeeTheme;
        break;
      case 'midnight':
        _currentTheme = midnightTheme;
        break;
      case 'lavender':
        _currentTheme = lavenderTheme;
        break;
      case 'coral':
        _currentTheme = coralTheme;
        break;
      case 'amber':
        _currentTheme = amberTheme;
        break;
      case 'aqua':
        _currentTheme = aquaTheme;
        break;
      case 'ruby':
        _currentTheme = rubyTheme;
        break;
      case 'emerald':
        _currentTheme = emeraldTheme;
        break;
      case 'royal':
        _currentTheme = royalTheme;
        break;
      case 'rainbow':
        _currentTheme = rainbowTheme;
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