import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';
import '../widgets/settings_panel.dart';
import '../widgets/history_panel.dart';
import '../widgets/ar_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSplitScreen = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Load settings and history
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CalculatorProvider>(context, listen: false).loadSettings();
      Provider.of<ThemeProvider>(context, listen: false).initPreferences();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Calculator'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.splitscreen),
            onPressed: () {
              setState(() {
                _isSplitScreen = !_isSplitScreen;
              });
            },
            tooltip: 'Split Screen',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const SettingsPanel(),
              );
            },
            tooltip: 'Settings',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.calculate), text: 'Basic'),
            Tab(icon: Icon(Icons.science), text: 'Scientific'),
            Tab(icon: Icon(Icons.history), text: 'History'),
            Tab(icon: Icon(Icons.camera_alt), text: 'AR Scan'),
          ],
        ),
      ),
      body: _isSplitScreen
          ? _buildSplitScreenView()
          : TabBarView(
        controller: _tabController,
        children: [
          _buildCalculatorView(isScientific: false),
          _buildCalculatorView(isScientific: true),
          const HistoryPanel(),
          const ARScanner(),
        ],
      ),
    );
  }

  Widget _buildCalculatorView({required bool isScientific}) {
    return Column(
      children: [
        const CalculatorDisplay(),
        Expanded(
          child: CalculatorKeypad(isScientific: isScientific),
        ),
      ],
    );
  }

  Widget _buildSplitScreenView() {
    return Row(
      children: [
        Expanded(
          child: _buildCalculatorView(isScientific: false),
        ),
        const VerticalDivider(width: 1, thickness: 1),
        Expanded(
          child: _buildCalculatorView(isScientific: true),
        ),
      ],
    );
  }
}