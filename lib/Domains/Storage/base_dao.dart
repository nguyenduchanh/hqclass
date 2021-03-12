import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:tiengviet/tiengviet.dart';

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
        'CREATE TABLE classes (id INTEGER PRIMARY KEY, classcode TEXT, classname TEXT, contactname TEXT, contactphone TEXT, numberofstudents INTEGER,createdate TEXT, createby TEXT, updateddate DATETIME, updatedby TEXT, studentcodelist TEXT)');
    await db.execute(
        'CREATE TABLE student (id INTEGER PRIMARY KEY, studentcode TEXT, studentname TEXT, studentage INTEGER, schoolname TEXT, address TEXT, parentname TEXT, parentphone TEXT,currentstate INTEGER, createdate TEXT, createby TEXT, updateddate TEXT, updatedby TEXT)');
    await initClasses();
    await initStudent();
  }

  /// student
  Future<int> addStudent(StudentModel student) async {
    var dbClient = await db;
    student.id = await dbClient.insert('student', student.toMap());
    return student.id;
  }

  Future<List<StudentModel>> searchStudent(
      Future<List<StudentModel>> data, String textSearch) async {
    var dataList = await data;
    if (textSearch != null && textSearch.isNotEmpty) {
      String textWithoutSign = TiengViet.parse(textSearch);
    List<StudentModel> temp = [];
      for (int i = 0; i < dataList.length; i++) {
        String studentCodeWithoutSign = TiengViet.parse(dataList[i].studentCode);
        String studentNameWithoutSign = TiengViet.parse(dataList[i].studentName);
        if (studentCodeWithoutSign.contains(textWithoutSign) ||
            studentCodeWithoutSign.toUpperCase().contains(textWithoutSign.toUpperCase()) ||
            studentNameWithoutSign.contains(textWithoutSign) ||
            studentNameWithoutSign.toUpperCase().contains(textWithoutSign.toUpperCase())) {
          temp.add(dataList[i]);
        }
      }
      dataList = temp;
    }
    return dataList;
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
      'currentstate',
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

  Future<void> setStudentToQuit(StudentModel student) async {
    var dbClient = await db;
    student.currentState = 0;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
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

  Future<List<ClassesModel>> searchClasses(
      Future<List<ClassesModel>> data, String textSearch) async {
    var dataList = await data;
    if (textSearch != null && textSearch.isNotEmpty) {
      String textWithoutSign = TiengViet.parse(textSearch);
      List<ClassesModel> temp = [];
      for (int i = 0; i < dataList.length; i++) {
        String classCodeWithoutSign = TiengViet.parse(dataList[i].classCode);
        String classNameWithoutSign = TiengViet.parse(dataList[i].className);
        if (classCodeWithoutSign.contains(textWithoutSign) ||
            classCodeWithoutSign.toUpperCase().contains(textWithoutSign.toUpperCase()) ||
            classNameWithoutSign.contains(textWithoutSign) ||
            classNameWithoutSign.toUpperCase().contains(textWithoutSign.toUpperCase())) {
          temp.add(dataList[i]);
        }
      }
      dataList = temp;
    }
    return dataList;
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
      'updatedby',
      'studentcodelist'
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

  Future<void> initStudent() async {
    List<StudentModel> students = [
      StudentModel(
          1,
          "TB01",
          "Cù Chí Tuệ",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          2,
          "TB02",
          "Lê Văn Lựu",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          3,
          "TB03",
          "Lê Thị Lương",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          4,
          "DR01",
          "Vũ Thị Bười",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          5,
          "DR02",
          "Ái Tan Giác La Phổ Nghi",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          6,
          "HG01",
          "Công Tằng Tôn Nữ Thị Ninh",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          7,
          "HG02",
          "Thành Cát Tam Hãn",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          8,
          "HG03",
          "Vũ Đức Phượng Sồ",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          9,
          "HG04",
          "Vũ Đức Ngọa Long",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          10,
          "BT01",
          "Nguyễn Lê Hùng Dâm",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          11,
          "BT02",
          "Nguyễn Lê Hường",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          12,
          "HS04",
          "Nguyên Văn Tý",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          13,
          "HS03",
          "Nguyên Thị Lượm",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          14,
          "HS08",
          "Phạm Thị Bưởi",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
      StudentModel(
          15,
          "HS12",
          "Lê Thị Na",
          12,
          "THPT Chuyên Ngoại",
          "Chuyên Ngoại - Duy Tiên - Hà Nam",
          "Nguyễn Văn X",
          "0981831654",
          1,
          "admin",
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString()),
    ];
    for (int i = 0; i < students.length; i++) {
      addStudent(students[i]);
    }
  }

  Future<void> initClasses() async {
    List<ClassesModel> classes = [
      ClassesModel(
          1,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          "HG01,HG02,HG03,HG04"),
      ClassesModel(
          2,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          3,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          4,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          5,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          6,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          7,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          8,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          9,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          9,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          9,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
      ClassesModel(
          9,
          "CL01",
          "Lop hoc phu dao",
          "Le Van D",
          "0981843626",
          23,
          DateTime.now().toString(),
          "admin",
          DateTime.now().toString(),
          "admin",
          ""),
    ];
    for (int i = 0; i < classes.length; i++) {
      addClass(classes[i]);
    }
  }
}
