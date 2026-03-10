import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/home/home_viewmodel.dart';
import 'falling_hoa_mai.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Stack(
      children: [

        /// 🌼 Hoa mai rơi

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    "Dọn Nhà Đón Tết",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.local_florist, color: Colors.yellow, size: 26),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                "Sạch bong kin kít, rước lộc về nhà",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),

              /// Progress Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Tiến độ tổng thể",
                            style: TextStyle(color: Colors.white)),
                        const Spacer(),
                        Text("${(vm.progress * 100).round()}%",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: vm.progress),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        builder: (context, value, _) {
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 8,
                            backgroundColor: Colors.white24,
                            valueColor:
                            const AlwaysStoppedAnimation<Color>(
                                Colors.amber),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${vm.completedCount} việc xong — ${vm.totalCount - vm.completedCount} việc còn lại",
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Positioned.fill(
          child: IgnorePointer(
            child: FallingHoaMai(),
          ),
        ),
      ],
    );
  }
}