import 'package:flutter/material.dart';
import 'package:hqclass/Constants/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer-tile.dart';



class CommonDrawer extends StatelessWidget {
  final String currentPage;

  CommonDrawer({this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: CommonColors.white,
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
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushReplacementNamed(context, '/home');
                  },
                  iconColor: CommonColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.class__outlined,
                  onTap: () {
                    if (currentPage != "Classes")
                      Navigator.pushReplacementNamed(context, '/classes');
                  },
                  iconColor: CommonColors.primary,
                  title: "Classes",
                  isSelected: currentPage == "Classes" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Profile")
                      Navigator.pushReplacementNamed(context, '/profile');
                  },
                  iconColor: CommonColors.warning,
                  title: "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "Account")
                      Navigator.pushReplacementNamed(context, '/account');
                  },
                  iconColor: CommonColors.info,
                  title: "Account",
                  isSelected: currentPage == "Account" ? true : false),
              DrawerTile(
                  icon: Icons.settings_input_component,
                  onTap: () {
                    if (currentPage != "Elements")
                      Navigator.pushReplacementNamed(context, '/elements');
                  },
                  iconColor: CommonColors.error,
                  title: "Elements",
                  isSelected: currentPage == "Elements" ? true : false),
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    if (currentPage != "Articles")
                      Navigator.pushReplacementNamed(context, '/articles');
                  },
                  iconColor: CommonColors.primary,
                  title: "Articles",
                  isSelected: currentPage == "Articles" ? true : false),
            ],
          ),
        ),
//        Expanded(
//          flex: 1,
//          child: Container(
//              padding: EdgeInsets.only(left: 8, right: 16),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  Divider(height: 4, thickness: 0, color: CommonColors.muted),
//                  Padding(
//                    padding:
//                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
//                    child: Text("DOCUMENTATION",
//                        style: TextStyle(
//                          color: Color.fromRGBO(0, 0, 0, 0.5),
//                          fontSize: 15,
//                        )),
//                  ),
//                  DrawerTile(
//                      icon: Icons.airplanemode_active,
//                      onTap: _launchURL,
//                      iconColor: CommonColors.muted,
//                      title: "Getting Started",
//                      isSelected:
//                          currentPage == "Getting started" ? true : false),
//                ],
//              )),
//        ),
      ]),
    ));
  }
}
