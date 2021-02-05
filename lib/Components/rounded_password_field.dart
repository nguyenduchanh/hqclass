import 'package:flutter/material.dart';
import 'package:hqclass/Components/text_field_container.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';

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
        cursorColor:  CommonColors.kPrimaryColor,
        decoration: InputDecoration(
          hintText: cPassword,
          icon: Icon(
            Icons.lock,
            color: CommonColors.kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: CommonColors.kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
