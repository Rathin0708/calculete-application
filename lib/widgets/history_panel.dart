import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class HistoryPanel extends StatelessWidget {
  const HistoryPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    final history = calculatorProvider.history;

    return Column(
      children: [
        // History header and clear button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Calculation History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                ),
              ),
              TextButton.icon(
                onPressed: () => calculatorProvider.clearHistory(),
                icon: const Icon(Icons.delete_outline),
                label: const Text('Clear'),
              ),
            ],
          ),
        ),

        // History list
        Expanded(
          child: history.isEmpty
              ? _buildEmptyHistory()
              : ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              // Display in reverse order (most recent first)
              final item = history[history.length - 1 - index];
              return _buildHistoryItem(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 72,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No calculation history yet',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, Map<String, dynamic> item) {
    final calculatorProvider = Provider.of<CalculatorProvider>(
        context, listen: false);
    DateTime timestamp = DateTime.parse(item['timestamp']);
    // Format date manually without using intl package
    String formattedDate = _formatDate(timestamp);
    List<String> steps = List<String>.from(item['steps'] ?? []);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          item['input'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '= ${item['output']}\n$formattedDate',
          style: TextStyle(
            color: Theme
                .of(context)
                .colorScheme
                .secondary,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.replay),
          tooltip: 'Reuse this calculation',
          onPressed: () {
            calculatorProvider.setInput(item['input']);
            calculatorProvider.calculate();
          },
        ),
        children: [
          // Step-by-step solution
          if (steps.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step-by-Step Solution:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...steps.map((step) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('• $step'),
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to format date without intl package
  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final month = months[date.month - 1];
    final day = date.day;
    final year = date.year;

    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date
        .hour);
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$month $day, $year • $hour:$minute $period';
  }
}