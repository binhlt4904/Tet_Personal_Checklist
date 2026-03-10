import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthNavigation extends StatelessWidget {
  final DateTime currentMonth;
  final Function(DateTime) onChangeMonth;

  const MonthNavigation({
    super.key,
    required this.currentMonth,
    required this.onChangeMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => onChangeMonth(
            DateTime(currentMonth.year, currentMonth.month - 1),
          ),
        ),
        Text(
          DateFormat("MMMM yyyy", "vi").format(currentMonth),
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => onChangeMonth(
            DateTime(currentMonth.year, currentMonth.month + 1),
          ),
        ),
      ],
    );
  }
}