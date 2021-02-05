import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/user.dart';
import 'package:hqclass/Providers/auth.dart';
import 'package:hqclass/Providers/user_provider.dart';
import 'package:hqclass/Util/validators.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  String _username, _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => value.isEmpty ? "Please enter username" : null,
      decoration: buildInputDecoration("", Icons.account_box, "Username"),
    );
    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: validateEmail,
      decoration: buildInputDecoration("", Icons.email, "Your Email"),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(
          "Confirm password", Icons.lock, "Password"),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _confirmPassword = value,
      obscureText: true,
      decoration: buildInputDecoration(
          "Confirm password", Icons.lock, "Confirm Password"),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth.register(_username, _password, _confirmPassword).then((response) {
          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Registration Failed",
              message: response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
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
                usernameField,
                SizedBox(height: 15.0),
                emailField,
                SizedBox(height: 15.0),
                passwordField,
                SizedBox(height: 15.0),
                SizedBox(height: 10.0),
                confirmPassword,
                SizedBox(height: 20.0),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons("Register", doRegister),
              ],
            ),
          ),

        ),
      ),
    );
  }
}