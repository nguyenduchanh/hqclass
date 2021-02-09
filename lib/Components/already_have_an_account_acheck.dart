import 'package:flutter/cupertino.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;

  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(login ? CommonString.cDontHaveAnAccount : CommonString.cAlreadyAnAccount,
            style: TextStyle(color:  CommonColors.kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? CommonString.cSignUpTitle :CommonString.cLoginTitle,
            style: TextStyle(
              color:  CommonColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
