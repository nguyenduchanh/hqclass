class StudentModel{
  int id;
  String studentCode;
  String studentName;
  int studentAge;
  String parentName;
  String parentPhone;
  String createDate;
  String createBy;
  String updatedDate;
  String updatedBy;

  StudentModel(this.id,this.studentCode,this.studentName, this.studentAge, this.parentName, this.parentPhone, this.createBy, this.createDate, this.updatedBy, this.updatedDate);
  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      'studentcode': studentCode,
      'studentname': studentName,
      'studentage': studentAge,
      'parentname': parentName,
      'parentphone': parentPhone,
      'createdate': createDate,
      'createby': createBy,
      'updateddate': updatedDate,
      'updatedby': updatedBy,

    };
    return map;
  }
  StudentModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    studentCode = map['studentcode'];
    studentName = map['studentname'];
    studentAge = map['studentage'];
    parentName = map['parentname'];
    parentPhone = map['parentphone'];
    createDate = map['createdate'];
    createBy = map['createby'];
    updatedDate = map['updateddate'];
    updatedBy = map['updatedby'];
  }
}