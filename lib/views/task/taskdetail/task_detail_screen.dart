import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_personal_checklist/views/task/taskdetail/widgets/task_detail_body.dart';

import '../../../core/widgets/header.dart';
import '../../../domain/entities/task.dart';
import '../../../viewmodels/home/home_viewmodel.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final updatedTask =task;

    return Scaffold(
      backgroundColor: const Color(0xF6F4EDDD),
      body: SafeArea(
        child: Column(
          children: [
            Header(
              title: 'Chi Tiết Công Việc',
              description: 'Xem thông tin và cập nhật tiến độ',
              onBackPressed: () => Navigator.pop(context, true),
            ),
            Expanded(
              child: TaskDetailBody(task: updatedTask),
            ),
          ],
        ),
      ),
    );
  }
}