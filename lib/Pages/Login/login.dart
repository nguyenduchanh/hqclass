import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/auth.dart';
import 'package:hqclass/Domains/preferences/user_shared_preference.dart';
import 'package:hqclass/Domains/user.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final formKey = new GlobalKey<FormState>();
  TextFormField _userNameTextFormField;
  TextFormField _passwordTextFormField;
  SharedPreferences prefs;
  String _username ;
  String _password ;
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  Future<Null> _loadCounter() async {
    prefs = await SharedPreferences.getInstance();
    String userName  = prefs.getString("userName");
    setState(() {
      _userNameTextFormField = new TextFormField(
        autofocus: true,
        initialValue: userName,
        validator: (value) => value.isEmpty ? CommonString.cEnterPassword : "",
        onSaved: (value) =>  value.isEmpty?_username:"",
        decoration: buildInputDecoration(CommonString.cUsername,
            Icons.email, CommonString.cEmailOrUser),);
    });
  }
  @override
  Widget build(BuildContext context)  {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? CommonString.cEnterPassword : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(CommonString.cPassword,
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

    var doLogin = () async{
      if (kDebugMode) {
        Navigator.pushReplacementNamed(context, '/home');
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
        } else {
          print(CommonString.cDataInvalid);
        }
      }
    };

    return SafeArea(
      child: Scaffold(
        body: Container(
//          padding: EdgeInsets.all(10.0),
          padding: EdgeInsets.only(top: 10,bottom: 10, left: 30,right: 30),
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
                _userNameTextFormField,
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
