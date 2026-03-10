import 'package:sqflite/sqflite.dart';
import '../../../domain/entities/task.dart';
import '../../dtos/task_dto.dart';
import '../../interfaces/task_repository.dart';
import 'app_database.dart';

class SqliteTaskRepository implements TaskRepository {
  @override
  Future<List<Task>> getTasks() async {
    final db = await AppDatabase.instance;
    final rows = await db.query('tasks', orderBy: 'id DESC');
    return rows.map((e) => TaskDto.fromMap(e).toEntity()).toList();
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    final db = await AppDatabase.instance;
    final batch = db.batch();
    await db.delete('tasks');
    for (final t in tasks) {
      batch.insert('tasks', TaskDto.fromEntity(t).toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<int> insert(Task task) async {
    final db = await AppDatabase.instance;
    return await db.insert('tasks', TaskDto.fromEntity(task).toMap());
  }

  @override
  Future<void> update(Task task) async {
    final db = await AppDatabase.instance;
    await db.update(
      'tasks',
      TaskDto.fromEntity(task).toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<void> delete(int id) async {
    final db = await AppDatabase.instance;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}