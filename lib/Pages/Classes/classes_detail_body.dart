import 'package:date_time_picker/date_time_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class ClassDetailBody extends StatelessWidget {
  final ClassesModel classes;
  final formKey = new GlobalKey<FormState>();
  BaseDao baseDao = BaseDao();

  ClassDetailBody({Key key, @required this.classes}) : super(key: key);
  String _classCode,
      _className,
      _contactName,
      _contactPhone,
      _createDate,
      _createBy,
      _updatedDate,
      _updatedBy;
  int _numberOfStudents;

  @override
  Widget build(BuildContext context) {
    // class code field
    final classCodeField = TextFormField(
      initialValue: (classes != null && classes.classCode != null)
          ? classes.classCode
          : "",
      autofocus: (classes != null && classes.classCode != null) ? false : true,
      enabled: classes != null ? false : true,
      validator: (value) => value.isEmpty ? CommonString.cEnterClassCode : null,
      onSaved: (value) => _classCode = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cClassCode, CommonString.cEnterClassCode),
    );
    // class name field
    final classNameField = TextFormField(
      initialValue: (classes != null && classes.className != null)
          ? classes.className
          : "",
      autofocus: false,
      validator: (value) => value.isEmpty ? CommonString.cEnterClassName : null,
      onSaved: (value) => _className = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cClassName, CommonString.cEnterClassName),
    );
    // contact name field
    final contactNameField = TextFormField(
      initialValue: (classes != null && classes.contactName != null)
          ? classes.contactName
          : "",
      autofocus: false,
      keyboardType: TextInputType.name,
      validator: (value) =>
          value.isEmpty ? CommonString.cEnterContactName : null,
      onSaved: (value) => _contactName = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cContactName, CommonString.cEnterContactName),
    );
    final contactPhoneField = TextFormField(
      initialValue: (classes != null && classes.contactPhone != null)
          ? classes.contactPhone
          : "",
      autofocus: false,
      keyboardType: TextInputType.phone,
      validator: (value) =>
          value.isEmpty ? CommonString.cEnterContactPhone : null,
      onSaved: (value) => _contactPhone = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cContactPhone, CommonString.cEnterContactPhone),
    );
    //number of student
    final numberOfStudentField = TextFormField(
      initialValue: (classes != null && classes.numberOfStudents != null)
          ? classes.numberOfStudents.toString()
          : "",
      keyboardType: TextInputType.number,
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? CommonString.cEnterNumberOfStudent : null,
      onSaved: (value) => _numberOfStudents = int.parse(value),
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cNumberOfStudent, CommonString.cEnterNumberOfStudent),
    );
    //create date field
    final startDate = DateTimePicker(
      type: DateTimePickerType.dateTime,
      dateMask: 'dd/MM/yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Date',
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cStartDate, CommonString.cStartDate),
      selectableDayPredicate: (date) {
        // Disable weekend days to select from the calendar
        if (date.weekday == 6 || date.weekday == 7) {
          return false;
        }
        return true;
      },
      validator: (val) {
        return null;
      },
    );
    var afterSuccess = () async {
      Navigator.pop(context);

//      Flushbar(
//        duration: Duration(seconds: 3),
//        title: CommonString.cSaveDataSuccess,
//        message: CommonString.cSaveDataSuccessMessage,
//      ).show(context);
    };
    // Save button
    var doSave = () async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        // thêm mới
        if (classes == null) {
          final newClass = new ClassesModel(0, _classCode, _className,
              _contactName, _contactPhone, _numberOfStudents, null);
          var idClass = await baseDao.addClass(newClass);
          if (idClass > 0) {
            NavigatorHelper().toClassesPage(context);
          } else {
            Flushbar(
              duration: Duration(seconds: 3),
              title: CommonString.cSaveDataFail,
              message: CommonString.cSaveDataFailMessage,
            ).show(context);
          }
        } else {
          // cập nhật
          final updateClass = new ClassesModel(
              classes.id,
              _classCode,
              _className,
              _contactName,
              _contactPhone,
              _numberOfStudents,
              classes.studentCodeList);
          int updateClassId = await baseDao.updateClass(updateClass);
          if (updateClassId > 0) {
            NavigatorHelper().toClassesPage(context);
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
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    classCodeField,
                    SizedBox(height: 15.0),
                    classNameField,
                    SizedBox(height: 15.0),
                    contactNameField,
                    SizedBox(height: 15.0),
                    contactPhoneField,
                    SizedBox(height: 15.0),
                    numberOfStudentField,
//                    SizedBox(height: 15.0),
//                    startDate,
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
