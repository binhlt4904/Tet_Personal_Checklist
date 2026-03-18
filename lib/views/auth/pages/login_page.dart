import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/auth/auth_viewmodel.dart';
import '../toggle/auth_back_link.dart';
import '../toggle/auth_primary_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_field_label.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // ===== VALIDATE =====
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ")),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mật khẩu tối thiểu 6 ký tự")),
      );
      return;
    }

    final vm = context.read<AuthViewModel>();

    final success = await vm.login(
      email: email,
      password: password,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đăng nhập thành công 🎉")),
      );
      // TODO: Navigate tới màn hình chính
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.errorMessage ?? "Có lỗi xảy ra")),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, vm, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFieldLabel('Email'),
              const SizedBox(height: 8),
              AuthInputField(
                controller: _emailController,
                hintText: 'example@email.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              const AuthFieldLabel('Mật khẩu'),
              const SizedBox(height: 8),
              AuthPasswordField(
                controller: _passwordController,
                obscure: _obscurePassword,
                onToggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              const SizedBox(height: 28),
              AuthPrimaryButton(
                label: 'Đăng nhập ngay',
                emoji: '🧧',
                onPressed: _handleLogin,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}