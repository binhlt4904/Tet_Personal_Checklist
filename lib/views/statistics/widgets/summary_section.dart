import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import 'summary_card.dart';

class SummarySection extends StatelessWidget {
  final List<Task> tasks;

  const SummarySection({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final done = tasks.where((t) => t.isDone).length;
    final doing =
        tasks.where((t) => !t.isDone && t.deadline!.isAfter(now)).length;
    final overdue =
        tasks.where((t) => !t.isDone && t.deadline!.isBefore(now)).length;

    final percent =
    tasks.isEmpty ? 0 : ((done / tasks.length) * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.check_circle,
                  title: "Đã hoàn thành",
                  value: done.toString(),
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  icon: Icons.access_time,
                  title: "Đang làm",
                  value: doing.toString(),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.gps_fixed,
                  title: "Quá hạn",
                  value: overdue.toString(),
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  icon: Icons.bolt,
                  title: "Tỉ lệ hoàn thành",
                  value: "$percent%",
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}