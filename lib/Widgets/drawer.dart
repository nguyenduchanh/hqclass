import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';

import 'drawer-tile.dart';

class CommonDrawer extends StatelessWidget {
  final String currentPage;

  CommonDrawer({this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: CommonColors.kPrimaryLightColor,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: Image.asset("assets/img/blackboard.png"),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.list_alt_outlined,
                  onTap: () {
                    if (currentPage != "RollUp") {
                      NavigatorHelper().toRollUpPage(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  iconColor: CommonColors.kPrimaryColor,
                  title: CommonString.cRollUpNav,
                  isSelected: currentPage == "RollUp" ? true : false),
              DrawerTile(
                  icon: Icons.class__outlined,
                  onTap: () {
                    if (currentPage != "Classes") {
                      NavigatorHelper().toClassesPage(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  iconColor: CommonColors.kPrimaryColor,
                  title: CommonString.cClassNav,
                  isSelected: currentPage == "Classes" ? true : false),
              DrawerTile(
                  icon: Icons.account_box_outlined,
                  onTap: () {
                    if (currentPage != "Students") {
                      NavigatorHelper().toStudentPage(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  iconColor: CommonColors.kPrimaryColor,
                  title: CommonString.cStudentNav,
                  isSelected: currentPage == "Students" ? true : false),
              DrawerTile(
                  icon: Icons.insert_chart,
                  onTap: () {
                    if (currentPage != "Home") {
                      NavigatorHelper().toHomePage(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  iconColor: CommonColors.kPrimaryColor,
                  title: CommonString.cHomePageNav,
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.backup,
                  onTap: () {
                    if (currentPage != "Backup")
                      NavigatorHelper().toBackupPage(context);
                  },
                  iconColor: CommonColors.kPrimaryColor,
                  title: CommonString.cBackupPageNav,
                  isSelected: currentPage == "Backup" ? true : false),
              DrawerTile(
                  icon: Icons.logout,
                  onTap: () {
                    if (currentPage != "Logout")
                      NavigatorHelper().toLoginPage(context);
                  },
                  iconColor: CommonColors.kPrimaryColor,
                  title: CommonString.cSignOutNav,
                  isSelected: currentPage == "Login" ? true : false),
            ],
          ),
        ),
      ]),
    ));
  }
}
