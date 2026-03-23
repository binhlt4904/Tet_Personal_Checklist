import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import '../../task/taskdetail/task_detail_screen.dart';

class TaskItemCard extends StatelessWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

  bool get isOverdue =>
      !task.isDone &&
          task.deadline != null &&
          task.deadline!.isBefore(DateTime.now());

  IconData _getIcon(String room) {
    switch (room) {
      case 'Phòng khách':
        return Icons.weekend;
      case 'Phòng ngủ':
        return Icons.bed;
      case 'Nhà bếp':
        return Icons.kitchen;
      case 'Nhà vệ sinh':
        return Icons.bathroom;
      case 'Ban công':
        return Icons.deck;
      case 'Phòng thờ':
        return Icons.self_improvement;
      default:
        return Icons.home;
    }
  }
  @override
  Widget build(BuildContext context) {
    final borderColor = task.isDone
        ? Colors.green.shade300
        : isOverdue
        ? Colors.red.shade300
        : Colors.grey.shade300;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TaskDetailScreen(task: task),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Row Title
            Row(
              children: [
                Icon(
                  task.isDone
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: task.isDone
                      ? Colors.green
                      : Colors.grey,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: null,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Chips row
            Row(
              children: [

                const SizedBox(width: 12),
                _buildChip(
                  icon: _getIcon(task.room ?? "Phòng khách"),
                  text: task.room ?? "Phòng khách",
                  backgroundColor: Colors.red.shade50,
                  textColor: Colors.red,
                  borderColor: Colors.red.shade200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip({
    required String text,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}