import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/user.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Pages/Register/RegisterWithGoogle/service/authentication.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/globals.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPageBody extends StatefulWidget {
  const UserInfoPageBody({Key key}) : super(key: key);

  @override
  _UserInfoPageBodyState createState() => _UserInfoPageBodyState();
}

class _UserInfoPageBodyState extends State<UserInfoPageBody> {
  User _user;
  bool _isSigningOut = false;
  bool isSwitched = false;
  bool _canCheckBiometric = false;
  bool _isUseBiometric = false;
  SharedPreferences prefs;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  UserModel userModel;
  BaseDao baseDao = BaseDao();

  @override
  void initState() {
    super.initState();
    userModel = Global.userModel;
    _isUseBiometric = (userModel!=null && userModel.isBiometricAvailable!=null)?userModel.isBiometricAvailable:false;
    setState(() {
      _loadData();
    });
  }

  _loadData() async {
    _canCheckBiometric = await _localAuthentication.canCheckBiometrics;

  }

  @override
  Widget build(BuildContext context) {
    final switchButton = Container(
      child: Switch(
        value: _isUseBiometric,
        onChanged: (value) {
          setState(() {
            userModel = Global.userModel;
            userModel.isBiometricAvailable = value;
            _isUseBiometric = value;
            baseDao.updateUser(userModel);
          });
        },
        activeTrackColor: CommonColors.kPrimaryLightColor,
        activeColor: CommonColors.kPrimaryColor,
      ),
    );
    // nút đăng xuất
    final signOutButton = OutlinedButton(
      onPressed: () async {
        // prefs = await SharedPreferences.getInstance();
        // SignInSource signInSource =
        //     prefs.getString("signInSource") == SignInSource.none.toString()
        //         ? SignInSource.none
        //         : SignInSource.google;
        // if (signInSource == SignInSource.google) {
        //   await Authentication.signOut(context: context);
        // }
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.login_rounded,
              color: Colors.red,
              size: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                CommonString.cSignOutButton,
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
    // seting
    // cài đặt chế độ đăng nhập bằng touch Id hoặc face id
    final biometricLoginSetting = Card(
        shadowColor: CommonColors.kPrimaryColor,
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 10, top: 10, bottom: 10),
                child: ListTile(
                  title: Text(CommonString.cLoginWithTouchId),
                  subtitle: Text(CommonString.cLoginWithTouchIdHint),
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[switchButton],
              ),
            ),
          ],
        ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            child: new Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                biometricLoginSetting,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: _isSigningOut
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : signOutButton,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
