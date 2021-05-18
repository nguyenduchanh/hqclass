import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Pages/Register/RegisterWithGoogle/service/authentication.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPageBody extends StatefulWidget {
  const UserInfoPageBody({Key key}) : super(key: key);

  @override
  _UserInfoPageBodyState createState() => _UserInfoPageBodyState();
}

class _UserInfoPageBodyState extends State<UserInfoPageBody> {
  User _user;
  bool _isSigningOut = false;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // nút đăng xuất
    final fingerSprintButton = OutlinedButton(
      onPressed: () async {
        prefs = await SharedPreferences.getInstance();
        SignInSource signInSource =
            prefs.getString("signInSource") == SignInSource.none.toString()
                ? SignInSource.none
                : SignInSource.google;
        if (signInSource == SignInSource.google) {
          await Authentication.signOut(context: context);
        }
        NavigatorHelper().toLoginPage(context);
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: BorderSide(width: 1, color: Colors.red),
      ),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.login_rounded,
              color: Colors.red,
              size: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Đăng xuất',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _isSigningOut
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : fingerSprintButton

              ],
            ),
          ),
        ),
      ),
    );
  }
}
