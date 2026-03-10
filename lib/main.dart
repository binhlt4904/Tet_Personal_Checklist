import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_personal_checklist/views/main/main_screen.dart';
import 'di.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'views/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('vi');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const TetChecklistApp(),
    );
  }
}

class TetChecklistApp extends StatelessWidget {
  const TetChecklistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}