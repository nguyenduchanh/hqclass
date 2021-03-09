import 'package:hqclass/Domains/models/classes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class ClassesDao {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'class_mng.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE classes (id INTEGER PRIMARY KEY, classcode TEXT, classname TEXT, contactname TEXT, contactphone TEXT, numberofstudents INTEGER,createdate DATETIME, createby TEXT, updateddate DATETIME, updatedby TEXT)');
  }
  Future<Classes> add(Classes classes) async {
    var dbClient = await db;
    classes.id = await dbClient.insert('classes', classes.toMap());
    return classes;
  }
  Future<List<Classes>> getClasses() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('classes', columns: ['id', 'classcode','classname','contactname','contactphone','numberofstudents','createdate','createby','updateddate','updatedby']);
    List<Classes> classes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        classes.add(Classes.fromMap(maps[i]));
      }
    }
    return classes;
  }
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'classes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Classes classes) async {
    var dbClient = await db;
    return await dbClient.update(
      'classes',
      classes.toMap(),
      where: 'id = ?',
      whereArgs: [classes.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
