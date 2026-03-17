import 'package:flutter/material.dart';
import '../../data/interfaces/task_repository.dart';
import '../../domain/entities/task.dart';

class HomeViewModel extends ChangeNotifier {
  final TaskRepository repository;

  HomeViewModel(this.repository) {
    loadTasks();
  }

  List<Task> _tasks = [];
  String filterRoom = 'Tất cả';

  // ========================
  // GETTERS
  // ========================

  List<Task> get allTasks => _tasks;

  List<Task> get tasks => filterRoom == 'Tất cả'
      ? _tasks
      : _tasks.where((t) => t.room == filterRoom).toList();

  int get totalCount => tasks.length;

  int get completedCount =>
      tasks.where((t) => t.isDone).length;

  double get progress =>
      totalCount == 0 ? 0 : completedCount / totalCount;

  // ========================
  // LOAD
  // ========================

  Future<void> loadTasks() async {
    _tasks = await repository.getTasks();
    notifyListeners();
  }

  // ========================
  // ADD
  // ========================

  Future<void> add(Task task) async {
    await repository.insert(task);

    // reload lại từ server (đảm bảo có id mới)
    await loadTasks();
  }

  // ========================
  // TOGGLE DONE
  // ========================

  Future<void> toggle(Task task) async {
    final updated = task.copyWith(isDone: !task.isDone);

    await repository.update(updated);

    // update local luôn cho mượt UI
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = updated;
      notifyListeners();
    }
  }

  // ========================
  // DELETE
  // ========================

  Future<void> delete(String id) async {
    await repository.delete(id);

    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  // ========================
  // UPDATE
  // ========================

  Future<void> update(Task updatedTask) async {
    await repository.update(updatedTask);

    final index = _tasks.indexWhere((t) => t.id == updatedTask.id);

    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  // ========================
  // FILTER
  // ========================

  void setFilterRoom(String room) {
    filterRoom = room;
    notifyListeners();
  }

  // ========================
  // REFRESH
  // ========================

  Future<void> refresh() async {
    await loadTasks();
  }
}