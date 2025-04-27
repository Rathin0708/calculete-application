import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/calculator_provider.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({Key? key}) : super(key: key);

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

          // Language settings
          const Text(
            'Language',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildLanguageSelector(context),
          const SizedBox(height: 16),

          // About section with daily challenge
          _buildAboutSection(context),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildThemeOption(
            context,
            'Light',
            Colors.blue,
            Colors.white,
                () => themeProvider.setTheme('light'),
          ),
          _buildThemeOption(
            context,
            'Dark',
            Color(0xFF1F1F1F),
            Colors.white,
                () => themeProvider.setTheme('dark'),
          ),
          _buildThemeOption(
            context,
            'Professional',
            Colors.blueGrey,
            Colors.white,
                () => themeProvider.setTheme('professional'),
          ),
          _buildThemeOption(
            context,
            'Fun',
            Colors.purple,
            Colors.white,
                () => themeProvider.setTheme('fun'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String name, Color color,
      Color textColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 70,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
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

  Widget _buildLanguageSelector(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildLanguageOption(
            context,
            'English',
            'en',
            'US',
            themeProvider.currentLocale.languageCode == 'en',
          ),
          _buildLanguageOption(
            context,
            'தமிழ் (Tamil)',
            'ta',
            'IN',
            themeProvider.currentLocale.languageCode == 'ta',
          ),
          _buildLanguageOption(
            context,
            'हिंदी (Hindi)',
            'hi',
            'IN',
            themeProvider.currentLocale.languageCode == 'hi',
          ),
          _buildLanguageOption(
            context,
            'Español (Spanish)',
            'es',
            'ES',
            themeProvider.currentLocale.languageCode == 'es',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String name,
      String languageCode, String countryCode, bool isSelected) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        themeProvider.setLocale(Locale(languageCode, countryCode));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(right: 12),
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
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme
                .of(context)
                .colorScheme
                .primary
                .withOpacity(0.5),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.color,
          ),
        ),
      ),
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