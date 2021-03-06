import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/user.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Pages/Register/RegisterWithGoogle/service/authentication.dart';
import 'package:hqclass/Util/Constants/cEnum.dart';
import 'package:hqclass/Util/Constants/cString.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';

class GoogleFirebaseButton extends StatefulWidget {
  @override
  _GoogleFirebaseButtonState createState() => _GoogleFirebaseButtonState();
}

class _GoogleFirebaseButtonState extends State<GoogleFirebaseButton> {
  bool _isSigningIn = false;
  BaseDao baseDao = BaseDao();
  @override
  Widget build(BuildContext context) {
    var doRegisterWithGoogle = () async {
      setState(() {
        _isSigningIn = true;
      });
      try {
        User user = await Authentication.signInWithGoogle(context: context);
        setState(() {
          _isSigningIn = false;
        });
        if (user != null) {
          String passwordRandom =
              CString().generatePassword(true, true, true, true, 12);
          await baseDao.deleteAllUser();
          String imageBase64 = await CString().networkImageToBase64(user.photoURL);
          final newUser = new UserModel(0,
              user.displayName,
              passwordRandom,
              user.email,
              Platform.isIOS?"IOS":"Android",
              false,
              RegisterTypeEnum.Google,
              imageBase64
          );
          var idClass = await baseDao.addUser(newUser);
          NavigatorHelper().toLoginPage(context);
        }
      } catch (x) {}
    };
    return Padding(
        padding: const EdgeInsets.all(0),
        child: _isSigningIn
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CommonColors.kPrimaryColor),
                ),
              )
            : OutlinedButton(
                onPressed: doRegisterWithGoogle,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/google_logo.png"),
                        height: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
