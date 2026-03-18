import 'package:flutter/material.dart';
import '../../data/implementations/local/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepo;

  AuthViewModel(this._authRepo);

  bool isLoading = false;
  String? errorMessage;

  // ================= REGISTER =================
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authRepo.register(
        email: email,
        password: password,
        name: name,
      );
      print("viewmodel");
      isLoading = false;

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================= LOGIN =================
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authRepo.login(
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authRepo.logout();
    errorMessage = null;
    notifyListeners();
  }


}