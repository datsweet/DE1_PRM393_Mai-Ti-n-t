import 'package:flutter/material.dart';
import '../../models/task_model.dart';

class TaskItemCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onEdit;

  const TaskItemCard({
    super.key,
    required this.task,
    required this.onEdit,
  });

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'laptop':
        return Icons.laptop_chromebook;
      case 'book':
        return Icons.menu_book_outlined;
      case 'presentation':
        return Icons.co_present_outlined;
      case 'document':
        return Icons.article_outlined;
      default:
        return Icons.assignment_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onEdit,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Icon bên trái
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F3F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getIconForType(task.iconType),
                    color: const Color(0xFF2C3E50),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),

                // Tiêu đề và Mô tả (có icon lịch phía trước)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: task.isCompleted
                              ? Colors.grey.shade600
                              : const Color(0xFF1F2937),
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 13,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              task.description,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Biểu tượng Edit (bút chì) bên phải
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF374151),
                    size: 20,
                  ),
                  tooltip: 'Chỉnh sửa',
                  onPressed: onEdit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

