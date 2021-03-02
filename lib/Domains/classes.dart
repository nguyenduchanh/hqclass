class Classes {
  String classCode;
  String className;
  String contactName;
  String contactPhone;
  int numberOfStudents;
  DateTime createDate;
  String createBy;
  DateTime updatedDate;
  String updatedBy;

  Classes({this.classCode,
    this.className,
    this.contactName,
    this.contactPhone,
    this.numberOfStudents,
    this.createDate,
    this.createBy,
    this.updatedDate,
    this.updatedBy});
}
List getClasses() {
  return [
    Classes(
        classCode: "CL01",
        className: "Lớp của em Quỳnh",
        contactName: "Beginner",
        contactPhone: "0981831653",
        numberOfStudents: 20,
        createDate: DateTime.now(),
        createBy: "Hanhnd",
        updatedDate: DateTime.now(),
        updatedBy: "Hanhnd"),
  Classes(
      classCode: "CL01",
      className: "Lớp của em Quỳnh",
      contactName: "Beginner",
      contactPhone: "0981831653",
      numberOfStudents: 20,
      createDate: DateTime.now(),
      createBy: "Hanhnd",
      updatedDate: DateTime.now(),
      updatedBy: "Hanhnd")
  ];
}
