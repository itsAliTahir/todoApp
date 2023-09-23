import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../models/datamodels.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'myDataBase.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE Tasks (
        Title TEXT NOT NULL,
        Description TEXT,
        Category TEXT,
        isCompleted INTEGER,
        Repeat INTEGER
      )
    ''',
    );
  }

  Future<List<MyTasks>> getData() async {
    Database db = await instance.database;
    var groceries = await db.query('Tasks');
    List<MyTasks> groceryList = groceries.isNotEmpty
        ? groceries.map((c) => MyTasks.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<int> addIntoDatabase(MyTasks task) async {
    Database db = await instance.database;
    return await db.insert('Tasks', task.toMap());
  }

  Future<int> deleteFromDatabase(MyTasks task) async {
    Database db = await instance.database;

    return await db.delete(
      'Tasks',
      where: 'Title = ? ',
      whereArgs: [
        task.title,
      ],
    );
  }

  Future<int> updateDatabase(MyTasks task, MyTasks update) async {
    Database db = await instance.database;
    return await db.update('Tasks', update.toMap(),
        where: "Title = ?", whereArgs: [task.title]);
  }
}
