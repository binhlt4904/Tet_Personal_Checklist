import 'package:provider/provider.dart';
import 'data/implementations/local/sqlite_task_repository.dart';
import 'data/interfaces/task_repository.dart';
import 'viewmodels/home/home_viewmodel.dart';

final providers = [
  Provider<TaskRepository>(
    create: (_) => SqliteTaskRepository(),
  ),
  ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(
      context.read<TaskRepository>(),
    ),
  ),
];