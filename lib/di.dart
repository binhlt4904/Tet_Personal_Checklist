import 'package:provider/provider.dart';
import 'package:test_personal_checklist/viewmodels/auth/auth_viewmodel.dart';
import 'package:test_personal_checklist/viewmodels/profile/profile_viewmodel.dart';
import 'data/implementations/local/auth_repository.dart';
import 'data/implementations/local/profile_repository.dart';
import 'data/implementations/local/sqlite_task_repository.dart';
import 'data/implementations/local/supabase_task_repository.dart';
import 'data/interfaces/task_repository.dart';
import 'viewmodels/home/home_viewmodel.dart';

final providers = [
  Provider<TaskRepository>(
    create: (_) => SupabaseTaskRepository(),
  ),
  ChangeNotifierProvider(
    create: (_) => AuthViewModel(AuthRepository()),
  ),
  Provider(create: (_) => ProfileRepository()),
  ChangeNotifierProvider(
    create: (ctx) => ProfileViewModel(ctx.read<ProfileRepository>()),
  ),
  ChangeNotifierProvider<HomeViewModel>(

    create: (context) => HomeViewModel(
      context.read<TaskRepository>(),
    ),
  ),
];