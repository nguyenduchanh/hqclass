import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class BaseDao {
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
        'CREATE TABLE classes (id INTEGER PRIMARY KEY, classcode TEXT, classname TEXT, contactname TEXT, contactphone TEXT, numberofstudents INTEGER,createdate TEXT, createby TEXT, updateddate DATETIME, updatedby TEXT)');
    await db.execute(
        'CREATE TABLE student (id INTEGER PRIMARY KEY, studentcode TEXT, studentname TEXT, studentage INTEGER, schoolname TEXT, address TEXT, parentname TEXT, parentphone TEXT, createdate TEXT, createby TEXT, updateddate TEXT, updatedby TEXT)');
  }

  /// student
  Future<int> addStudent(StudentModel student) async {
    var dbClient = await db;
    student.id = await dbClient.insert('student', student.toMap());
    return student.id;
  }

  Future<List<StudentModel>> getStudents() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('student', columns: [
      'id',
      'studentcode',
      'studentname',
      'studentage',
      'schoolname',
      'address',
      'parentname',
      'parentphone',
      'createdate',
      'createby',
      'updateddate',
      'updatedby'
    ]);
    List<StudentModel> students = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        students.add(StudentModel.fromMap(maps[i]));
      }
    }
    return students;
  }

  Future<int> deleteStudent(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateStudent(StudentModel student) async {
    var dbClient = await db;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  ///end student
  ///start class
  Future<int> addClass(ClassesModel classes) async {
    var dbClient = await db;
    classes.id = await dbClient.insert('classes', classes.toMap());
    return classes.id;
  }

  Future<List<ClassesModel>> getClasses() async {
    var dbClient = await db;

    List<Map> maps = await dbClient.query('classes', columns: [
      'id',
      'classcode',
      'classname',
      'contactname',
      'contactphone',
      'numberofstudents',
      'createdate',
      'createby',
      'updateddate',
      'updatedby'
    ]);
    List<ClassesModel> classes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        classes.add(ClassesModel.fromMap(maps[i]));
      }
      return classes;
    } else {
      return null;
    }
  }

  Future<int> deleteClass(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'classes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateClass(ClassesModel classes) async {
    var dbClient = await db;
    return await dbClient.update(
      'classes',
      classes.toMap(),
      where: 'id = ?',
      whereArgs: [classes.id],
    );
  }

  ///end class
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
