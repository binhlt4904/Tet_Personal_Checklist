import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> getProfile() async {
    final user = supabase.auth.currentUser;
    print("user $user");
    if (user == null) throw Exception("Chưa đăng nhập");

    // ✅ maybeSingle() trả về null thay vì throw lỗi nếu không có row
    final userResponse = await supabase
        .from('users')
        .select()
        .eq('id', user.id)
        .maybeSingle();
    print("userResponse $userResponse");

    final tasksResponse = await supabase
        .from('tasks')
        .select()
        .eq('user_id', user.id);

    final tasks = tasksResponse as List;

    return {
      // ✅ Fallback về email nếu chưa có record trong bảng users
      'name': userResponse?['name'] ?? user.email?.split('@').first ?? 'Người dùng',
      'email': user.email ?? '',
      'created_at': userResponse?['created_at'] ?? user.createdAt,
      'total_tasks': tasks.length,
      'completed_tasks': tasks.where((t) => t['is_done'] == true).length,
    };

  }

  Future<void> updateProfile({required String name}) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("Chưa đăng nhập");

    await supabase
        .from('users')
        .update({'name': name})
        .eq('id', user.id);
  }
}