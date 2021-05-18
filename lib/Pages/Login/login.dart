import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hqclass/Domains/auth.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  bool _isUseBiometric = false;
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = [];

  TextEditingController _userNameController;
  TextEditingController _passwordController;

  SharedPreferences prefs;
  String _userNameLocal;
  String _passwordLocal;

  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listofBiometrics;
    try {
      listofBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listofBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  //Loading counter value on start
  Future<Null> _loadData() async {
    prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString("userName");
    String password = prefs.getString("password");
    _isUseBiometric = prefs.getBool("isBiometricAvailable");
    SignInSource signInSource = prefs.getString("signInSource") ==
        SignInSource.none.toString() ? SignInSource.none : SignInSource.google;
    _canCheckBiometric =
    await _localAuthentication.canCheckBiometrics;
    // List<BiometricType> availableBiometrics =
    // await _localAuthentication.getAvailableBiometrics();
    if (_isUseBiometric && _canCheckBiometric) {

    }

    _userNameLocal = userName;
    _passwordLocal = password;
    setState(() {
      _userNameController = new TextEditingController(text: userName);
      _passwordController = new TextEditingController(text: password);
    });
  }

  Future<void> biometricAuth() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticate(
        localizedReason: " ",
        androidAuthStrings: AndroidAuthMessages(
            signInTitle: "Touch Id cho HQClass",
            biometricRequiredTitle: "Sử dụng TouchId để mở khóa",
            biometricHint: "Chạm vào cảm ứng để đăng nhập"
        ),
        useErrorDialogs: false,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
        print("Authorized");
      } else {
        _authorizedOrNot = "Not Authorized";
        print("Not Authorized");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
    final fingerSprintButton = _isUseBiometric ?
      TextButton(
        onPressed: biometricAuth,
        style: ButtonStyle(
//        backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: SizedBox(
          height: 30,
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.fingerprint,
                color: CommonColors.kPrimaryColor,
                size: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  CommonString.cLoginWithFingerButton,
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
      ) : Container();

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
          body: SingleChildScrollView(
            child: Container(
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
                    SizedBox(height: 10.0),
                    fingerSprintButton,
                    SizedBox(height: 5.0),
                    forgotLabel
                  ],
                ),
              ),
            ),
          )

      ),
    );
  }
}
