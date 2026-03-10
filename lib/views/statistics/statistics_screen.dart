import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_personal_checklist/core/widgets/header.dart';

import '../../domain/entities/task.dart';
import '../../viewmodels/home/home_viewmodel.dart';
import 'widgets/summary_section.dart';
import 'widgets/room_chart_section.dart';
import 'widgets/schedule_chart_section.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final tasks = vm.tasks;

    return Scaffold(
      backgroundColor: const Color(0xF6F4EDDD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(
                title: 'Thống Kê Tiến Độ',
                description: 'Theo dõi kết quả dọn dẹp của bạn',
              ),
              const SizedBox(height: 16),

              SummarySection(tasks: tasks),

              const SizedBox(height: 20),

              RoomChartSection(tasks: tasks),

              const SizedBox(height: 20),

              ScheduleChartSection(tasks: tasks),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}