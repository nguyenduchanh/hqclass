import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';

MaterialButton longButtons(String title, Function fun,
    {Color color: const Color(0xFF238174), Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon, String _hintText) {
  return InputDecoration(
    hintText: _hintText,
    prefixIcon: Icon(icon, color: CommonColors.kPrimaryColor),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}