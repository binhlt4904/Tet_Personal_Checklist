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
        return Icons.kitchen;
      case 'Nhà vệ sinh':
        return Icons.bathroom;
      case 'Ban công':
        return Icons.deck;
      case 'Phòng thờ':
        return Icons.self_improvement;
      default:
        return Icons.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Container(
      height: 70,
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: selected
                        ? const LinearGradient(
                      colors: [
                        Color(0xFFD32F2F),
                        Color(0xFFFF7043)
                      ],
                    )
                        : null,
                    color: selected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getIcon(item),
                        size: 18,
                        color:
                        selected ? Colors.white : const Color(0xFFD32F2F),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                /// 🌼 Hoa mai góc chip
                /// 🌸 Hoa đào góc chip
                Positioned(
                  top: -6,
                  right: -6,
                  child: Icon(
                    Icons.filter_vintage,
                    size: 18,
                    color: Colors.pink.shade300,
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