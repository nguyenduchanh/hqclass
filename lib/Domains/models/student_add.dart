class StudentAddModel{
  int id;
  String studentCode;
  String studentName;
  int studentAge;
  String schoolName;
  String address;
  String parentName;
  String parentPhone;
  int currentState;
  bool isAdd;
  String createDate;
  String createBy;
  String updatedDate;
  String updatedBy;

  StudentAddModel(
      this.id,
      this.studentCode,
      this.studentName,
      this.studentAge,
      this.schoolName,
      this.address,
      this.parentName,
      this.parentPhone,
      this.currentState,
      this.isAdd,
      this.createBy,
      this.createDate,
      this.updatedBy,
      this.updatedDate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'studentcode': studentCode,
      'studentname': studentName,
      'studentage': studentAge,
      'schoolname': schoolName,
      'address': address,
      'parentname': parentName,
      'parentphone': parentPhone,
      'currentstate': currentState,
      'isadd': isAdd,
      'createdate': createDate,
      'createby': createBy,
      'updateddate': updatedDate,
      'updatedby': updatedBy,
    };
    return map;
  }

  StudentAddModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    studentCode = map['studentcode'];
    studentName = map['studentname'];
    studentAge = map['studentage'];
    parentName = map['parentname'];
    parentPhone = map['parentphone'];
    currentState = map['currentstate'];
    isAdd = false;
    schoolName = map['schoolname'];
    address = map['address'];
    createDate = map['createdate'];
    createBy = map['createby'];
    updatedDate = map['updateddate'];
    updatedBy = map['updatedby'];
  }
}