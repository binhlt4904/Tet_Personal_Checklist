import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../domain/entities/task.dart';
import '../../../../viewmodels/home/home_viewmodel.dart';
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
  final _formKey = GlobalKey<FormState>();

  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  String _room = 'Phòng khách';
  DateTime? _deadline;

  String? _deadlineError;

  void _submit() {
    setState(() {
      _deadlineError = null;
    });

    // validate form
    if (!_formKey.currentState!.validate()) return;

    // validate deadline
    if (_deadline == null) {
      setState(() {
        _deadlineError = "Vui lòng chọn deadline";
      });
      return;
    }

    // ❗ không được chọn quá khứ
    if (_deadline!.isBefore(DateTime.now())) {
      setState(() {
        _deadlineError = "Deadline không được trong quá khứ";
      });
      return;
    }
    final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
    final task = Task(
      title: _titleCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      room: _room,
      deadline: _deadline,
      isDone: false,
      userId: userId,
    );
    widget.onAdd(task);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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

            // 👇 bạn cần sửa AddTaskFields để hỗ trợ validator
            AddTaskFields(
              titleController: _titleCtrl,
              descriptionController: _descriptionCtrl,
              room: _room,
              onRoomChanged: (v) => setState(() => _room = v),

              // thêm validator
              titleValidator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập tiêu đề";
                }
                if (value.trim().length < 3) {
                  return "Tiêu đề tối thiểu 3 ký tự";
                }
                return null;
              },
              descriptionValidator: (value) {
                if (value != null && value.length > 200) {
                  return "Mô tả tối đa 200 ký tự";
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            AddTaskDeadlinePicker(
              deadline: _deadline,
              onPick: (value) => setState(() => _deadline = value),
            ),

            // 👇 hiển thị lỗi deadline
            if (_deadlineError != null) ...[
              const SizedBox(height: 6),
              Text(
                _deadlineError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],

            const SizedBox(height: 20),

            AddTaskButton(onPressed: _submit),
          ],
        ),
      ),
    );
  }
}