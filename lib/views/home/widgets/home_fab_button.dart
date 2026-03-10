import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/home/home_viewmodel.dart';
import '../../task/taskadd/add_task_sheet.dart';

class HomeFabButton extends StatelessWidget {
  const HomeFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();

    return FloatingActionButton(
      backgroundColor: Color(0xFFD32F2F),
      onPressed: () {


        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => AddTaskSheet(onAdd: vm.add),
        );
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}