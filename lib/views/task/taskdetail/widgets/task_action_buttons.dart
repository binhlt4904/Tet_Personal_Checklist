import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/task.dart';
import '../../../../viewmodels/home/home_viewmodel.dart';
import '../../taskedit/edit_task_screen.dart';

class TaskActionButtons extends StatelessWidget {
  final Task task;

  const TaskActionButtons({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTaskScreen(task: task),
                ),
              );

              if (result == true) {
                await vm.refresh();
              }
            },
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              "Chỉnh sửa",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              await vm.delete(task.id!);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete, color: Colors.white),
            label: const Text(
              "Xóa",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}