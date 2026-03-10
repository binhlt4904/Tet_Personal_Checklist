import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/home/home_viewmodel.dart';
import 'empty_task_box.dart';
import 'task_item_card.dart';

class TaskListSection extends StatelessWidget {
  final DateTime selectedDate;

  const TaskListSection({
    super.key,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    final tasksOfDay = vm.tasks.where((task) {
      return task.deadline?.year == selectedDate.year &&
          task.deadline?.month == selectedDate.month &&
          task.deadline?.day == selectedDate.day;
    }).toList();

    if (tasksOfDay.isEmpty) {
      return const EmptyTaskBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Date title
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  color: Colors.indigo),
              const SizedBox(width: 12),
              Text(
                DateFormat("EEEE, d 'tháng' M, yyyy", "vi")
                    .format(selectedDate),
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// Task cards
          ...tasksOfDay.map(
                (task) => TaskItemCard(task: task),
          ),
        ],
      ),
    );
  }
}