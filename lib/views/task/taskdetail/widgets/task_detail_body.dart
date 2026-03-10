import 'package:flutter/material.dart';

import '../../../../domain/entities/task.dart';
import 'task_status_section.dart';
import 'task_info_section.dart';
import 'task_action_buttons.dart';
import 'task_tip_card.dart';

class TaskDetailBody extends StatelessWidget {
  final Task task;

  const TaskDetailBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TaskStatusSection(task: task),
                const SizedBox(height: 24),
                const TaskTipCard(),
                const SizedBox(height: 30),
                TaskInfoSection(task: task),
                const SizedBox(height: 24),
                TaskActionButtons(task: task),


              ],
            ),
          ),
        ),
      ),
    );
  }
} 