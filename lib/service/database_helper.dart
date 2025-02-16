import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tma/models/task_model.dart';


class DatabaseHelper with ChangeNotifier {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        status TEXT,
        isSynced INTEGER DEFAULT 0
      )
    ''');
  }

  
  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
    notifyListeners();
  }

  
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  
  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    notifyListeners();
  }

  
  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  
  Future<void> syncTasksWithFirebase() async {
    final db = await database;
    final List<Map<String, dynamic>> localTasks = await db.query('tasks');
    print(">>>>>>>>>>>>>>>>>>>>>>${localTasks.length}");
    for (final taskMap in localTasks) {
      final task = Task.fromMap(taskMap);
      CollectionReference addTicket =
          FirebaseFirestore.instance.collection('task');
      for (var element in localTasks) {
        await addTicket.add({
          'title': element['title'],
          'description': element['description'],
          'status': element["status"],
        });
      }

     
      await db.update(
        'tasks',
        {'isSynced': 1},
        where: 'id = ?',
        whereArgs: [task.id],
      );
    }
  }

  
  Future<List<Task>> fetchTasksFromFirebase() async {
    final DatabaseReference ref = _firebaseDatabase.ref().child('tasks');
    final DatabaseEvent event = await ref.once();
    final Map<dynamic, dynamic>? tasksMap =
        event.snapshot.value as Map<dynamic, dynamic>?;

    if (tasksMap == null) return [];

    final List<Task> tasks = [];
    tasksMap.forEach((key, value) {
      tasks.add(Task.fromMap(value));
    });

    return tasks;
  }
}
