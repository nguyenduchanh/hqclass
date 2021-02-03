import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hqclass/Components/already_have_an_account_acheck.dart';
import 'package:hqclass/Components/rounded_button.dart';
import 'package:hqclass/Components/rounded_input_field.dart';
import 'package:hqclass/Components/rounded_password_field.dart';
import 'package:hqclass/Pages/Signup/signup_screen.dart';
import 'package:hqclass/Pages/Welcome/background.dart';
import 'package:hqclass/Util/strings.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/img/blackboard.png",
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: cYourEmail,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: cLoginTitle,
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
