import 'package:date_time_picker/date_time_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class StudentDetailBodyPage extends StatelessWidget{
  final StudentModel studentModel;
  final formKey = new GlobalKey<FormState>();
  BaseDao baseDao = BaseDao();

  StudentDetailBodyPage({Key key, @required this.studentModel}) : super(key: key);
  String _studentCode,
      _studentName,
      _parentName,
      _parentPhone,
      _createDate,
      _createBy,
      _updatedDate,
      _updatedBy;
  @override
  Widget build(BuildContext context) {
    final studentCodeField = TextFormField(
      initialValue: (studentModel != null && studentModel.studentCode != null)
          ? studentModel.studentCode
          : "",
      autofocus: (studentModel != null && studentModel.studentCode != null) ? false : true,
      validator: (value) => value.isEmpty ? CommonString.cEnterStudentCode : null,
      onSaved: (value) => _studentCode = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cStudentCode, CommonString.cEnterStudentCode),
    );
    // class name field
    final studentNameField = TextFormField(
      initialValue: (studentModel != null && studentModel.studentName != null)
          ? studentModel.studentName
          : "",
      autofocus: false,
      validator: (value) => value.isEmpty ? CommonString.cEnterStudentName : null,
      onSaved: (value) => _studentName = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cStudentName, CommonString.cEnterStudentName),
    );
    // contact name field
    final parentNameField = TextFormField(
      initialValue: (studentModel != null && studentModel.parentName != null)
          ? studentModel.parentName
          : "",
      autofocus: false,
      validator: (value) => value.isEmpty ? CommonString.cEnterParentName : null,
      onSaved: (value) => _parentName = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cParentName, CommonString.cEnterParentName),
    );
    final parentPhoneField = TextFormField(
      initialValue: (studentModel != null && studentModel.parentPhone != null)
          ? studentModel.parentPhone
          : "",
      autofocus: false,
      validator: (value) =>
      value.isEmpty ? CommonString.cEnterParentPhone : null,
      onSaved: (value) => _parentPhone = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cParentPhone, CommonString.cEnterParentPhone),
    );

    // Save button
    var doSave = () async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        // thêm mới

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
                    parentNameField,
                    SizedBox(height: 15.0),
                    parentPhoneField,
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