import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // Đảm bảo hỗ trợ SQLite trên nền tảng Desktop (Windows, macOS, Linux)
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL
        description TEXT,
        is_completed INTEGER NOT NULL DEFAULT 0,
        icon_type TEXT DEFAULT 'task'
      )
    ''');

    // Chèn sẵn 4 công việc mẫu chính xác như hình ảnh trong đề bài
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    final initialTasks = [
      TaskModel(
        title: 'Làm bài tập Flutter',
        description: 'Hoàn thành trước thứ Sáu',
        isCompleted: false,
        iconType: 'laptop',
      ),
      TaskModel(
        title: 'Ôn tập Riverpod',
        description: 'Xem lại bài giảng MVVM',
        isCompleted: false,
        iconType: 'book',
      ),
      TaskModel(
        title: 'Chuẩn bị bài thuyết trình',
        description: 'Nhóm 4 - Chủ đề Firebase',
        isCompleted: false,
        iconType: 'presentation',
      ),
      TaskModel(
        title: 'Viết báo cáo môn học',
        description: 'Nộp trên LMS',
        isCompleted: false,
        iconType: 'document',
      ),
    ];

    for (final task in initialTasks) {
      await db.insert('tasks', task.toMap());
    }
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks', orderBy: 'id ASC');
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
