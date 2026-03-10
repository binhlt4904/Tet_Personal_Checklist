import 'package:flutter/material.dart';
import '../../../../domain/entities/task.dart';
import 'edit_task_form.dart';

class EditTaskBody extends StatelessWidget {
  final Task task;

  const EditTaskBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: EditTaskForm(task: task),
        ),
      ),
    );
  }
}