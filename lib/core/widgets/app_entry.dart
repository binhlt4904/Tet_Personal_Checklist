import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../viewmodels/home/home_viewmodel.dart';
import '../../views/auth/pages/auth_page.dart';
import '../../views/main/main_screen.dart';

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => AppEntryState();
}

class AppEntryState extends State<AppEntry> {
  bool isRegistering = false; // ✅ cờ báo đang trong quá trình đăng ký

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFF5EDD8),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
            ),
          );
        }

        final event = snapshot.data?.event;
        final session = snapshot.data?.session;

        print("AUTH EVENT: $event | isRegistering: $isRegistering");

        if (event == AuthChangeEvent.signedIn) {
          if (isRegistering) {
            // ✅ Đang đăng ký → bỏ qua signedIn, không vào MainScreen
            return const AuthPage();
          }
          // Đăng nhập thật sự → load tasks
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<HomeViewModel>().clearAndReload();
          });
        }

        if (event == AuthChangeEvent.signedOut) {
          // ✅ Reset cờ sau khi signOut (do register gọi)
          isRegistering = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<HomeViewModel>().clearTasks();
          });
        }

        if (session != null && !isRegistering) return const MainScreen();

        return const AuthPage();
      },
    );
  }
}