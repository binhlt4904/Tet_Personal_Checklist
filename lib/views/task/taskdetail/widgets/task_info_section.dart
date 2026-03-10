import 'package:flutter/material.dart';
import '../../../../domain/entities/task.dart';
import 'task_info_card.dart';

class TaskInfoSection extends StatelessWidget {
  final Task task;

  const TaskInfoSection({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        TaskInfoCard(
          title: "MÔ TẢ",
          content: task.description ?? "Không có mô tả",
        ),

        const SizedBox(height: 16),

        TaskInfoCard(
          title: "KHU VỰC",
          content: task.room,
          icon: Icons.location_on,
        ),

        const SizedBox(height: 16),

        TaskInfoCard(
          title: "HẠN HOÀN THÀNH",
          content: task.deadline != null
              ? "${task.deadline!.day}/${task.deadline!.month}/${task.deadline!.year}"
              : "Không có",
          icon: Icons.calendar_today,
        ),

        const SizedBox(height: 16),

        TaskInfoCard(
          title: "THỜI GIAN CÒN LẠI",
          content: _remainingTime(task.deadline),
          icon: Icons.timer,
        ),
      ],
    );
  }

  String _remainingTime(DateTime? deadline) {
    if (deadline == null) return "Không có";
    final diff = deadline.difference(DateTime.now()).inDays;

    if (diff < 0) return "Quá hạn ${diff.abs()} ngày";
    if (diff == 0) return "Hôm nay";
    return "Còn $diff ngày";
  }
}