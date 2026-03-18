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
  bool isLoading = true;
  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();

    _tasks = await repository.getTasks();

    isLoading = false;
    notifyListeners();
  }

  // ========================
  // ADD
  // ========================
  bool isAdding = false;
  bool addSuccess = false;
  Future<void> add(Task task) async {
    isAdding = true;
    addSuccess = false;
    notifyListeners();

    try {
      await repository.insert(task);
      await loadTasks();

      addSuccess = true; // 👈 báo thành công
    } catch (e) {
      addSuccess = false;
    }

    isAdding = false;
    notifyListeners();
  }

  void clearAddStatus() {
    addSuccess = false;
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

  void clearTasks() {
    _tasks = [];
    notifyListeners();
  }

// Xóa cache và load lại từ Supabase (khi login user mới)
  Future<void> clearAndReload() async {
    _tasks = [];
    notifyListeners();
    await loadTasks(); // hàm load tasks hiện tại của bạn
  }
}