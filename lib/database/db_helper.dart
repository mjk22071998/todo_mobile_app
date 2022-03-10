import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_mobile_app/models/todo.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();
  static Database? _database;

  static const String tableName = "Todo";
  static const String col1Name = "id";
  static const String col2Name = "task";
  static const String col3Name = "dateTime";

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  Future<Database> initDB() async {
    Database db = await openDatabase(join(await getDatabasesPath(), "todo.db"),
        onCreate: ((db, version) async {
      await db.execute('''
      CREATE TABLE $tableName (
        $col1Name INTEGER PRIMARY KEY AUTOINCREMENT,
        $col2Name TEXT,
        $col3Name TEXT
      )
      ''');
    }), version: 1);
    return db;
  }

  addTask(TodoTask todoTask) async {
    final Database db = await database;
    db.insert(tableName, todoTask.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  Future<dynamic> getAllTasks() async {
    final db = await database;
    List<Map> res = await db.query(tableName);
    if (res.isEmpty) {
      return null;
    } else {
      return res.toList();
    }
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await
        db.rawDelete('''DELETE FROM $tableName WHERE id = $id''');
    return count;
  }

}
