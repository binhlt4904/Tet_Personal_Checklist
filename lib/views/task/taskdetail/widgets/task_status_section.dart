import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/entities/task.dart';
import '../../../../viewmodels/home/home_viewmodel.dart';

class TaskStatusSection extends StatelessWidget {
  final Task task;

  const TaskStatusSection({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: task.isDone
            ? Colors.green.withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// LEFT SIDE
          Expanded(
            child: Row(
              children: [
                Icon(
                  task.isDone
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: task.isDone ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),

                /// 👇 QUAN TRỌNG
                Expanded(
                  child: Text(
                    task.isDone
                        ? "Đã hoàn thành"
                        : "Chưa hoàn thành",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:
                      task.isDone ? Colors.green : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          /// BUTTON
          Flexible(
            child: FittedBox(
              child: ElevatedButton(
                onPressed: () async {
                  await vm.toggleStatus(task);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: task.isDone
                      ? Colors.orange
                      : const Color(0xFFD32F2F),
                ),
                child: Text(
                  task.isDone
                      ? "Đánh dấu chưa xong"
                      : "Đánh dấu hoàn thành",
                style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}