import 'package:flutter/material.dart';
import 'package:test_personal_checklist/views/calendar/widgets/week_days_row.dart';

import 'calendar_legend.dart';
import 'days_grid.dart';
import 'month_navigation.dart';

class CalendarCard extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime selectedDate;
  final Function(DateTime) onSelectDate;
  final Function(DateTime) onChangeMonth;

  const CalendarCard({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onChangeMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 15)
        ],
      ),
      child: Column(
        children: [
          MonthNavigation(
            currentMonth: currentMonth,
            onChangeMonth: onChangeMonth,
          ),
          const SizedBox(height: 20),
          const WeekDaysRow(),
          const SizedBox(height: 10),
          DaysGrid(
            currentMonth: currentMonth,
            selectedDate: selectedDate,
            onSelectDate: onSelectDate,
          ),
          const Divider(height: 30),
          const CalendarLegend(),
        ],
      ),
    );
  }
}