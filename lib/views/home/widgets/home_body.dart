import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/home/home_viewmodel.dart';
import 'home_header.dart';
import 'home_filters.dart';
import 'task_list.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vm.addSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Thêm công việc thành công"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );

        vm.clearAddStatus(); // reset
      }
    });
    return Stack(
      children: [
        Column(
          children: [
            HomeHeader(),
            const HomeFilters(),

            Expanded(
              child: AnimatedSwitcher(
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(0, 0.1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                duration: const Duration(milliseconds: 300),
                child: vm.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFD32F2F),
                  ),
                )
                    : TaskList(key: ValueKey(vm.tasks.length),tasks: vm.tasks),

              ),
            ),
          ],
        ),

        /// 👇 loading khi add
        if (vm.isAdding)
          Container(
            color: Colors.black.withOpacity(0.2),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}