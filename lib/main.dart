import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculater/providers/calculator_provider.dart';
import 'package:calculater/providers/theme_provider.dart';
import 'package:calculater/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization failed: $e');
  }
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
            supportedLocales: const [
              Locale('en', 'US'), // English
              Locale('ta', 'IN'), // Tamil
              Locale('hi', 'IN'), // Hindi
              Locale('es', 'ES'), // Spanish
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: themeProvider.currentLocale,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}