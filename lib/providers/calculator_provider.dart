import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';

class CalculatorProvider extends ChangeNotifier {
  String _input = '';
  String _output = '0';
  List<Map<String, dynamic>> _history = [];
  bool _isSoundEnabled = true;
  String _soundTheme = 'default';
  bool _isReadAloudEnabled = false;
  final FlutterTts _flutterTts = FlutterTts();

  // Getters
  String get input => _input;

  String get output => _output;

  List<Map<String, dynamic>> get history => _history;

  bool get isSoundEnabled => _isSoundEnabled;

  String get soundTheme => _soundTheme;

  bool get isReadAloudEnabled => _isReadAloudEnabled;

  // Input methods
  void addToInput(String value) {
    _input += value;
    notifyListeners();
  }

  void setInput(String value) {
    _input = value;
    notifyListeners();
  }

  void clearInput() {
    _input = '';
    _output = '0';
    notifyListeners();
  }

  void backspace() {
    if (_input.isNotEmpty) {
      _input = _input.substring(0, _input.length - 1);
      notifyListeners();
    }
  }

  // Calculate result
  void calculate() {
    if (_input.isEmpty) return;

    try {
      // Check if this is a natural language query
      if (_isNaturalLanguageQuery(_input)) {
        _processNaturalLanguageQuery();
      } else {
        // Regular calculation
        String processedInput = _processInput(_input);
        Parser p = Parser();
        Expression exp = p.parse(processedInput);
        ContextModel cm = ContextModel();
        double result = exp.evaluate(EvaluationType.REAL, cm);

        // Format the result
        _output = result.toString();
        if (_output.endsWith('.0')) {
          _output = _output.substring(0, _output.length - 2);
        }
      }

      // Add to history
      _addToHistory(_input, _output);

      // Read aloud if enabled
      if (_isReadAloudEnabled) {
        _readResult();
      }

      notifyListeners();
    } catch (e) {
      _output = 'Error';
      notifyListeners();
    }
  }

  // Process input to make it compatible with math_expressions library
  String _processInput(String input) {
    String processed = input
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('%', '/100')
        .replaceAll('sin', 'sin')
        .replaceAll('cos', 'cos')
        .replaceAll('tan', 'tan')
        .replaceAll('ln', 'log')
        .replaceAll('π', '3.14159265359');

    return processed;
  }

  // Check if the input is a natural language query
  bool _isNaturalLanguageQuery(String input) {
    input = input.toLowerCase();
    return input.contains('what is') ||
        input.contains('calculate') ||
        input.contains('solve') ||
        input.contains('of') ||
        input.contains('plus') ||
        input.contains('minus') ||
        input.contains('times') ||
        input.contains('divided by');
  }

  // Process natural language query
  void _processNaturalLanguageQuery() {
    String query = _input.toLowerCase();

    // Replace words with symbols
    query = query
        .replaceAll('what is', '')
        .replaceAll('calculate', '')
        .replaceAll('solve', '')
        .replaceAll('plus', '+')
        .replaceAll('minus', '-')
        .replaceAll('times', '*')
        .replaceAll('divided by', '/')
        .replaceAll('of', '*')
        .replaceAll('percent of', '/100*')
        .replaceAll('percent', '/100');

    // Extract numbers and operators
    RegExp regex = RegExp(r'(\d+\.?\d*)|[\+\-\*\/\(\)]');
    Iterable<Match> matches = regex.allMatches(query);
    String processedQuery = matches.map((m) => m.group(0)).join('');

    try {
      // Calculate result
      Parser p = Parser();
      Expression exp = p.parse(processedQuery);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);

      // Format the result
      _output = result.toString();
      if (_output.endsWith('.0')) {
        _output = _output.substring(0, _output.length - 2);
      }
    } catch (e) {
      _output = 'Could not understand query';
    }
  }

  // Add calculation to history
  void _addToHistory(String input, String output) {
    _history.add({
      'input': input,
      'output': output,
      'timestamp': DateTime.now().toString(),
      'steps': _generateSteps(input)
    });
    _saveHistory();
  }

  // Generate solution steps
  List<String> _generateSteps(String input) {
    List<String> steps = [];

    // Simple step generation logic
    // For more complex scenarios, this would be enhanced
    try {
      if (_isNaturalLanguageQuery(input)) {
        String originalQuery = input;
        steps.add("Natural language query: $originalQuery");

        // Process the query
        String query = input.toLowerCase()
            .replaceAll('what is', '')
            .replaceAll('calculate', '')
            .replaceAll('solve', '')
            .replaceAll('plus', '+')
            .replaceAll('minus', '-')
            .replaceAll('times', '*')
            .replaceAll('divided by', '/')
            .replaceAll('of', '*')
            .replaceAll('percent of', '/100*')
            .replaceAll('percent', '/100');

        steps.add("Processed as: $query");

        // Extract mathematical expression
        RegExp regex = RegExp(r'(\d+\.?\d*)|[\+\-\*\/\(\)]');
        Iterable<Match> matches = regex.allMatches(query);
        String processedQuery = matches.map((m) => m.group(0)).join('');
        steps.add("Mathematical expression: $processedQuery");

        // Calculate
        steps.add("Result: $_output");
      } else {
        // For regular mathematical expressions
        steps.add("Expression: $input");

        // Process operators in order of precedence
        if (input.contains('(') && input.contains(')')) {
          steps.add("Evaluate parentheses first");
        }

        if (input.contains('×') || input.contains('*') || input.contains('÷') ||
            input.contains('/')) {
          steps.add("Evaluate multiplication and division");
        }

        if (input.contains('+') || input.contains('-')) {
          steps.add("Evaluate addition and subtraction");
        }

        steps.add("Result: $_output");
      }
    } catch (e) {
      steps.add("Could not generate steps for this calculation");
    }

    return steps;
  }

  // Sound settings
  void toggleSound(bool value) async {
    _isSoundEnabled = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sound_enabled', value);
    notifyListeners();
  }

  void setSoundTheme(String theme) async {
    _soundTheme = theme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sound_theme', theme);
    notifyListeners();
  }

  // Read aloud settings
  void toggleReadAloud(bool value) async {
    _isReadAloudEnabled = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('read_aloud', value);
    notifyListeners();
  }

  void _readResult() {
    _flutterTts.speak("The result is $_output");
  }

  // History management
  void clearHistory() {
    _history = [];
    _saveHistory();
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String historyJson = jsonEncode(_history);
    await prefs.setString('history', historyJson);
  }

  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyJson = prefs.getString('history');

    if (historyJson != null) {
      List<dynamic> historyList = jsonDecode(historyJson);
      _history =
          historyList.map((item) => Map<String, dynamic>.from(item)).toList();
      notifyListeners();
    }
  }

  // Load settings
  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSoundEnabled = prefs.getBool('sound_enabled') ?? true;
    _soundTheme = prefs.getString('sound_theme') ?? 'default';
    _isReadAloudEnabled = prefs.getBool('read_aloud') ?? false;
    await loadHistory();
  }
}