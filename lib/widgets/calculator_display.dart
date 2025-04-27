import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Input field with horizontal scrolling
          Container(
            height: 40,
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                calculatorProvider.input.isEmpty ? '0' : calculatorProvider
                    .input,
                style: GoogleFonts.robotoMono(
                  fontSize: 24,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Result field with horizontal scrolling
          Container(
            height: 60,
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                calculatorProvider.output,
                style: GoogleFonts.robotoMono(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          // Smart solver input field (expandable)
          GestureDetector(
            onTap: () => _showSmartSolverDialog(context),
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Smart Solver (e.g., "What is 25% of 350?")',
                      style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(
                            0.7),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSmartSolverDialog(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(
        context, listen: false);
    String query = '';

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Smart Solver'),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Type your math question',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                query = value;
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (query.isNotEmpty) {
                    calculatorProvider.setInput(query);
                    calculatorProvider.calculate();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Solve'),
              ),
            ],
          ),
    );
  }
}