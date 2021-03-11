
import 'package:flutter/material.dart';

class NavigatorHelper {
  toStudentPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/students');
  }
  toClassesPage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/classes');
  }
  toHomePage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/home');
  }
  toRollUpPage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/rollup');
  }
  toLoginPage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/login');
  }
  toRegisterPage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/register');
  }
}
