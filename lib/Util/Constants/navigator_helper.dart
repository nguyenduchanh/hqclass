
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Pages/LoginWithGoogle/service/authentication.dart';
import 'package:hqclass/Pages/LoginWithGoogle/user_info_screen.dart';
import 'package:hqclass/Pages/UserInfo/user_info_body.dart';

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
  toAddStudentPage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/addStudent');
  }
  toLoginPage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/login');
  }
  toRegisterPage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/register');
  }
  toBackupPage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/backup');
  }
  toUserInfoPage(BuildContext context) async{
    Navigator.pushReplacementNamed(context, '/user_info');
  }
}
