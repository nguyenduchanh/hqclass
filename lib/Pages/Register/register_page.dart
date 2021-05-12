import 'package:flutter/material.dart';
import 'package:hqclass/Pages/Register/register.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: CommonString.cRegisterTitle,
          searchBar: false,
          isOnSearch: false,
          backButton: true,
        ),
        backgroundColor: CommonColors.bgColorScreen,
        drawer: CommonDrawer(currentPage: "Register"),
        body: new Register());
//        body: new ListPage());
  }
}