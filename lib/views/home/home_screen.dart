import 'package:flutter/material.dart';
import 'widgets/home_body.dart';
import 'widgets/home_fab_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF6F4EDDD),
      body: const SafeArea(
        child: HomeBody(),
      ),
      floatingActionButton: const HomeFabButton(),
    );
  }
}