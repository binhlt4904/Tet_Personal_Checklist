

import '../../domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> saveTasks(List<Task> tasks);
  Future<void> delete(int id);
  Future<void> update(Task task);
}