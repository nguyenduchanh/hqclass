import 'Constants/strings.dart';

String validateEmail(String value){
  String _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = CommonString.cEmailRequire;
  } else if (!regex.hasMatch(value)){
    _msg = CommonString.cValidEmailMessage;
  }
  return _msg;
}