import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/task.dart';
import '../../../../viewmodels/home/home_viewmodel.dart';
import '../../taskedit/edit_task_screen.dart';

class TaskActionButtons extends StatelessWidget {
  final Task task;

  const TaskActionButtons({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();
    void _showLoading(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    void _confirmDelete(BuildContext context, HomeViewModel vm) {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Delete",
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Icon
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          "Xóa công việc?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Hành động này không thể hoàn tác.\nBạn có chắc chắn muốn xóa?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Hủy", style: TextStyle(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context); // đóng confirm

                                  _showLoading(context);

                                  try {
                                    await vm.delete(task.id!).timeout(
                                      const Duration(seconds: 2),
                                    ); // 👈 tránh treo vô hạn

                                    if (context.mounted) {
                                      Navigator.pop(context); // đóng loading

                                      Navigator.pop(context); // back về home

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
                                    }
                                  } catch (e) {
                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Xóa thất bại"),
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Xóa", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

        transitionBuilder: (context, animation, secondaryAnimation, child) {
          final curved = Curves.easeOutBack.transform(animation.value);

          return Transform.scale(
            scale: curved,
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          );
        },
      );
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTaskScreen(task: task),
                ),
              );

              if (result == true) {
                await vm.refresh();
              }
            },
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              "Chỉnh sửa",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              _confirmDelete(context, vm);
            },
            icon: const Icon(Icons.delete, color: Colors.white),
            label: const Text(
              "Xóa",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}