import 'package:flutter/material.dart';

class AddTaskDeadlinePicker extends StatelessWidget {
  final DateTime? deadline;
  final Function(DateTime) onPick;

  const AddTaskDeadlinePicker({
    super.key,
    required this.deadline,
    required this.onPick,
  });

  Future<void> _pick(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: deadline ?? DateTime.now(),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final result = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    onPick(result);
  }

  String _format(DateTime d) {
    return "${d.day}/${d.month}/${d.year} "
        "${d.hour.toString().padLeft(2, '0')}:"
        "${d.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pick(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18),
            const SizedBox(width: 8),
            Text(
              deadline == null ? "Chọn deadline" : _format(deadline!),
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}