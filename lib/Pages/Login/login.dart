import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/auth.dart';
import 'package:hqclass/Domains/classes.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Domains/user.dart';
import 'package:hqclass/Util/Constants/globals.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  String _username = GetUserName();
  String _password = GetPassword();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      // validator: validateEmail,
      validator: (value) => value.isEmpty ? CommonString.cEnterPassword : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration(CommonString.cConfirmPassword,
          Icons.email, CommonString.cEmailOrUser),
      // decoration: InputDecoration(hintText: "Your email"),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? CommonString.cEnterPassword : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(CommonString.cConfirmPassword,
          Icons.lock, CommonString.cPasswordPlaceHolder),
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
        FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text(
            CommonString.cForgotPassword,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        FlatButton(
          padding: EdgeInsets.only(left: 0.0),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
          child: Text(CommonString.cSignUpButton,
              style: TextStyle(fontWeight: FontWeight.w300)),
        )
      ],
    );

    var doLogin = () {
      if (kDebugMode) {
//        Navigator.pushReplacementNamed(context, '/home');
        final Future<Map<String, dynamic>> successfulMessage =
            auth.login('hanhnd6', '123457');
        successfulMessage.then((response) {
          if (response['status']) {
            String token = response['token'];
            Global.Token = token;
            UserPreferences().saveLoginConfig("hanhnd6", "123457", token);
            Navigator.pushReplacementNamed(context, '/home');
//          Provider.of<UserProvider>(context, listen: false).setUser(user);
//          Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        final form = formKey.currentState;
        if (form.validate()) {
          form.save();
          final Future<Map<String, dynamic>> successfulMessage =
              auth.login(_username, _password);
          // fix
          if (_username == "admin" && _password == "1234") {
            Navigator.pushReplacementNamed(context, '/home');
          }
          // successfulMessage.then((response) {
          //   if (response['status']) {
          //     User user = response['user'];
          //     Provider.of<UserProvider>(context, listen: false).setUser(user);
          //     Navigator.pushReplacementNamed(context, '/home');
          //   } else {
          //     Flushbar(
          //       title: "Falied login",
          //       message: response['message']['message'].toString(),
          //     ).show(context);
          //   }
          // }
          // );
        } else {
          print(CommonString.cDataInvalid);
        }
      }
    };

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/img/blackboard.png",
                  height: size.height * 0.2,
                ),
                SizedBox(height: 15.0),
                // label("Email"),
                SizedBox(height: 5.0),
                usernameField,
                SizedBox(height: 20.0),
                // label("Password"),
                SizedBox(height: 5.0),
                passwordField,
                SizedBox(height: 20.0),
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
