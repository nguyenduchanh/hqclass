class StudentModel {
  int id;
  String studentCode;
  String studentName;
  int studentAge;
  String schoolName;
  String address;
  String parentName;
  String parentPhone;
  int currentState;
  String createDate;
  String createBy;
  String updatedDate;
  String updatedBy;

  StudentModel(
      this.id,
      this.studentCode,
      this.studentName,
      this.studentAge,
      this.schoolName,
      this.address,
      this.parentName,
      this.parentPhone,
      this.currentState,
      this.createBy,
      this.createDate,
      this.updatedBy,
      this.updatedDate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'studentcode': studentCode,
      'studentname': studentName,
      'studentage': studentAge,
      'schoolname': schoolName,
      'address': address,
      'parentname': parentName,
      'parentphone': parentPhone,
      'currentstate': currentState,
      'createdate': createDate,
      'createby': createBy,
      'updateddate': updatedDate,
      'updatedby': updatedBy,
    };
    return map;
  }

  StudentModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    studentCode = map['studentcode'];
    studentName = map['studentname'];
    studentAge = map['studentage'];
    parentName = map['parentname'];
    parentPhone = map['parentphone'];
    currentState = map['currentstate'];
    schoolName = map['schoolname'];
    address = map['address'];
    createDate = map['createdate'];
    createBy = map['createby'];
    updatedDate = map['updateddate'];
    updatedBy = map['updatedby'];
  }
  @override
  String toString() {
    return '{id: $id, studentcode: $studentCode, studentname: $studentName, studentage: $studentAge, parentname: $parentName, parentphone: $parentPhone,currentstate: $currentState,schoolname: $schoolName,address: $address,createdate: $createDate,createby: $createBy,updateddate: $updatedDate,updatedby: $updatedBy}';
  }
}
