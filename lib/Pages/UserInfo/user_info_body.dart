import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Pages/Register/RegisterWithGoogle/service/authentication.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInfoPageBody extends StatefulWidget {
  const UserInfoPageBody({Key key})
      : super(key: key);


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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(

              ),
              _isSigningOut
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.redAccent,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  prefs = await SharedPreferences.getInstance();
                  SignInSource signInSource = prefs.getString("signInSource")==SignInSource.none.toString()?SignInSource.none:SignInSource.google;
                  if(signInSource == SignInSource.google){
                    await Authentication.signOut(context: context);
                  }
//                  await UserPreferences().CreateUserConfig("", "", "",SignInSource.none);
                  NavigatorHelper().toLoginPage(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
