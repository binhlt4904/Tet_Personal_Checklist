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
  late TextEditingController _goalCtrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final vm = context.read<ProfileViewModel>();
    _nameCtrl = TextEditingController(text: vm.name);
    _goalCtrl = TextEditingController(text: vm.goal);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _goalCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final vm = context.read<ProfileViewModel>();
      await vm.updateProfile(
        name: _nameCtrl.text.trim(),
        goal: _goalCtrl.text.trim(),
      );

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Cập nhật hồ sơ thành công"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cập nhật thất bại: $e"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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
            const EditProfileHeader(),
            const SizedBox(height: 20),

            EditProfileFields(
              nameController: _nameCtrl,
              goalController: _goalCtrl,
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