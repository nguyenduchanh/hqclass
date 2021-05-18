import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/controllers/class_controller.dart';
import 'package:hqclass/Domains/controllers/student_controller.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Domains/models/user.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

class BackupPage extends StatefulWidget {
  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  String _domain = "http://10.1.3.136";
  List<ClassesModel> classesList;
  List<StudentModel> studentList;
  UserModel userList;
  String logStr = CommonString.cBackUpInitString;
  BaseDao baseDao;
  bool isExportStudent = false;
  bool isExportClasses = false;

  @override
  void initState() {
    super.initState();
    baseDao = BaseDao();
  }

  doExport() async {
    logStr = "";
    studentList = await baseDao.getStudents();
    classesList = await baseDao.getClasses();
    if (studentList != null && studentList.length > 0) {
      isExportStudent =
      await StudentController().ExportStudents(_domain, studentList);
    } else {
      printResult("Dữ liệu học sinh không tồn tại");
    }
    if (classesList != null && classesList.length > 0) {
      isExportClasses = isExportClasses =
      await ClassController().ExportClasses(_domain, classesList);
    } else {
      printResult("Dữ liệu lớp học không tồn tại");
    }

    setState(() {
      if (isExportStudent) {
        printResult("Xuất danh sách học sinh thành công");
      } else {
        printResult("Xuất danh sách học sinh không thành công");
      }

      if (isExportClasses) {
        printResult("Xuất danh sách lớp học thành công");
      } else {
        printResult("Xuất danh sách lớp học không thành công");
      }
    });
  }

  doImport() async {
    logStr = "";
    classesList = await ClassController().GetClasses(_domain);
//    userList = await UserController().GetUsers(_domain);
    studentList = await StudentController().GetStudents(_domain);
    setState(() {
      if (classesList.length > 0) {
        printResult("-----Danh sách lớp học:-----");
        baseDao.initClasses(classesList);
      }

      printResult("-----Danh sách học sinh:-----");
      if (studentList.length > 0) {
        baseDao.initStudent(studentList);
      }
    });
  }

  printResult(String txt) async {
    logStr += txt + "\n";
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _urlDomainController =
    new TextEditingController(text: _domain);

    final urlFromField = new TextFormField(
      autofocus: false,
      initialValue: _domain,
      keyboardType: TextInputType.url,
      onSaved: (value) => _domain = value,
      onChanged: (text) {
        _domain = text;
      },
      decoration: buildInputDecoration(CommonString.cEnterUrlString,
          Icons.add_link, CommonString.cUrlString),
    );
    final cardResult = new Container(
      // adding padding
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
      // height should be fixed for vertical scrolling
      height: 500.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white30,
          width: 1.0,
        ),
      ),
      child: Form(
        child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(
                    logStr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Navbar(
        title: CommonString.cBackupPageNav,
        searchBar: false,
        rightOptions: false,
      ),
      backgroundColor: CommonColors.bgColorScreen,
      drawer: CommonDrawer(currentPage: "Backup"),
      body: SingleChildScrollView(
        child:Container(
            padding: EdgeInsets.only(top: 5, bottom: 10, left: 30, right: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  urlFromField,
                  SizedBox(height: 15.0),
                  longButtons(CommonString.cImportButton, doImport),
                  SizedBox(height: 15.0),
                  longButtons(CommonString.cExportButton, doExport),
                  SizedBox(height: 15.0),
                  cardResult,
                ])
          //
        ),
      ),
    );
  }
}
