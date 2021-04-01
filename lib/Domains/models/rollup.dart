import 'dart:convert';

class RollUpModel{
  int id;
  String classCode;
  String studentCodeList;
  DateTime createDate;
  Map<String, bool> rollupData;
  RollUpModel(
      this.id,
      this.classCode,
      this.studentCodeList,
      this.createDate,
      this.rollupData,);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
//      'id': id,
      'classcode': classCode,
      'studentcodelist': studentCodeList,
      'createdate': createDate.toString(),
      'rollupdata': json.encode(rollupData),
    };
    return map;
  }

  RollUpModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    classCode = map['classcode'];
    studentCodeList = map['studentcodelist'];
    createDate = DateTime.parse(map['createdate']);
    Map<String, bool> tmp = new Map<String, bool>();
    var dtStr = json.decode(map['rollupdata']);
    tmp = Map<String, bool>.from(dtStr);
    rollupData = tmp;
  }
}