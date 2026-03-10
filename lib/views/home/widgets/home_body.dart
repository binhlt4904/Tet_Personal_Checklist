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

    return Column(
      children: [
         HomeHeader(),
        const HomeFilters(),
        Expanded(
          child: TaskList(tasks: vm.tasks),
        ),
      ],
    );
  }
}