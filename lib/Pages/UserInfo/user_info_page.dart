import 'package:flutter/material.dart';
import 'package:hqclass/Pages/UserInfo/user_info_body.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: CommonString.cUserInfoTitle,
          searchBar: false,
          isOnSearch: false,
        ),
        backgroundColor: CommonColors.bgColorScreen,
        drawer: CommonDrawer(currentPage: "UserInfo"),
        body: new UserInfoPageBody());
//        body: new ListPage());
  }
}