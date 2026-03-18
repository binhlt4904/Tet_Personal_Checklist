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

  void _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // ===== VALIDATE =====
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
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

    setState(() => _isLoading = true);

    final appEntry = context.findAncestorStateOfType<AppEntryState>();
    appEntry?.isRegistering = true;

    final vm = context.read<AuthViewModel>();

    final success = await vm.register(
      name: name,
      email: email,
      password: password,
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, vm, _) {
        return SingleChildScrollView(
          child: Padding(
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
                ),

                const SizedBox(height: 16),

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

                // 🔥 BUTTON CÓ LOADING
                AuthPrimaryButton(
                  label:'Đăng ký ti khoản',
                  emoji: '🧧',
                  onPressed:  _handleRegister,
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
          ),
        );

      },
    );
  }
}