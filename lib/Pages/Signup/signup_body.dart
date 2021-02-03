import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hqclass/Components/already_have_an_account_acheck.dart';
import 'package:hqclass/Components/or_divider.dart';
import 'package:hqclass/Components/rounded_button.dart';
import 'package:hqclass/Components/rounded_input_field.dart';
import 'package:hqclass/Components/rounded_password_field.dart';
import 'package:hqclass/Components/social_icon.dart';
import 'package:hqclass/Pages/Login/login_screen.dart';
import 'package:hqclass/Pages/Signup/signup_backgroud.dart';
import 'package:hqclass/Pages/Welcome/background.dart';
import 'package:hqclass/Util/strings.dart';

class SignupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SigupBackgroud(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   cSignUpTitle,
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/img/blackboard.png",
              height: size.height * 0.25,
            ),
            RoundedInputField(
              hintText: cYourEmail,
              onChanged: (value){},
            ),
            RoundedPasswordField(
              onChanged: (value){},
            ),
            RoundedButton(
              text: cSignUpTitle,
              press: (){},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                },));
              }
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconStr: "assets/icons/facebook.svg",
                  press: (){},
                ),
                SocialIcon(
                  iconStr: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconStr: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
