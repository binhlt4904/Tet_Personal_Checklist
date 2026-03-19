import 'package:flutter/material.dart';
import 'profile_avatar.dart';
import 'profile_info_card.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String goal;
  final String joinDate;
  final int totalTasks;
  final int completedTasks;
  final String achievement;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    this.goal = '',
    required this.joinDate,
    required this.totalTasks,
    required this.completedTasks,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          ProfileAvatar(name: name, email: email, goal: goal),
          const SizedBox(height: 20),
          ProfileInfoCard(
            icon: Icons.calendar_today,
            title: "Ngày tham gia",
            value: joinDate,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          ProfileInfoCard(
            icon: Icons.task_alt,
            title: "Công việc",
            value: '$completedTasks / $totalTasks hoàn thành',
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          ProfileInfoCard(
            icon: Icons.workspace_premium,
            title: "Thành tựu",
            value: achievement,
            color: Colors.amber[700]!,
          ),
        ],
      ),
    );
  }
}