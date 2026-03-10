import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get instance async {
    _db ??= await _open();
    return _db!;
  }

  static Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'tet_checklist.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            room TEXT NOT NULL,
            description TEXT,
            deadline TEXT,
            isDone INTEGER NOT NULL
          )
        ''');
      },
    );
  }
}