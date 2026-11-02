import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/database_helper.dart';
import '../models/task_model.dart';

part 'task_viewmodel.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }
}

@riverpod
class TaskViewModel extends _$TaskViewModel {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<List<TaskModel>> build() async {
    return await _fetchTasks();
  }

  Future<List<TaskModel>> _fetchTasks() async {
    return await _dbHelper.getTasks();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchTasks());
  }

  Future<bool> updateTask(TaskModel task) async {
    try {
      final rowsAffected = await _dbHelper.updateTask(task);
      if (rowsAffected > 0) {
        final updatedList = await _fetchTasks();
        state = AsyncValue.data(updatedList);
        return true;
      }
      return false;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> addTask(TaskModel task) async {
    try {
      final id = await _dbHelper.insertTask(task);
      if (id > 0) {
        final updatedList = await _fetchTasks();
        state = AsyncValue.data(updatedList);
        return true;
      }
      return false;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteTask(int id) async {
    try {
      final rowsAffected = await _dbHelper.deleteTask(id);
      if (rowsAffected > 0) {
        final updatedList = await _fetchTasks();
        state = AsyncValue.data(updatedList);
        return true;
      }
      return false;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

@riverpod
List<TaskModel> filteredTasks(Ref ref) {
  final tasksAsync = ref.watch(taskViewModelProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();

  return tasksAsync.maybeWhen(
    data: (tasks) {
      if (query.isEmpty) return tasks;
      return tasks.where((t) {
        return t.title.toLowerCase().contains(query) ||
            t.description.toLowerCase().contains(query);
      }).toList();
    },
    orElse: () => [],
  );
}
