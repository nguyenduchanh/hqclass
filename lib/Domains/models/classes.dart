class Classes {
  int id;
  String classCode;
  String className;
  String contactName;
  String contactPhone;
  int numberOfStudents;
  DateTime createDate;
  String createBy;
  DateTime updatedDate;
  String updatedBy;

  Classes(
      this.id,
      this.classCode,
      this.className,
      this.contactName,
      this.contactPhone,
      this.numberOfStudents,
      this.createDate,
      this.createBy,
      this.updatedDate,
      this.updatedBy);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'classcode': classCode,
      'classname': className,
      'contactname': contactName,
      'contactphone': contactPhone,
      'numberofstudents': numberOfStudents,
      'createdate': createDate,
      'createby': createBy,
      'updateddate': updatedDate,
      'updatedby': updatedBy
    };
    return map;
  }

  Classes.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    classCode = map['classcode'];
    className = map['classname'];
    contactName = map['contactname'];
    contactPhone = map['contactphone'];
    numberOfStudents = map['numberofstudents'];
    createDate = map['createdate'];
    createBy = map['createby'];
    updatedDate = map['updateddate'];
    updatedBy = map['updatedby'];
  }
}

List getClasses() {
  return [
    Classes(1, "CL01", "Lớp của em Quỳnh", "Beginner", "0981831653", 20,
        DateTime.now(), "Hanhnd", DateTime.now(), "Hanhnd"),
    Classes(2, "CL01", "Lớp của em Quỳnh", "Beginner", "0981831653", 20,
        DateTime.now(), "Hanhnd", DateTime.now(), "Hanhnd")
  ];
}
