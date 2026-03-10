import 'package:flutter/material.dart';
import '../../../../domain/entities/task.dart';
import 'add_task_fields.dart';
import 'add_task_deadline_picker.dart';
import 'add_task_button.dart';

class AddTaskForm extends StatefulWidget {
  final Function(Task) onAdd;

  const AddTaskForm({super.key, required this.onAdd});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  String _room = 'Phòng khách';
  DateTime? _deadline;

  void _submit() {
    if (_titleCtrl.text.trim().isEmpty) return;

    final task = Task(
      title: _titleCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      room: _room,
      deadline: _deadline,
      isDone: false,
    );

    widget.onAdd(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.task_alt, color: Colors.red),
              ),
              const SizedBox(width: 12),
              const Text(
                "Thêm việc mới",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          AddTaskFields(
            titleController: _titleCtrl,
            descriptionController: _descriptionCtrl,
            room: _room,
            onRoomChanged: (v) => setState(() => _room = v),
          ),

          const SizedBox(height: 14),

          AddTaskDeadlinePicker(
            deadline: _deadline,
            onPick: (value) => setState(() => _deadline = value),
          ),

          const SizedBox(height: 20),

          AddTaskButton(onPressed: _submit),
        ],
      ),
    );
  }
}