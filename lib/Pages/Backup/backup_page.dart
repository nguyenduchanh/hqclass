import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

class BackupPage extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: CommonString.cBackupPageNav,
        searchBar: false,
        rightOptions: false,
      ),
      backgroundColor: CommonColors.bgColorScreen,
      drawer: CommonDrawer(currentPage: "Backup"),
      body: Container(),
    );
  }
}