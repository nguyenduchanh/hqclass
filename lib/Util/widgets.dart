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
//text form filed with icon and without hint text
InputDecoration buildSearchInputDecoration(String _placeHolder, String _hintText) {
  return InputDecoration(
    hintText: _hintText,
    labelText: _placeHolder,
    prefixIcon: Icon(Icons.search, color: CommonColors.kPrimaryColor),
//    suffixIcon: Icon(Icons.highlight_off, color: Colors.grey),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}
InputDecoration buildInputDecoration(
    String placeHolder, IconData icon, String _hintText) {
  return InputDecoration(
    hintText: _hintText,
    labelText: placeHolder,
    prefixIcon: Icon(icon, color: CommonColors.kPrimaryColor),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}
//text form filed with only hint text
InputDecoration buildInputDecorationWithoutIcon(
    String placeHolder, String _hintText) {
  return InputDecoration(
    hintText: _hintText,
    labelText: placeHolder,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}