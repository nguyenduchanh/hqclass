class Classes {
  String classCode;
  String className;
  String contactName;
  int classSize;
  DateTime createDate;
  String createBy;
  DateTime updatedDate;
  String updatedBy;

  Classes(
      {this.classCode,
      this.className,
      this.contactName,
      this.classSize,
      this.createDate,
      this.createBy,
      this.updatedDate,
      this.updatedBy}
      );
}

List getClasses() {
  return [
    Classes(
        classCode: "CL01",
        className: "Lớp của em Quỳnh",
        contactName: "Beginner",
        classSize: 20,
        createDate: DateTime.now(),
        createBy: "Hanhnd",
        updatedDate: DateTime.now(),
        updatedBy: "Hanhnd"
    ),

  ];
}