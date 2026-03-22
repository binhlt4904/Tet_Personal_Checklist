import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/widgets/app_entry.dart';
import '../../../viewmodels/auth/auth_viewmodel.dart';
import '../toggle/auth_back_link.dart';
import '../toggle/auth_primary_button.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_field_label.dart';
import '../widgets/auth_field_error.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback? onRegisterSuccess;
  const RegisterPage({super.key, this.onRegisterSuccess});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validate() {
    bool valid = true;
    setState(() {
      // Name
      _nameError = _nameController.text.trim().isEmpty
          ? 'Vui lòng nhập họ và tên'
          : null;
      if (_nameError != null) valid = false;

      // Email
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

      // Password
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

  void _handleRegister() async {
    if (!_validate()) return;

    setState(() => _isLoading = true);

    final appEntry = context.findAncestorStateOfType<AppEntryState>();
    appEntry?.isRegistering = true;

    final vm = context.read<AuthViewModel>();

    final success = await vm.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    print("register page");

    if (!mounted) return;

    if (success) {
      await Supabase.instance.client.auth.signOut();
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đăng ký thành công 🎉")),
      );
      widget.onRegisterSuccess?.call();
    } else {
      appEntry?.isRegistering = false;
      setState(() => _isLoading = false);
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
              const AuthFieldLabel('Họ và tên'),
              const SizedBox(height: 8),
              AuthInputField(
                controller: _nameController,
                hintText: 'Nguyễn Văn A',
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                hasError: _nameError != null,
              ),
              AuthFieldError(_nameError),

              const SizedBox(height: 16),

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
                label: 'Đăng ký tài khoản',
                emoji: '🧧',
                onPressed: _isLoading ? null : _handleRegister,
              ),

              const SizedBox(height: 16),

              if (_isLoading)
                Container(
                  color: Colors.white.withOpacity(0.7),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}