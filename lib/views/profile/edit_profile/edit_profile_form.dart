import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/profile/profile_viewmodel.dart';
import 'widgets/edit_profile_header.dart';
import 'widgets/edit_profile_fields.dart';
import 'widgets/edit_profile_button.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // ✅ Điền sẵn tên hiện tại
    final vm = context.read<ProfileViewModel>();
    _nameCtrl = TextEditingController(text: vm.name);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final vm = context.read<ProfileViewModel>();
      await vm.updateProfile(name: _nameCtrl.text.trim());

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cập nhật hồ sơ thành công 🎉")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cập nhật thất bại: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Tiêu đề ──
            const EditProfileHeader(),

            const SizedBox(height: 20),

            // ── Các trường nhập ──
            EditProfileFields(
              nameController: _nameCtrl,
              nameValidator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vui lòng nhập họ và tên";
                }
                if (value.trim().length < 2) {
                  return "Họ tên tối thiểu 2 ký tự";
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // ── Nút lưu ──
            EditProfileButton(
              isLoading: _isLoading,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}