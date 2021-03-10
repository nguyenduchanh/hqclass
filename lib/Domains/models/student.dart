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

  StudentModel(this.id,this.studentName, this.studentAge);
  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      'studentCode': studentCode,
      'studentName': studentName,
      'studentAge': studentAge,
      'parentName': parentName,
      'parentPhone': parentPhone,
      'createDate': createDate,
      'createBy': createBy,
      'updatedDate': updatedDate,
      'updatedBy': updatedBy,

    };
    return map;
  }
  StudentModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    studentCode = map['studentCode'];
    studentName = map['studentName'];
    studentAge = map['studentAge'];
    parentName = map['parentName'];
    parentPhone = map['parentPhone'];
    createDate = map['createDate'];
    createBy = map['createBy'];
    updatedDate = map['updatedDate'];
    updatedBy = map['updatedBy'];
  }
}