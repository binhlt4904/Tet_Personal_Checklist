import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/home/home_viewmodel.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  static const filters = [
    'Tất cả',
    'Phòng khách',
    'Phòng ngủ',
    'Nhà bếp',
    'Nhà vệ sinh',
    'Ban công',
    'Phòng thờ'
  ];

  IconData _getIcon(String room) {
    switch (room) {
      case 'Phòng khách':
        return Icons.weekend;
      case 'Phòng ngủ':
        return Icons.bed;
      case 'Nhà bếp':
        return Icons.restaurant;
      case 'Nhà vệ sinh':
        return Icons.wc;
      case 'Ban công':
        return Icons.deck;
      case 'Phòng thờ':
        return Icons.temple_buddhist;
      default:
        return Icons.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final item = filters[i];
          final selected = vm.filterRoom == item;

          return GestureDetector(
            onTap: () => vm.setFilterRoom(item),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: selected
                        ? const LinearGradient(
                      colors: [
                        Color(0xFFE53935),
                        Color(0xFFFF7043),
                      ],
                    )
                        : null,
                    color: selected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(26),

                    border: Border.all(
                      color: selected ? Colors.amber : Colors.red.shade100,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.white.withOpacity(0.2)
                              : Colors.red.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getIcon(item),
                          size: 20,
                          color: selected ? Colors.yellow.shade200 : Colors.red,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        item,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: selected ? Colors.yellow.shade200 : Colors.red.shade800,
                        ),
                      ),

                      const SizedBox(width: 12),
                    ],

                  ),
                ),

                /// 🌸 Hoa ở góc trong chip
                Positioned(
                  top: 4,
                  right: 6,
                  child: Icon(
                    Icons.filter_vintage,
                    size: 14,
                    color: selected ? Colors.white70 : Colors.pink.shade300,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}