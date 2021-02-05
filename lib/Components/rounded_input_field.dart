import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Components/text_field_container.dart';
import 'package:hqclass/Constants/common_colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: CommonColors.kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: CommonColors.kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
