import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import 'widgets/add_task_form.dart';

class AddTaskSheet extends StatelessWidget {
  final Function(Task) onAdd;

  const AddTaskSheet({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Drag handle
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          AddTaskForm(onAdd: onAdd),
        ],
      ),
    );
  }
}