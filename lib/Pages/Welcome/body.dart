import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hqclass/Components/rounded_button.dart';
import 'package:hqclass/Pages/Login/login_screen.dart';
import 'package:hqclass/Pages/Signup/signup_screen.dart';
import 'package:hqclass/Pages/Welcome/background.dart';
import 'package:hqclass/Util/constants.dart';
import 'package:hqclass/Util/strings.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   cWelcomeString,
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // ),
            SizedBox(height: size.height * 0.01),
            Image.asset(
              "assets/img/blackboard.png",
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: cLoginTitle,
              press: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                }));
              },
            ),
            RoundedButton(
              text: cSignUpTitle,
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
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
