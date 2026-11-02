import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task_model.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../../viewmodels/theme_viewmodel.dart';
import '../widgets/color_picker_dialog.dart';
import '../widgets/task_item_card.dart';
import 'edit_task_screen.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => const ColorPickerDialog(),
    );
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String selectedIcon = 'task';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Thêm công việc mới',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Tiêu đề *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Vui lòng nhập tiêu đề';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: descController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả / Hạn chót',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Loại biểu tượng:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildIconOption('laptop', Icons.laptop_chromebook, selectedIcon, (val) {
                          setModalState(() => selectedIcon = val);
                        }),
                        _buildIconOption('book', Icons.menu_book_outlined, selectedIcon, (val) {
                          setModalState(() => selectedIcon = val);
                        }),
                        _buildIconOption('presentation', Icons.co_present_outlined, selectedIcon, (val) {
                          setModalState(() => selectedIcon = val);
                        }),
                        _buildIconOption('document', Icons.article_outlined, selectedIcon, (val) {
                          setModalState(() => selectedIcon = val);
                        }),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E3842),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final newTask = TaskModel(
                              title: titleController.text.trim(),
                              description: descController.text.trim(),
                              iconType: selectedIcon,
                            );
                            await ref.read(taskViewModelProvider.notifier).addTask(newTask);
                            if (ctx.mounted) {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Thêm công việc thành công!'),
                                  backgroundColor: Color(0xFF2E3842),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Thêm công việc',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIconOption(
    String type,
    IconData icon,
    String current,
    ValueChanged<String> onSelected,
  ) {
    final isSelected = type == current;
    return GestureDetector(
      onTap: () => onSelected(type),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E3842) : const Color(0xFFF1F3F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : const Color(0xFF2C3E50),
          size: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarColor = ref.watch(themeViewModelProvider);
    final tasksAsync = ref.watch(taskViewModelProvider);
    final filteredList = ref.watch(filteredTasksProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm công việc...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  ref.read(searchQueryProvider.notifier).updateQuery(val);
                },
              )
            : const Text(
                'Quản lý công việc',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        actions: [
          // Nút tìm kiếm
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            tooltip: 'Tìm kiếm',
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  ref.read(searchQueryProvider.notifier).updateQuery('');
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
          // Nút đổi màu thanh AppBar (palette)
          IconButton(
            icon: const Icon(
              Icons.palette_outlined,
              color: Colors.white,
            ),
            tooltip: 'Đổi màu thanh ứng dụng',
            onPressed: _showColorPicker,
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: tasksAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(
                  'Lỗi tải dữ liệu: $error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ref.read(taskViewModelProvider.notifier).refresh();
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          ),
        ),
        data: (_) {
          if (filteredList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isSearching
                        ? Icons.search_off
                        : Icons.assignment_turned_in_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isSearching
                        ? 'Không tìm thấy công việc phù hợp'
                        : 'Chưa có công việc nào',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(taskViewModelProvider.notifier).refresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 80),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final task = filteredList[index];
                return TaskItemCard(
                  task: task,
                  onEdit: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditTaskScreen(task: task),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      // Nút FloatingActionButton thêm công việc (+)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E3842),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        elevation: 4,
        onPressed: _showAddTaskDialog,
        tooltip: 'Thêm công việc mới',
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

