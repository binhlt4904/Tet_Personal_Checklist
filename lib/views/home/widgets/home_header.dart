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
        /// Nền gradient đỏ
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 52, 20, 28),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB71C1C), Color(0xFFC62828)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row: Title + subtitle + nút +
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Icon app (hình vuông bo góc nhỏ)
                  Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(right: 8, top: 2),
                  ),

                  /// Title + subtitle
                  Expanded(
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
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(width: 6),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: const [
                            Icon(Icons.auto_awesome,
                                color: Colors.white70, size: 14),
                            SizedBox(width: 4),
                            Text(
                              "Sạch bong kin kít, rước lộc về nhà",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                ],
              ),

              const SizedBox(height: 22),

              /// Progress Card
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.18),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Tiến độ tổng thể",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${(vm.progress * 100).round()}%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: vm.progress),
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeInOut,
                        builder: (context, value, _) {
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 10,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFFFC107)),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "${vm.completedCount} việc xong",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12.5),
                        ),
                        const Spacer(),
                        Text(
                          "${vm.totalCount - vm.completedCount} việc còn lại",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// Chữ 福 mờ ở giữa
        Positioned.fill(
          child: IgnorePointer(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "福",
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.07),
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
        ),

        /// Đèn lồng trái
        const Positioned(
          top: 0,
          left: 12,
          child: _Lantern(),
        ),

        /// Đèn lồng phải
        const Positioned(
          top: 0,
          right: 12,
          child: _Lantern(),
        ),

        /// 🌼 Hoa mai rơi
        const Positioned.fill(
          child: IgnorePointer(
            child: FallingHoaMai(),
          ),
        ),
      ],
    );
  }
}

/// Widget đèn lồng đơn giản
class _Lantern extends StatelessWidget {
  const _Lantern();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dây treo
        Container(width: 2, height: 10, color: Colors.yellow.shade700),
        // Thân đèn
        Container(
          width: 28,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFFFB300),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            "福",
            style: TextStyle(
              color: Color(0xFFB71C1C),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        // Tua phía dưới
        Container(
          width: 2,
          height: 8,
          color: Colors.yellow.shade700,
        ),
        Container(
          width: 10,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.yellow.shade600,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}