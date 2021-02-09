import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class ClassDetailBody extends StatefulWidget {
  @override
  _ClassDetailState createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetailBody> {
  final formKey = new GlobalKey<FormState>();

  String _classCode, _className, _contactName,_numberOfStudents,_createDate,_createBy,_updatedDate,_updatedBy, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final classCodeField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? CommonString.cUsernameRequire : null,
      onSaved: (value) =>_classCode = value,
      decoration: buildInputDecoration("", Icons.account_box, CommonString.cUsername),
    );
  }
}
