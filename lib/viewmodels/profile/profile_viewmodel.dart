import 'package:flutter/material.dart';

import '../../data/implementations/local/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _repo;

  ProfileViewModel(this._repo);

  bool isLoading = false;
  String? errorMessage;

  String name = '';
  String email = '';
  String joinDate = '';
  int totalTasks = 0;
  int completedTasks = 0;

  String get achievement {
    if (completedTasks >= 50) return "Siêu nhân";
    if (completedTasks >= 10) return "Chăm chỉ";
    if (completedTasks >= 1) return "Người dọn dẹp";
    return "Người mới";
  }

  Future<void> loadProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final data = await _repo.getProfile();

      final createdAt = DateTime.parse(data['created_at']);
      joinDate = '${createdAt.day.toString().padLeft(2, '0')}/'
          '${createdAt.month.toString().padLeft(2, '0')}/'
          '${createdAt.year}';

      name = data['name'];
      email = data['email'];
      totalTasks = data['total_tasks'];
      completedTasks = data['completed_tasks'];
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({required String name}) async {
    isLoading = true;
    notifyListeners();

    try {
      await _repo.updateProfile(name: name);
      this.name = name;
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}