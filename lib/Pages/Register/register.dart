import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/auth.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Pages/Classes/classes_page.dart';
import 'package:hqclass/Pages/LoginWithGoogle/custom_color.dart';
import 'package:hqclass/Pages/LoginWithGoogle/service/authentication.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/google_firebase_button.dart';
import 'package:hqclass/Util/validators.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ClassesPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  String _username, _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? CommonString.cUsernameRequire : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration(
          CommonString.cUsername, Icons.account_box, CommonString.cUsername),
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
        await UserPreferences()
            .CreateUserConfig(_username, _password, _email, SignInSource.none);
        Navigator.of(context).pushReplacement(_routeToSignInScreen());
      } else {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: CommonString.cDataInvalid,
          message: CommonString.cReEnterLoginForm,
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };
    final loginLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          onPressed: () {
            NavigatorHelper().toLoginPage(context);
          },
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: CommonColors.kPrimaryColor,
                  size: 25.0,
                ),
                // onPressed: () {
                //   Scaffold.of(context).openDrawer();
                // }
              ),
              Text(CommonString.cBackToLogin,
                  style: TextStyle(fontWeight: FontWeight.w300)),
            ],
          )
          // Text(CommonString.cLoginButton,
          //     style: TextStyle(fontWeight: FontWeight.w300))
          ,
        )
      ],
    );
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
                  usernameField,
                  SizedBox(height: 15.0),
                  emailField,
                  SizedBox(height: 15.0),
                  passwordField,
                  SizedBox(height: 15.0),
                  confirmPassword,
                  SizedBox(height: 20.0),
                  auth.loggedInStatus == Status.Authenticating
                      ? loading
                      : longButtons(CommonString.cSignUpButton, doRegister),
                  SizedBox(height: 5.0),
                  FutureBuilder(
                    future: Authentication.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error initializing Firebase');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return GoogleFirebaseButton();
                      }
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.firebaseOrange,
                        ),
                      );
                      return GoogleFirebaseButton();
                    },
                  ),
//                SizedBox(height: 5.0),
//                loginLabel
                ],
              ),
            ),
          ),
        ),
    );
  }
}
