import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorKeypad extends StatefulWidget {
  final bool isScientific;

  const CalculatorKeypad({
    Key? key,
    required this.isScientific,
  }) : super(key: key);

  @override
  State<CalculatorKeypad> createState() => _CalculatorKeypadState();
}

class _CalculatorKeypadState extends State<CalculatorKeypad> {
  List<Map<String, dynamic>> _keypadLayout = [];
  bool _isCustomizing = false;

  @override
  void initState() {
    super.initState();
    _loadKeypadLayout();
  }

  Future<void> _loadKeypadLayout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? layoutKey = widget.isScientific
        ? 'scientific_layout'
        : 'basic_layout';
    String? savedLayout = prefs.getString(layoutKey);

    if (savedLayout != null) {
      try {
        List<dynamic> decodedLayout = await Future.value(
          savedLayout.split(',').map((item) =>
          {
            'value': item,
            'text': item,
          }).toList(),
        );
        setState(() {
          _keypadLayout = List<Map<String, dynamic>>.from(decodedLayout);
        });
      } catch (e) {
        // If there's an error, use default layout
        _setDefaultLayout();
      }
    } else {
      _setDefaultLayout();
    }
  }

  void _setDefaultLayout() {
    if (widget.isScientific) {
      _keypadLayout = [
        {'value': 'sin', 'text': 'sin'},
        {'value': 'cos', 'text': 'cos'},
        {'value': 'tan', 'text': 'tan'},
        {'value': 'log', 'text': 'log'},
        {'value': 'ln', 'text': 'ln'},
        {'value': '(', 'text': '('},
        {'value': ')', 'text': ')'},
        {'value': '^', 'text': '^'},
        {'value': '√', 'text': '√'},
        {'value': 'π', 'text': 'π'},
        {'value': '7', 'text': '7'},
        {'value': '8', 'text': '8'},
        {'value': '9', 'text': '9'},
        {'value': '÷', 'text': '÷'},
        {'value': '%', 'text': '%'},
        {'value': '4', 'text': '4'},
        {'value': '5', 'text': '5'},
        {'value': '6', 'text': '6'},
        {'value': '×', 'text': '×'},
        {'value': '!', 'text': '!'},
        {'value': '1', 'text': '1'},
        {'value': '2', 'text': '2'},
        {'value': '3', 'text': '3'},
        {'value': '-', 'text': '-'},
        {'value': 'AC', 'text': 'AC'},
        {'value': '0', 'text': '0'},
        {'value': '.', 'text': '.'},
        {'value': '=', 'text': '='},
        {'value': '+', 'text': '+'},
        {'value': '⌫', 'text': '⌫'},
      ];
    } else {
      _keypadLayout = [
        {'value': 'AC', 'text': 'AC'},
        {'value': '⌫', 'text': '⌫'},
        {'value': '%', 'text': '%'},
        {'value': '÷', 'text': '÷'},
        {'value': '7', 'text': '7'},
        {'value': '8', 'text': '8'},
        {'value': '9', 'text': '9'},
        {'value': '×', 'text': '×'},
        {'value': '4', 'text': '4'},
        {'value': '5', 'text': '5'},
        {'value': '6', 'text': '6'},
        {'value': '-', 'text': '-'},
        {'value': '1', 'text': '1'},
        {'value': '2', 'text': '2'},
        {'value': '3', 'text': '3'},
        {'value': '+', 'text': '+'},
        {'value': '00', 'text': '00'},
        {'value': '0', 'text': '0'},
        {'value': '.', 'text': '.'},
        {'value': '=', 'text': '='},
      ];
    }
  }

  Future<void> _saveKeypadLayout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String layoutKey = widget.isScientific
        ? 'scientific_layout'
        : 'basic_layout';
    String layoutString = _keypadLayout.map((item) => item['value']).join(',');
    await prefs.setString(layoutKey, layoutString);
  }

  void _handleButtonPress(String value) {
    final calculatorProvider = Provider.of<CalculatorProvider>(
        context, listen: false);

    // Check for easter eggs
    _checkEasterEggs(calculatorProvider.input + value);

    switch (value) {
      case 'AC':
        calculatorProvider.clearInput();
        break;
      case '⌫':
        calculatorProvider.backspace();
        break;
      case '=':
        calculatorProvider.calculate();
        break;
      default:
        calculatorProvider.addToInput(value);
    }
  }

  void _checkEasterEggs(String input) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    // Easter egg theme codes
    Map<String, Map<String, dynamic>> easterEggs = {
      "123+": {
        "theme": "rainbow",
        "message": "Rainbow theme unlocked! 🌈✨",
        "color": Color(0xFF9C27B0),
      },
      "007=": {
        "theme": "midnight",
        "message": "Secret agent mode activated! 🕵️",
        "color": Color(0xFF263238),
      },
      "42*42": {
        "theme": "deep_ocean",
        "message": "The answer to everything is... deep blue! 🌊",
        "color": Color(0xFF0D47A1),
      },
      "1337=": {
        "theme": "emerald",
        "message": "Elite hacker mode engaged! 💻",
        "color": Color(0xFF00897B),
      },
      "0000": {
        "theme": "berry",
        "message": "Sweet berry theme unlocked! 🍓",
        "color": Color(0xFF9C27B0),
      },
    };

    // Check if the input matches any easter egg codes
    if (easterEggs.containsKey(input)) {
      final egg = easterEggs[input]!;
      _unlockSecretTheme(egg["theme"] as String, egg["message"] as String,
          egg["color"] as Color);
    }
  }

  void _unlockSecretTheme(String theme, String message, Color backgroundColor) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    // Show an animated snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'COOL!',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );

    // Apply the theme
    themeProvider.setTheme(theme);

    // Optionally, save that this easter egg has been discovered
    _saveDiscoveredEasterEgg(theme);
  }

  Future<void> _saveDiscoveredEasterEgg(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> discoveredEggs = prefs.getStringList('discovered_eggs') ?? [];

    if (!discoveredEggs.contains(theme)) {
      discoveredEggs.add(theme);
      await prefs.setStringList('discovered_eggs', discoveredEggs);
    }
  }

  void _toggleCustomizationMode() {
    setState(() {
      _isCustomizing = !_isCustomizing;
      if (!_isCustomizing) {
        _saveKeypadLayout();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Customization toggle
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isCustomizing ? 'Drag buttons to rearrange' : 'Keypad',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(width: 8),
              Switch(
                value: _isCustomizing,
                onChanged: (value) => _toggleCustomizationMode(),
                activeColor: theme.colorScheme.primary,
              ),
            ],
          ),
        ),

        // Keypad grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.isScientific ? 5 : 4,
              childAspectRatio: widget.isScientific ? 1.0 : 1.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _keypadLayout.length,
            itemBuilder: (context, index) {
              final item = _keypadLayout[index];
              return _isCustomizing
                  ? _buildDraggableButton(item, index)
                  : _buildButton(item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDraggableButton(Map<String, dynamic> item, int index) {
    return LongPressDraggable<int>(
      data: index,
      feedback: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .colorScheme
                .primary
                .withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            item['text'],
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
      childWhenDragging: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme
              .of(context)
              .colorScheme
              .primary, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: DragTarget<int>(
        builder: (context, candidateData, rejectedData) {
          return _buildButton(item);
        },
        onAccept: (draggedIndex) {
          setState(() {
            final temp = _keypadLayout[index];
            _keypadLayout[index] = _keypadLayout[draggedIndex];
            _keypadLayout[draggedIndex] = temp;
          });
        },
      ),
    );
  }

  Widget _buildButton(Map<String, dynamic> item) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    final theme = Theme.of(context);

    // Determine button style based on value
    Color buttonColor;
    Color textColor;

    if (item['value'] == '=' || item['value'] == 'AC' || item['value'] == '⌫') {
      buttonColor = theme.colorScheme.primary;
      textColor = Colors.white;
    } else if (['÷', '×', '-', '+', '%', '^'].contains(item['value'])) {
      buttonColor = theme.colorScheme.primary.withOpacity(0.1);
      textColor = theme.colorScheme.primary;
    } else
    if (['sin', 'cos', 'tan', 'log', 'ln', '(', ')', '√', 'π', '!'].contains(
        item['value'])) {
      buttonColor = theme.colorScheme.secondary.withOpacity(0.1);
      textColor = theme.colorScheme.secondary;
    } else {
      buttonColor = theme.colorScheme.surface;
      textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    }

    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => _handleButtonPress(item['value']),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            item['text'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}