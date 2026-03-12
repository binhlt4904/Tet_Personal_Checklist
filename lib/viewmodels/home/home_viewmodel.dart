import 'package:flutter/material.dart';
import '../../data/implementations/local/sqlite_task_repository.dart';
import '../../data/interfaces/task_repository.dart';
import '../../domain/entities/task.dart';

class HomeViewModel extends ChangeNotifier {
  final TaskRepository repository;

  List<Task> _tasks = [];
  String filterRoom = 'Tất cả';

  HomeViewModel(this.repository) {
    loadTasks();
  }

  List<Task> get allTasks => _tasks;


  List<Task> get tasks => filterRoom == 'Tất cả'
      ? _tasks
      : _tasks.where((t) => t.room == filterRoom).toList();

  int get totalCount => tasks.length;

  int get completedCount =>
      tasks.where((t) => t.isDone).length;

  double get progress =>
      totalCount == 0 ? 0 : completedCount / totalCount;

  Future<void> loadTasks() async {
    _tasks = await repository.getTasks();
    notifyListeners();
  }

  Future<void> add(Task task) async {
    if (repository is SqliteTaskRepository) {
      await (repository as SqliteTaskRepository).insert(task);
      _tasks = await repository.getTasks();
    }

    notifyListeners();
  }

  Future<void> toggle(Task task) async {
    task.isDone = !task.isDone;

    if (repository is SqliteTaskRepository) {
      await (repository as SqliteTaskRepository).update(task);
    }

    notifyListeners();
  }

  Future<void> delete(int id) async {
    await repository.delete(id);

    _tasks.removeWhere((t) => t.id == id);

    notifyListeners();
  }

  Future<void> update(Task updatedTask) async {
    // 1️⃣ Update xuống database
    await repository.update(updatedTask);

    // 2️⃣ Update trong memory list
    final index = _tasks.indexWhere((t) => t.id == updatedTask.id);

    if (index != -1) {
      _tasks[index] = updatedTask;
    }

    // 3️⃣ Notify UI rebuild
    notifyListeners();
  }

  Future<void> toggleStatus(Task task) async {
    final updated = task.copyWith(isDone: !task.isDone);
    await update(updated);
  }

  void setFilterRoom(String room) {
    filterRoom = room;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadTasks();
    notifyListeners();
  }
}
