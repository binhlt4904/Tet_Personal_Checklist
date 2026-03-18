import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  // ================= LOGIN =================
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  // ================= REGISTER =================
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print("USER: ${supabase.auth.currentUser}");
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );


      final user = response.user;


      if (user != null) {
        // insert vào bảng users của bạn
        await supabase.from('users').insert({
          'id': user.id,
          'name': name,
          'status': 'active',
          'created_at': DateTime.now().toIso8601String(),
        });
      }

      await supabase.auth.signOut();
      print("USERaaaa: ${supabase.auth.currentUser}");
      return response;
    } catch (e) {
      throw Exception("Register failed: $e");
    }
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  // ================= CURRENT USER =================
  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }
}