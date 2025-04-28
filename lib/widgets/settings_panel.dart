import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/calculator_provider.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({Key? key}) : super(key: key);

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  String _selectedThemeCategory = 'All';

  final List<String> _themeCategories = [
    'All',
    'Light',
    'Dark',
    'Colorful',
    'Nature',
    'Basic'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          // Theme settings
          const Text(
            'App Theme',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildThemeSelector(context),
          const SizedBox(height: 16),

          // Sound settings
          const Text(
            'Sound Settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildSoundSettings(context),
          const SizedBox(height: 16),

          // About section with daily challenge
          _buildAboutSection(context),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Define theme categories
    final Map<String, List<Map<String, dynamic>>> themesByCategory = {
      'All': [],
      'Light': [
        {'name': 'Light', 'color': Colors.blue, 'theme': 'light'},
        {
          'name': 'Professional',
          'color': Colors.blueGrey,
          'theme': 'professional'
        },
        {'name': 'Mint', 'color': Color(0xFF00BFA5), 'theme': 'mint'},
        {'name': 'Sunset', 'color': Color(0xFFFF7043), 'theme': 'sunset'},
        {'name': 'Forest', 'color': Color(0xFF2E7D32), 'theme': 'forest'},
        {'name': 'Lavender', 'color': Color(0xFF673AB7), 'theme': 'lavender'},
        {'name': 'Coffee', 'color': Color(0xFF795548), 'theme': 'coffee'},
      ],
      'Dark': [
        {'name': 'Dark', 'color': Color(0xFF1F1F1F), 'theme': 'dark'},
        {
          'name': 'Deep Ocean',
          'color': Color(0xFF0D47A1),
          'theme': 'deep_ocean'
        },
        {'name': 'Midnight', 'color': Color(0xFF263238), 'theme': 'midnight'},
      ],
      'Colorful': [
        {'name': 'Fun', 'color': Colors.purple, 'theme': 'fun'},
        {'name': 'Colorful', 'color': Color(0xFFE040FB), 'theme': 'colorful'},
        {'name': 'Berry', 'color': Color(0xFF9C27B0), 'theme': 'berry'},
        {'name': 'Coral', 'color': Color(0xFFE91E63), 'theme': 'coral'},
        {'name': 'Amber', 'color': Color(0xFFFFA000), 'theme': 'amber'},
      ],
      'Nature': [
        {'name': 'Forest', 'color': Color(0xFF2E7D32), 'theme': 'forest'},
        {'name': 'Mint', 'color': Color(0xFF00BFA5), 'theme': 'mint'},
        {'name': 'Aqua', 'color': Color(0xFF00ACC1), 'theme': 'aqua'},
        {'name': 'Emerald', 'color': Color(0xFF00897B), 'theme': 'emerald'},
        {
          'name': 'Deep Ocean',
          'color': Color(0xFF0D47A1),
          'theme': 'deep_ocean'
        },
      ],
      'Basic': [
        {'name': 'Light', 'color': Colors.blue, 'theme': 'light'},
        {'name': 'Dark', 'color': Color(0xFF1F1F1F), 'theme': 'dark'},
        {'name': 'Ruby', 'color': Color(0xFFD32F2F), 'theme': 'ruby'},
        {'name': 'Royal', 'color': Color(0xFF3F51B5), 'theme': 'royal'},
      ],
    };

    // Populate the "All" category with all themes
    themesByCategory['All'] = [
      {'name': 'Light', 'color': Colors.blue, 'theme': 'light'},
      {'name': 'Dark', 'color': Color(0xFF1F1F1F), 'theme': 'dark'},
      {
        'name': 'Professional',
        'color': Colors.blueGrey,
        'theme': 'professional'
      },
      {'name': 'Fun', 'color': Colors.purple, 'theme': 'fun'},
      {'name': 'Colorful', 'color': Color(0xFFE040FB), 'theme': 'colorful'},
      {'name': 'Mint', 'color': Color(0xFF00BFA5), 'theme': 'mint'},
      {'name': 'Deep Ocean', 'color': Color(0xFF0D47A1), 'theme': 'deep_ocean'},
      {'name': 'Sunset', 'color': Color(0xFFFF7043), 'theme': 'sunset'},
      {'name': 'Forest', 'color': Color(0xFF2E7D32), 'theme': 'forest'},
      {'name': 'Berry', 'color': Color(0xFF9C27B0), 'theme': 'berry'},
      {'name': 'Coffee', 'color': Color(0xFF795548), 'theme': 'coffee'},
      {'name': 'Midnight', 'color': Color(0xFF263238), 'theme': 'midnight'},
      {'name': 'Lavender', 'color': Color(0xFF673AB7), 'theme': 'lavender'},
      {'name': 'Coral', 'color': Color(0xFFE91E63), 'theme': 'coral'},
      {'name': 'Amber', 'color': Color(0xFFFFA000), 'theme': 'amber'},
      {'name': 'Aqua', 'color': Color(0xFF00ACC1), 'theme': 'aqua'},
      {'name': 'Ruby', 'color': Color(0xFFD32F2F), 'theme': 'ruby'},
      {'name': 'Emerald', 'color': Color(0xFF00897B), 'theme': 'emerald'},
      {'name': 'Royal', 'color': Color(0xFF3F51B5), 'theme': 'royal'},
    ];

    final List<Map<String,
        dynamic>> displayThemes = themesByCategory[_selectedThemeCategory] ??
        [];

    return Column(
      children: [
        // Category Selector
        Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _themeCategories.length,
            itemBuilder: (context, index) {
              final category = _themeCategories[index];
              final isSelected = _selectedThemeCategory == category;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedThemeCategory = category;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme
                        .of(context)
                        .colorScheme
                        .primary
                        : Theme
                        .of(context)
                        .colorScheme
                        .surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )
                    ] : null,
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Theme
                          .of(context)
                          .colorScheme
                          .onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight
                          .normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Theme Grid
        SizedBox(
          height: 180,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: displayThemes.length,
            itemBuilder: (context, index) {
              final theme = displayThemes[index];
              return _buildThemeOption(
                context,
                theme['name'],
                theme['color'],
                Colors.white,
                    () => themeProvider.setTheme(theme['theme']),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildThemeOption(BuildContext context, String name, Color color,
      Color textColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildSoundSettings(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);

    return Column(
      children: [
        // Sound toggle
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Button Sounds'),
          value: calculatorProvider.isSoundEnabled,
          onChanged: (value) => calculatorProvider.toggleSound(value),
        ),

        // Sound theme selector
        if (calculatorProvider.isSoundEnabled)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sound Theme:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildSoundThemeChip(context, 'Default',
                      calculatorProvider.soundTheme == 'default',
                          () => calculatorProvider.setSoundTheme('default')),
                  _buildSoundThemeChip(context, 'Retro',
                      calculatorProvider.soundTheme == 'retro',
                          () => calculatorProvider.setSoundTheme('retro')),
                  _buildSoundThemeChip(context, 'Bubble',
                      calculatorProvider.soundTheme == 'bubble',
                          () => calculatorProvider.setSoundTheme('bubble')),
                  _buildSoundThemeChip(context, 'Techy',
                      calculatorProvider.soundTheme == 'techy',
                          () => calculatorProvider.setSoundTheme('techy')),
                ],
              ),
            ],
          ),

        // Read aloud toggle
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Read Results Aloud'),
          value: calculatorProvider.isReadAloudEnabled,
          onChanged: (value) => calculatorProvider.toggleReadAloud(value),
        ),
      ],
    );
  }

  Widget _buildSoundThemeChip(BuildContext context, String name,
      bool isSelected, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(name),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          onTap();
        }
      },
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .colorScheme
            .surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Daily Challenge',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Solve this: If a triangle has sides of 5, 12, and 13 units, what is its area?',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final calculatorProvider = Provider.of<CalculatorProvider>(
                  context, listen: false);
              // Set up calculation for triangle area (using Heron's formula)
              calculatorProvider.setInput(
                  '√(s*(s-a)*(s-b)*(s-c)) where s=(a+b+c)/2, a=5, b=12, c=13');
              Navigator.pop(context);
            },
            child: const Text('Try This Challenge'),
          ),
        ],
      ),
    );
  }
}