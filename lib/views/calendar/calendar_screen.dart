import 'package:flutter/material.dart';
import 'package:test_personal_checklist/views/calendar/widgets/calendar_card.dart';
import 'package:test_personal_checklist/views/calendar/widgets/task_list_section.dart';

import '../../core/widgets/header.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime currentMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF6F4EDDD),
      body: SafeArea(
        child: Column(
          children: [
            const Header(
              title: 'Lịch Công Việc',
              description: 'Xem công việc theo ngày',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CalendarCard(
                      currentMonth: currentMonth,
                      selectedDate: selectedDate,
                      onSelectDate: (date) {
                        setState(() => selectedDate = date);
                      },
                      onChangeMonth: (month) {
                        setState(() => currentMonth = month);
                      },
                    ),
                    TaskListSection(selectedDate: selectedDate),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}