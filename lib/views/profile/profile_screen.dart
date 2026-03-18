import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/header.dart';
import '../../viewmodels/auth/auth_viewmodel.dart';
import '../../viewmodels/profile/profile_viewmodel.dart';
import 'edit_profile/edit_profile_form.dart';
import 'widgets/profile_card.dart';
import 'widgets/profile_action_button.dart';
import 'widgets/profile_error_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProfileViewModel>().loadProfile());
  }

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Đăng xuất"),
        content: const Text("Bạn có chắc muốn đăng xuất không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Huỷ", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Đăng xuất",
                style: TextStyle(color: Color(0xFFD32F2F))),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    if (!mounted) return;

    setState(() => _isLoggingOut = true);

    try {
      await context.read<AuthViewModel>().logout();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/auth');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng xuất thất bại: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF6F4EDDD),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const Header(
                  title: 'Hồ Sơ Cá Nhân',
                  description: 'Xem công việc theo ngày',
                ),
                Expanded(
                  child: Consumer<ProfileViewModel>(
                    builder: (context, vm, _) {
                      // ── Loading ──
                      if (vm.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFFD32F2F)),
                        );
                      }

                      // ── Lỗi ──
                      if (vm.errorMessage != null) {
                        return ProfileErrorView(
                          message: vm.errorMessage!,
                          onRetry: () => vm.loadProfile(),
                        );
                      }

                      // ── Content ──
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // 👤 Profile card
                            ProfileCard(
                              name: vm.name,
                              email: vm.email,
                              joinDate: vm.joinDate,
                              totalTasks: vm.totalTasks,
                              completedTasks: vm.completedTasks,
                              achievement: vm.achievement,
                            ),

                            const SizedBox(height: 30),

                            // ✏️ Sửa hồ sơ
                            ProfileActionButton(
                              gradientColors: const [Color(0xFFF4B942), Color(0xFFD89B2D)],
                              icon: Icons.edit,
                              label: "Sửa hồ sơ",
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                  ),
                                  builder: (ctx) => Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 20,
                                      bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
                                    ),
                                    child: const EditProfileForm(),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 16),

                            // 🔴 Đăng xuất
                            ProfileActionButton(
                              gradientColors: const [
                                Color(0xFFD32F2F),
                                Color(0xFFB71C1C),
                              ],
                              icon: Icons.logout,
                              label: "Đăng xuất",
                              loadingLabel: "Đang đăng xuất...",
                              isLoading: _isLoggingOut,
                              onPressed: _handleLogout,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Overlay mờ khi đang logout
          if (_isLoggingOut)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child:
                CircularProgressIndicator(color: Color(0xFFD32F2F)),
              ),
            ),
        ],
      ),
    );
  }
}