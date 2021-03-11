import 'package:date_time_picker/date_time_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class StudentDetailBodyPage extends StatelessWidget {
  final StudentModel studentModel;
  final formKey = new GlobalKey<FormState>();
  BaseDao baseDao = BaseDao();

  StudentDetailBodyPage({Key key, @required this.studentModel})
      : super(key: key);
  String _studentCode,
      _studentName,
      _parentName,
      _parentPhone,
      _schoolName,
      _address,
      _createDate,
      _createBy,
      _updatedDate,
      _updatedBy;
  int _studentAge, _currentState;
  bool _stateChecked;

  @override
  Widget build(BuildContext context) {
    // student code
    final studentCodeField = TextFormField(
      initialValue: (studentModel != null && studentModel.studentCode != null)
          ? studentModel.studentCode
          : "",
      autofocus: (studentModel != null && studentModel.studentCode != null)
          ? false
          : true,
      validator: (value) =>
      value.isEmpty ? CommonString.cEnterStudentCode : null,
      onSaved: (value) => _studentCode = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cStudentCode, CommonString.cEnterStudentCode),
    );
    // student name field
    final studentNameField = TextFormField(
      initialValue: (studentModel != null && studentModel.studentName != null)
          ? studentModel.studentName
          : "",
      autofocus: false,
      keyboardType: TextInputType.name,
      validator: (value) =>
      value.isEmpty ? CommonString.cEnterStudentName : null,
      onSaved: (value) => _studentName = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cStudentName, CommonString.cEnterStudentName),
    );
    // student age
    final studentAgeField = TextFormField(
      initialValue: (studentModel != null && studentModel.studentAge != null)
          ? studentModel.studentAge.toString()
          : "",
      autofocus: false,
      keyboardType: TextInputType.number,
      validator: (value) =>
      value.isEmpty ? CommonString.cEnterStudentAge : null,
      onSaved: (value) => (value != null) ? _studentAge = int.parse(value) : 0,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cStudentAge, CommonString.cEnterStudentAge),
    );
    // school name
    final schoolNameField = TextFormField(
      initialValue: (studentModel != null && studentModel.schoolName != null)
          ? studentModel.schoolName
          : "",
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? CommonString.cEnterSchoolName : null,
      onSaved: (value) => _schoolName = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cSchoolName, CommonString.cEnterSchoolName),
    );
    // address
    final addressField = TextFormField(
      initialValue: (studentModel != null && studentModel.address != null)
          ? studentModel.address
          : "",
      autofocus: false,
      onSaved: (value) => _schoolName = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cAddress, CommonString.cEnterAddress),
    );
    // contact name field
    final parentNameField = TextFormField(
      initialValue: (studentModel != null && studentModel.parentName != null)
          ? studentModel.parentName
          : "",
      autofocus: false,
      onSaved: (value) => _parentName = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cParentName, CommonString.cEnterParentName),
    );
    final parentPhoneField = TextFormField(
      initialValue: (studentModel != null && studentModel.parentPhone != null)
          ? studentModel.parentPhone
          : "",
      autofocus: false,
      keyboardType: TextInputType.phone,
      onChanged: (text) {
        _parentPhone = text;
      },
//      onSaved: (value) => _parentPhone = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cParentPhone, CommonString.cEnterParentPhone),
    );
//    final currentStateField = TextFormField(
//      enabled: false,
//      initialValue: (studentModel != null && studentModel.parentName != null)?"Đã nghỉ":"Đang hoạt động",
//      autofocus: false,
//      decoration: buildInputDecorationWithoutIcon(
//          CommonString.cState, CommonString.cEnterState),
//    );

    // Save button
    var doSave = () async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        // thêm mới
        if (studentModel == null) {
          var newStudent = new StudentModel(
              0,
              _studentCode,
              _studentName,
              _studentAge,
              _schoolName,
              _address,
              _parentName,
              _parentPhone,
              1,
              'admin',
              DateTime.now().toString(),
              'admin',
              DateTime.now().toString());
          var idStudent = await baseDao.addStudent(newStudent);
          if (idStudent > 0) {
            NavigatorHelper().toStudentPage(context);
          } else {
            Flushbar(
              duration: Duration(seconds: 3),
              title: CommonString.cSaveDataFail,
              message: CommonString.cSaveDataFailMessage,
            ).show(context);
          }
        } else {
          var updateStudent = new StudentModel(
              studentModel.id,
              _studentCode,
              _studentName,
              _studentAge,
              _schoolName,
              _address,
              _parentName,
              _parentPhone,
              studentModel.currentState,
              studentModel.createBy,
              studentModel.createDate,
              studentModel.updatedBy,
              studentModel.updatedDate);
          var isStudentUpdate = await baseDao.updateStudent(updateStudent);
          if (isStudentUpdate > 0) {
            NavigatorHelper().toStudentPage(context);
          } else {
            Flushbar(
              duration: Duration(seconds: 3),
              title: CommonString.cSaveDataFail,
              message: CommonString.cSaveDataFailMessage,
            ).show(context);
          }
        }
      } else {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: CommonString.cDataInvalid,
          message: CommonString.cReEnterLoginForm,
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    studentCodeField,
                    SizedBox(height: 15.0),
                    studentNameField,
                    SizedBox(height: 15.0),
                    studentAgeField,
                    SizedBox(height: 15.0),
                    schoolNameField,
                    SizedBox(height: 15.0),
                    addressField,
                    SizedBox(height: 15.0),
                    parentNameField,
                    SizedBox(height: 15.0),
                    parentPhoneField,
                    SizedBox(height: 15.0),
//                    currentStateField,
                    SizedBox(height: 20.0),
                    longButtons(CommonString.cSaveButton, doSave),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
