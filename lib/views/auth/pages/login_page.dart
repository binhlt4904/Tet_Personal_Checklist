import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/auth/auth_viewmodel.dart';
import '../toggle/auth_back_link.dart';
import '../toggle/auth_primary_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_field_label.dart';
import '../widgets/auth_field_error.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validate() {
    bool valid = true;
    setState(() {
      final email = _emailController.text.trim();
      if (email.isEmpty) {
        _emailError = 'Vui lòng nhập email';
        valid = false;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        _emailError = 'Email không hợp lệ';
        valid = false;
      } else {
        _emailError = null;
      }

      if (_passwordController.text.isEmpty) {
        _passwordError = 'Vui lòng nhập mật khẩu';
        valid = false;
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'Mật khẩu phải ít nhất 6 ký tự';
        valid = false;
      } else {
        _passwordError = null;
      }
    });
    return valid;
  }

  void _handleLogin() async {
    if (!_validate()) return;

    final vm = context.read<AuthViewModel>();

    final success = await vm.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đăng nhập thành công 🎉")),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.errorMessage ?? "Có lỗi xảy ra")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, vm, _) {
        return SingleChildScrollView(
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
                hasError: _emailError != null,
              ),
              AuthFieldError(_emailError),
              const SizedBox(height: 16),
              const AuthFieldLabel('Mật khẩu'),
              const SizedBox(height: 8),
              AuthPasswordField(
                controller: _passwordController,
                obscure: _obscurePassword,
                onToggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                hasError: _passwordError != null,
              ),
              AuthFieldError(_passwordError),
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