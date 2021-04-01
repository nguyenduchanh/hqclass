import 'dart:convert';

class ClassesModel {
  int id;
  String classCode;
  String className;
  String contactName;
  String contactPhone;
  int numberOfStudents;
  String studentCodeList;

  ClassesModel(
      this.id,
      this.classCode,
      this.className,
      this.contactName,
      this.contactPhone,
      this.numberOfStudents,
      this.studentCodeList);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'classcode': classCode,
      'classname': className,
      'contactname': contactName,
      'contactphone': contactPhone,
      'numberofstudents': numberOfStudents,
      'studentcodelist': studentCodeList,

    };
    return map;
  }

  ClassesModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    classCode = map['classcode'];
    className = map['classname'];
    contactName = map['contactname'];
    contactPhone = map['contactphone'];
    numberOfStudents = map['numberofstudents'];
    studentCodeList = map['studentcodelist'];
  }
}
