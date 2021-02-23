import 'package:date_time_picker/date_time_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/classes.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class ClassDetailBody extends StatelessWidget {
  final Classes classes;
  final formKey = new GlobalKey<FormState>();

  ClassDetailBody({Key key, @required this.classes}) : super(key: key);
  String _classCode,
      _className,
      _contactName,
      _numberOfStudents,
      _createDate,
      _createBy,
      _updatedDate,
      _updatedBy,
      _confirmPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // class code field
    final classCodeField = TextFormField(
      initialValue: (classes != null && classes.classCode != null)
          ? classes.classCode
          : "",
      autofocus: (classes != null && classes.classCode != null) ? false : true,
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
      validator: (value) => value.isEmpty ? CommonString.cEnterClassName : null,
      onSaved: (value) => _contactName = value,
      decoration: buildInputDecorationWithoutIcon(
          CommonString.cContactName, CommonString.cEnterContactName),
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
      onSaved: (value) => _numberOfStudents = value,
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
      onChanged: (val) => print(val),
      validator: (val) {
        return null;
      },
      onSaved: (val) => print(val),
    );
    // Save button
    var doSave = () {
      Flushbar(
        title: "Falied login",
        message: "Fucking",
      ).show(context);
    };

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15.0),
            classCodeField,
            const SizedBox(height: 15.0),
            classNameField,
            const SizedBox(height: 15.0),
            contactNameField,
            const SizedBox(height: 15.0),
            numberOfStudentField,
            const SizedBox(height: 15.0),
            startDate,
            Spacer(),
            longButtons(CommonString.cSaveButton, doSave)
          ],
        ),
      ),
    );
  }
}
