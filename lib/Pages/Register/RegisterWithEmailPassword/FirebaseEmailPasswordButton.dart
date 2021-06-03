import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/user.dart';
import 'package:hqclass/Util/Constants/cEnum.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class FirebaseEmailPasswordButton extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPassword;

  FirebaseEmailPasswordButton(
      {Key key, this.userName, this.userEmail, this.userPassword})
      : super(key: key);

  @override
  _FirebaseEmailPasswordButtonState createState() =>
      _FirebaseEmailPasswordButtonState();
}

class _FirebaseEmailPasswordButtonState
    extends State<FirebaseEmailPasswordButton> {
  List<String> userFirebaseLst;
  FirebaseAuth auth = FirebaseAuth.instance;
  BaseDao baseDao = BaseDao();

  @override
  Widget build(BuildContext context) {
    var doRegister = () async {
      userFirebaseLst = await auth.fetchSignInMethodsForEmail(widget.userEmail);
      if (userFirebaseLst.length > 0) {
      } else {
        auth
            .createUserWithEmailAndPassword(
                email: widget.userEmail, password: widget.userPassword)
            .then((_) async {
          await baseDao.deleteAllUser();
          final newUser = new UserModel(0, widget.userName, widget.userPassword, widget.userPassword,
              Platform.isIOS ? "IOS" : "Android", false, RegisterTypeEnum.Email,"");
          var idClass = await baseDao.addUser(newUser);
          if(idClass > 0){
            NavigatorHelper().toLoginPage(context);
          }{
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: CommonString.cDataInvalid,
              message: CommonString.cReEnterLoginForm,
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      }
    };
    return longButtons(CommonString.cSignUpButton, doRegister);
  }
}
