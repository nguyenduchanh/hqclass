import 'package:flutter/material.dart';
import 'package:hqclass/Components/text_field_container.dart';
import 'package:hqclass/Util/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged:  onChanged,
        cursorColor:  kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
