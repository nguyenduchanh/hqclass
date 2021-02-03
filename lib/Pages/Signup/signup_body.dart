import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hqclass/Components/rounded_input_field.dart';
import 'package:hqclass/Pages/Signup/signup_backgroud.dart';
import 'package:hqclass/Pages/Welcome/background.dart';

class SignupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SigupBackgroud(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SIGNUP",
            style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.05,
            ),
            RoundedInputField()
          ],
        ),
      ),
    );
  }
}