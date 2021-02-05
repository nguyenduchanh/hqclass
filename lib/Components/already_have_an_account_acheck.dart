import 'package:flutter/cupertino.dart';
import 'package:hqclass/Constants/common_colors.dart';
import 'package:hqclass/Util/strings.dart';

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
        Text(login ? cDontHaveAnAccount : cAlreadyAnAccount,
            style: TextStyle(color:  CommonColors.kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? cSignUpTitle :cLoginTitle,
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
