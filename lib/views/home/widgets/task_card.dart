import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    void _confirmDelete(BuildContext context) {
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

                        /// Title
                        const Text(
                          "Xóa công việc?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// Content
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

                        /// Buttons
                        Row(
                          children: [
                            /// Cancel
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Hủy",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// Delete
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  onDelete();
                                },
                                child: const Text(
                                  "Xóa",
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
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

        /// Animation mượt hơn
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Checkbox
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 26,
              height: 26,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400, width: 2),
                color: task.isDone ? Colors.green : Colors.transparent,
              ),
              child: task.isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),

          const SizedBox(width: 14),

          /// Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Actions cùng 1 hàng
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,

                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// Actions
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _actionIcon(
                          icon: Icons.visibility_outlined,
                          onTap: onView,
                        ),
                        _actionIcon(
                          icon: Icons.edit_outlined,
                          onTap: onEdit,
                        ),
                        _actionIcon(
                          icon: Icons.delete_outline,
                          onTap: () => _confirmDelete(context),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                /// Description
                if (task.description != null &&
                    task.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      task.description!,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                /// Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    ..._buildDeadlineTag(),

                    if (task.deadline != null)
                      _tag(
                        "${task.deadline!.day}-${task.deadline!.month}",
                        Colors.blueGrey,
                        icon: Icons.calendar_today,
                      ),

                    _tag(
                      task.room,
                      Colors.redAccent,
                      icon: Icons.restaurant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Icon nhỏ gọn
  Widget _actionIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 20, color: Colors.black54),
      ),
    );
  }

  /// Tag
  Widget _tag(String text, Color color, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDeadlineTag() {
    if (task.deadline == null || task.isDone) return [];

    final now = DateTime.now();
    final deadline = task.deadline!.toLocal();
    final diffMinutes = deadline.difference(now).inMinutes;
    final diffDays = deadline.difference(now).inDays;

    if (diffMinutes <= 0) {
      return [
        _tag("QUÁ HẠN", Colors.red, icon: Icons.warning_amber_rounded),
      ];
    } else if (diffDays <= 1) {
      return [
        _tag("SẮP ĐẾN HẠN", Colors.orange, icon: Icons.schedule),
      ];
    }

    return [];
  }
}