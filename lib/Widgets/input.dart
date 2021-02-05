import 'package:flutter/material.dart';
import 'package:hqclass/Constants/common_colors.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;

  Input(
      {this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = CommonColors.border,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: CommonColors.muted,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        style:
            TextStyle(height: 0.85, fontSize: 14.0, color: CommonColors.initial),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: CommonColors.white,
            hintStyle: TextStyle(
              color: CommonColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
