import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Domains/models/rollup.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Domains/models/student_add.dart';
import 'package:hqclass/Domains/models/user.dart';
import 'package:hqclass/Util/Constants/globals.dart';
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
    await db.execute(
        'CREATE TABLE rollup (id INTEGER PRIMARY KEY, classcode TEXT, studentcodelist TEXT, createdate TEXT, rollupdata TEXT)');
    await db.execute(
        'CREATE TABLE user (id INTEGER PRIMARY KEY, userName TEXT, password TEXT, email TEXT, deviceLogin TEXT, isbiometricavailable INTEGER )');
  }
  /// user
  Future<List<UserModel>> getUser() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('user', columns: [
      'id',
      'userName',
      'password',
      'email',
      'deviceLogin',
      'isbiometricavailable',
    ]);
    List<UserModel> userModel = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        userModel.add(UserModel.fromMap(maps[i]));
      }
    }
    return userModel;
  }
  Future<int> addUser(UserModel userModel) async {
    var dbClient = await db;
    userModel.id = await dbClient.insert('user', userModel.toMap());
    if(userModel.id > 0){
      Global.userModel = userModel;
    }
    return userModel.id;

  }
  Future<UserModel> getUserByEmail(String email) async {
    final dbClient = await db;
    var result =
    await dbClient.query("user", where: "email = ?", whereArgs: [email]);
    return result.isNotEmpty ? UserModel.fromMap(result.first) : Null;
  }
  Future<int> updateUser(UserModel userModel) async {
    var dbClient = await db;
    var userId = await dbClient.update(
      'user',
      userModel.toMap(),
      where: 'id = ?',
      whereArgs: [userModel.id],
    );
    if(userId > 0){
      Global.userModel = userModel;
    }
    return userId;
  }
  /// roll up
  Future<List<RollUpModel>> getRollup() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('rollup', columns: [
      'id',
      'classcode',
      'studentcodelist',
      'createdate',
      'rollupdata',
    ]);
    List<RollUpModel> rollups = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        rollups.add(RollUpModel.fromMap(maps[i]));
      }
    }
    return rollups;
  }
  Future<RollUpModel> getRollupById(int id) async {
    final dbClient = await db;
    var result =
    await dbClient.query("rollup", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? RollUpModel.fromMap(result.first) : Null;
  }
  Future<int> addRollup(RollUpModel rollUpModel) async {
    var dbClient = await db;
    rollUpModel.id = await dbClient.insert('rollup', rollUpModel.toMap());
    return rollUpModel.id;
  }
  Future<int> updateRollup(RollUpModel rollUpModel) async {
    var dbClient = await db;
    return await dbClient.update(
      'rollup',
      rollUpModel.toMap(),
      where: 'id = ?',
      whereArgs: [rollUpModel.id],
    );
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
        String studentCodeWithoutSign =
            TiengViet.parse(dataList[i].studentCode);
        String studentNameWithoutSign =
            TiengViet.parse(dataList[i].studentName);
        if (studentCodeWithoutSign.contains(textWithoutSign) ||
            studentCodeWithoutSign
                .toUpperCase()
                .contains(textWithoutSign.toUpperCase()) ||
            studentNameWithoutSign.contains(textWithoutSign) ||
            studentNameWithoutSign
                .toUpperCase()
                .contains(textWithoutSign.toUpperCase())) {
          temp.add(dataList[i]);
        }
      }
      dataList = temp;
    }
    return dataList;
  }

  Future<List<StudentAddModel>> studentAddCheckedAll(
      Future<List<StudentAddModel>> studentList, bool chkState) async {
    var data = await studentList;
    List<StudentAddModel> result = [];
    if (data != null && data.length > 0) {
      for (int i = 0; i < data.length; i++) {
        data[i].isAdd = chkState;
        result.add(data[i]);
      }
    }
    return result;
  }

  Future<List<StudentAddModel>> searchStudentAdd(
      Future<List<StudentAddModel>> data, String textSearch) async {
    var dataList = await data;
    if (textSearch != null && textSearch.isNotEmpty) {
      String textWithoutSign = TiengViet.parse(textSearch);
      List<StudentAddModel> temp = [];
      for (int i = 0; i < dataList.length; i++) {
        String studentCodeWithoutSign =
            TiengViet.parse(dataList[i].studentCode);
        String studentNameWithoutSign =
            TiengViet.parse(dataList[i].studentName);
        if (studentCodeWithoutSign.contains(textWithoutSign) ||
            studentCodeWithoutSign
                .toUpperCase()
                .contains(textWithoutSign.toUpperCase()) ||
            studentNameWithoutSign.contains(textWithoutSign) ||
            studentNameWithoutSign
                .toUpperCase()
                .contains(textWithoutSign.toUpperCase())) {
          temp.add(dataList[i]);
        }
      }
      dataList = temp;
    }
    return dataList;
  }

  Future<StudentAddModel> getStudentByCode(String code) async {
    final dbClient = await db;
    var result = await dbClient
        .query("student", where: "studentcode = ?", whereArgs: [code]);
    return (result != null && result.isNotEmpty)
        ? StudentAddModel.fromMap(result.first)
        : Null;
  }
  Future<List<StudentAddModel>> convertToStudentAddCode(List<StudentAddModel> stdAddModel,Map<String, bool> stdState) async {
    for(int i = 0; i< stdAddModel.length; i++){
      if(stdState.containsKey(stdAddModel[i].studentCode)){
        stdAddModel[i].isAdd = stdState[stdAddModel[i].studentCode];
      }else{
        stdAddModel[i].isAdd = false;
      }
    }
    return stdAddModel;
  }
  Future<List<StudentAddModel>> getStudentsByCode(String code) async {
    List<StudentAddModel> students = [];
    if (code != null && code.isNotEmpty) {
      var codeList = code.split(',');
      if (codeList != null && codeList.isNotEmpty) {
        for (int i = 0; i < codeList.length; i++) {
          if (codeList[i] != null &&
              codeList[i].isNotEmpty &&
              codeList[i] != "") {
            var st = await getStudentByCode(codeList[i]);
            if (st != null) {
              students.add(st);
            }
          }
        }
      }
    }
    return students;
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
//  Future<List<StudentAddModel>> getStudentsAddByClassCode(String classCode) async {
//    List<StudentModel> stdLst= new List<StudentModel>();
//    List<StudentAddModel> stdAddLst= new List<StudentAddModel>();
//    stdLst = await getStudents();
//
//  }
  Future<List<StudentAddModel>> getStudentsToAdd(
      List<StudentAddModel> studentList) async {
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
    List<StudentAddModel> students = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        if (!isContain(
            studentList, StudentAddModel.fromMap(maps[i]).studentCode)) {
          students.add(StudentAddModel.fromMap(maps[i]));
        }
      }
    }
    return students;
  }

  bool isContain(List<StudentAddModel> studentList, String studentCode) {
    if (studentList != null && studentList.length > 0) {
      for (int i = 0; i < studentList.length; i++) {
        if (studentList[i].studentCode == studentCode) {
          return true;
        }
      }
    }
    return false;
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

  Future<ClassesModel> getClassesById(int id) async {
    final dbClient = await db;
    var result =
        await dbClient.query("classes", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? ClassesModel.fromMap(result.first) : Null;
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
            classCodeWithoutSign
                .toUpperCase()
                .contains(textWithoutSign.toUpperCase()) ||
            classNameWithoutSign.contains(textWithoutSign) ||
            classNameWithoutSign
                .toUpperCase()
                .contains(textWithoutSign.toUpperCase())) {
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

  Future<void> addStudentCode(
      int classId, List<StudentAddModel> studentAdd) async {
    var currentClasses = await getClassesById(classId);
    var currentStudentCode = currentClasses.studentCodeList;
    var currentList = currentStudentCode.split(',');
    for (int i = 0; i < studentAdd.length; i++) {
      if (currentList != null &&
          currentList.isNotEmpty &&
          !currentList.contains(studentAdd[i].studentCode)) {
        if (currentStudentCode.isNotEmpty || currentStudentCode != null) {
          currentStudentCode =
              currentStudentCode + "," + studentAdd[i].studentCode;
        } else {
          currentStudentCode = studentAdd[i].studentCode;
        }

        currentList.add(studentAdd[i].studentCode);
      }
    }
    currentClasses.studentCodeList = currentStudentCode;
    updateClass(currentClasses);
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

  Future<void> deleteAllClasses() async {
    var data = await getClasses();
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        await deleteClass(data[i].id);
      }
    }
  }

  Future<void> deleteAllStudent() async {
    var data = await getStudents();
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        await deleteStudent(data[i].id);
      }
    }
  }

  Future<void> initStudent(List<StudentModel> students) async {
    await deleteAllStudent();
    for (int i = 0; i < students.length; i++) {
      addStudent(students[i]);
    }
  }

  Future<void> initClasses(List<ClassesModel> classes) async {
    await deleteAllClasses();
    for (int i = 0; i < classes.length; i++) {
      addClass(classes[i]);
    }
  }
}
