import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculater/providers/calculator_provider.dart';
import 'package:calculater/providers/theme_provider.dart';
import 'package:calculater/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Smart Calculator',
            theme: themeProvider.currentTheme,
            home: const HomeScreen(initialTabIndex: 0),
          );
        },
      ),
    );
  }
}