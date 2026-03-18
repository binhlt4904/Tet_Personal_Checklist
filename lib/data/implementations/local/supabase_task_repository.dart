import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../domain/entities/task.dart';
import '../../interfaces/task_repository.dart';

class SupabaseTaskRepository implements TaskRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Task>> getTasks() async {
    // Lấy user hiện tại đang đăng nhập
    final userId = supabase.auth.currentUser?.id;
    print("user id: $userId");

    if (userId == null) return []; // chưa đăng nhập thì trả về rỗng

    final response = await supabase
        .from('tasks')
        .select()
        .eq('user_id', userId) // ← chỉ lấy task của user này
        .order('created_at', ascending: false);

    return (response as List).map((e) => Task.fromJson(e)).toList();
  }

  @override
  Future<void> insert(Task task) async {
     await supabase.from('tasks').insert({
      'title': task.title,
      'room': task.room,
      'description': task.description,
      'deadline': task.deadline?.toIso8601String(),
      'is_done': task.isDone,
    });
  }

  @override
  Future<void> update(Task task) async {
    await supabase
        .from('tasks')
        .update({
      'title': task.title,
      'room': task.room,
      'description': task.description,
      'deadline': task.deadline?.toIso8601String(),
      'is_done': task.isDone,
    })
        .eq('id', task.id!);
  }

  @override
  Future<void> delete(String id) async {
    await supabase.from('tasks').delete().eq('id', id);
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    await supabase.from('tasks').delete();

    final data = tasks.map((t) {
      return {
        'title': t.title,
        'room': t.room,
        'description': t.description,
        'deadline': t.deadline?.toIso8601String(),
        'is_done': t.isDone,
      };
    }).toList();

    await supabase.from('tasks').insert(data);
  }
}