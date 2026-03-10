import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_personal_checklist/core/widgets/header.dart';
import '../../../domain/entities/task.dart';
import 'widgets/edit_task_body.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF6F4EDDD),
      body: SafeArea(
        child: Column(
          children: [
            Header(
              title: 'Chỉnh Sửa Công Việc',
              description: 'Cập nhật thông tin công việc của bạn',
              onBackPressed: () => Navigator.pop(context, true),
            ),
            Expanded(
              child: EditTaskBody(task: task),
            ),
          ],
        ),
      ),
    );
  }
}