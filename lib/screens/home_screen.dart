import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';
import '../widgets/settings_panel.dart';
import '../widgets/history_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.initialTabIndex = 0}) : super(key: key);

  final int initialTabIndex;

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
    _tabController = TabController(
        length: 3,
        vsync: this,
        initialIndex: widget.initialTabIndex < 3 ? widget.initialTabIndex : 0
    );

    // Add listener for tab changes
    _tabController.addListener(() {
      // This will force a rebuild when tab changes
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    // Load settings and history
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CalculatorProvider>(context, listen: false).loadSettings();
      Provider.of<ThemeProvider>(context, listen: false).initPreferences();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
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
          labelColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          unselectedLabelColor: Theme
              .of(context)
              .colorScheme
              .onPrimary
              .withOpacity(0.7),
          indicatorColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          splashBorderRadius: BorderRadius.circular(20),
          dividerColor: Colors.transparent,
          enableFeedback: true,
          tabs: [
            _buildTab(Icons.calculate, 'Basic', 0),
            _buildTab(Icons.science, 'Scientific', 1),
            _buildTab(Icons.history, 'History', 2),
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
        ],
      ),
    );
  }

  Widget _buildTab(IconData icon, String text, int index) {
    final isSelected = _tabController.index == index;
    final color = isSelected
        ? Theme
        .of(context)
        .colorScheme
        .secondary
        : Theme
        .of(context)
        .colorScheme
        .onPrimary
        .withOpacity(0.7);

    return Tab(
      icon: Icon(
        icon,
        color: color,
        size: isSelected ? 28 : 24,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: isSelected ? 13 : 12,
          ),
        ),
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