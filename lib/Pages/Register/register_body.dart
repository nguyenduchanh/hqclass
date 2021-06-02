import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/auth.dart';
import 'package:hqclass/Domains/models/user.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Pages/Classes/classes_page.dart';
import 'package:hqclass/Pages/Register/RegisterWithPhoneNumber/phone_number_auth.dart';
import 'package:hqclass/Util/Constants/cEnum.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/validators.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:provider/provider.dart';

import 'RegisterWithEmailPassword/FirebaseEmailPasswordButton.dart';
import 'RegisterWithGoogle/google_firebase_button.dart';
import 'RegisterWithGoogle/service/authentication.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();
  BaseDao baseDao = BaseDao();
  List<String> userFirebaseLst;
  String _username, _email, _password, _confirmPassword, _phoneNumber;
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> t;
    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? CommonString.cUsernameRequire : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration(
          CommonString.cUsername, Icons.account_box, CommonString.cUsername),
    );
    final phoneNumberField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.phone,
      validator: (value) =>
          value.isEmpty ? CommonString.cPhoneNumberRequire : null,
      onSaved: (value) => _phoneNumber = value,
      decoration: buildInputDecoration(
          CommonString.cPhoneNumber, Icons.phone, CommonString.cPhoneNumber),
    );
    final emailField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration(
          CommonString.cEmail, Icons.email, CommonString.cEmail),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) =>
          value.isEmpty ? CommonString.cPasswordRequire : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(
          CommonString.cConfirmPassword, Icons.lock, CommonString.cPassword),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty || _confirmPassword != _password
          ? CommonString.cConfirmPasswordRequire
          : null,
      onSaved: (value) => _confirmPassword = value,
      obscureText: true,
      decoration: buildInputDecoration(CommonString.cConfirmPasswordRequire,
          Icons.lock, CommonString.cPasswordRequire),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(CommonString.cRegistering)
      ],
    );

    var doRegister = () async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        userFirebaseLst =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(_email);
        if (userFirebaseLst.length > 0) {
          /// đã có tài khoản sử dụng email này
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: CommonString.cDataInvalid,
            message: CommonString.cFirebaseSignUpError,
            duration: Duration(seconds: 10),
          ).show(context);
        } else {
          // đăng ký cho tài khoang
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _email, password: _password)
              .then((_) async {
            await baseDao.deleteAllUser();
            final newUser = new UserModel(0, _username, _email, _password,
                Platform.isIOS ? "IOS" : "Android", false, RegisterTypeEnum.Email);
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
                    usernameField,
                    SizedBox(height: 15.0),
                    // longButtons(CommonString.cCountrySelected, showCountrySelected),
                    // countriesSelected,
                    // // SizedBox(height: 15.0),
                    // phoneNumberField,
                    emailField,
                    SizedBox(height: 15.0),
                    passwordField,
                    SizedBox(height: 15.0),
                    confirmPassword,
                    SizedBox(height: 20.0),
                    FutureBuilder(
                      future:
                          Authentication.initializeFirebase(context: context),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error initializing Firebase');
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return Column(
                            children: <Widget>[
                              longButtons(
                                  CommonString.cSignUpButton, doRegister),
                              SizedBox(height: 5.0),
                              GoogleFirebaseButton(),
                            ],
                          );
                          GoogleFirebaseButton();
                        }
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            CommonColors.firebaseOrange,
                          ),
                        );
                      },
                    ),
//                SizedBox(height: 5.0),
//                loginLabel
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class CountryModel {
  String country = '';
  String countryCode = '';

  CountryModel({
    this.country,
    this.countryCode,
  });
}
