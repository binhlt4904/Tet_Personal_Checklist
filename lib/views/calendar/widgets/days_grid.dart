import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/home/home_viewmodel.dart';

class DaysGrid extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime selectedDate;
  final Function(DateTime) onSelectDate;

  const DaysGrid({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    final firstDay =
    DateTime(currentMonth.year, currentMonth.month, 1);

    final daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;

    final startWeekday = firstDay.weekday % 7;

    List<Widget> children = [];

    for (int i = 0; i < startWeekday; i++) {
      children.add(const SizedBox());
    }


    for (int day = 1; day <= daysInMonth; day++) {
      final date =
      DateTime(currentMonth.year, currentMonth.month, day);

      final tasksOfDay = vm.allTasks.where((task) {
        return task.deadline?.year == date.year &&
            task.deadline?.month == date.month &&
            task.deadline?.day == date.day;
      }).toList();

      final now = DateTime.now();


      final overdueCount = tasksOfDay.where((t) =>
      t.deadline != null &&
          t.deadline!.toLocal().difference(now).inMinutes <= 120 &&
          !t.isDone).length;

      final incompleteCount = tasksOfDay.where((t) =>
      !t.isDone &&
          (t.deadline == null || t.deadline!.toLocal().difference(now).inMinutes > 120)).length;
      final completedCount =
          tasksOfDay.where((t) => t.isDone).length;

      final isSelected =
          selectedDate.year == date.year &&
              selectedDate.month == date.month &&
              selectedDate.day == date.day;

      children.add(
        GestureDetector(
          onTap: () => onSelectDate(date),
          child: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFD32F2F)
                  : null,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Text(
                  "$day",
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      overdueCount,
                          (_) => _dot(isSelected ? Colors.white : Colors.red),
                    ),

                    ...List.generate(
                      incompleteCount,
                          (_) => _dot(isSelected ? Colors.white : Colors.orange),
                    ),

                    ...List.generate(
                      completedCount,
                          (_) => _dot(isSelected ? Colors.white : Colors.green),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _dot(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
          color: color, shape: BoxShape.circle),
    );
  }
}