import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/task.dart';
import '../../../viewmodels/home/home_viewmodel.dart';
import 'task_card.dart';
import '../../task/taskdetail/task_detail_screen.dart';
import '../../task/taskedit/edit_task_screen.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (_, index) {
        final task = tasks[index];

        return TaskCard(
          task: task,
          onToggle: () => vm.toggle(task),
          onView: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TaskDetailScreen(task: task),
              ),
            );
          },
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditTaskScreen(task: task),
              ),
            );
          },
          onDelete: () => vm.delete(task.id!),
        );
      },
    );
  }
}