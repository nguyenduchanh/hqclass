import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/auth.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Pages/LoginWithGoogle/custom_color.dart';
import 'package:hqclass/Pages/LoginWithGoogle/google_sign_in_button.dart';
import 'package:hqclass/Pages/LoginWithGoogle/service/authentication.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/google_firebase_button.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController _userNameController;
  TextEditingController _passwordController;

  SharedPreferences prefs;
  String _userNameLocal;
  String _passwordLocal;

  void initState() {
    super.initState();
    _loadData();
  }

  //Loading counter value on start
  Future<Null> _loadData() async {
    prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString("userName");
    String password = prefs.getString("password");
    SignInSource signInSource = prefs.getString("signInSource")==SignInSource.none.toString()?SignInSource.none:SignInSource.google;
    _userNameLocal = userName;
    _passwordLocal = password;
    setState(() {
      _userNameController = new TextEditingController(text: userName);
      _passwordController = new TextEditingController(text: password);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final userNameField = TextFormField(
        autofocus: false,
        validator: (value) {
          if (_userNameController.text.isEmpty) {
            return 'Please Enter User Name';
          }
          if (_userNameController.text.trim() == "")
            return "Only Space is Not Valid!!!";
          return null;
        },
        onSaved: (value) => value.isEmpty ? _userNameController.text : "",
        controller: _userNameController,
        decoration: buildInputDecoration(
            CommonString.cUsername, Icons.email, CommonString.cEmailOrUser));
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (_passwordController.text.isEmpty) {
          return 'Please Enter Password!';
        }
        if (_passwordController.text.trim() == "")
          return "Only Space is Not Valid!!!";
        return null;
      },
      onSaved: (value) => _passwordController.text = value,
      controller: _passwordController,
      decoration: buildInputDecoration(CommonString.cPassword, Icons.lock,
          CommonString.cPasswordPlaceHolder),
    );
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        CircularProgressIndicator(),
        Text(CommonString.cAuthenticating)
      ],
    );
    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          child: Text(
            CommonString.cForgotPassword,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        TextButton(
          onPressed: () {
            NavigatorHelper().toRegisterPage(context);
          },
          child: Text(CommonString.cSignUpButton,
              style: TextStyle(fontWeight: FontWeight.w300)),
        )
      ],
    );

    var doLogin = () async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        if (_userNameController.text == _userNameLocal &&
            _passwordController.text == _passwordLocal) {
          NavigatorHelper().toClassesPage(context);
        } else {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: CommonString.cDataInvalid,
            message: CommonString.cReEnterLoginForm,
            duration: Duration(seconds: 10),
          ).show(context);
        }
      } else {
//          print(CommonString.cDataInvalid);
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: CommonString.cDataInvalid,
          message: CommonString.cReEnterLoginForm,
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(top: 5, bottom: 10, left: 30, right: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.02),
                Image.asset(
                  "assets/img/blackboard.png",
                  height: size.height * 0.2,
                ),
                SizedBox(height: 15.0),
//                _userNameTextFormField,
                userNameField,
                SizedBox(height: 15.0),
                passwordField,
                SizedBox(height: 15.0),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons(CommonString.cLoginButton, doLogin),

                SizedBox(height: 5.0),
                forgotLabel
              ],
            ),
          ),
        ),
      ),
    );
  }
}
