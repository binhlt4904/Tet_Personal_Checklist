import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/task.dart';
import '../../../viewmodels/home/home_viewmodel.dart';
import 'task_card.dart';
import '../../task/taskdetail/task_detail_screen.dart';
import '../../task/taskedit/edit_task_screen.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();
    void _showLoading(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  "Đang xóa...",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (_, index) {
        final task = tasks[index];

        return TaskCard(
          task: task,
          onToggle: () => vm.toggle(task),
          onView: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TaskDetailScreen(task: task),
              ),
            );
          },
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditTaskScreen(task: task),
              ),
            );
          },
          onDelete: () async {
            _showLoading(context);

            try {
              await vm.delete(task.id!); // 👈 gọi delete thật

              Navigator.pop(context); // đóng loading

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Đã xóa thành công"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
              );
            } catch (e) {
              Navigator.pop(context); // đóng loading

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Xóa thất bại")),
              );
            }
          },
        );
      },
    );
  }
}