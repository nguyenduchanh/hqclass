import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

class BackupPage extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    const String logStr = "I am setting up jenkins on windows machine. I have installed VS 2017 Community. When i run the solution from VS, It is working fine. But from jenkins, i am getting below error ";
    var doImport = () async{
    };
    var doExport = () async{

    };
    final cardResult = new Container(
      // adding padding
      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 0, right: 0),
      // height should be fixed for vertical scrolling
      height: 550.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white30,
          width: 1.0,
        ),
      ),
      child: Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            logStr,
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              letterSpacing: 3,
              wordSpacing: 3,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: Navbar(
        title: CommonString.cBackupPageNav,
        searchBar: false,
        rightOptions: false,
      ),
      backgroundColor: CommonColors.bgColorScreen,
      drawer: CommonDrawer(currentPage: "Backup"),
      body: Container(
        padding: EdgeInsets.only(top: 5, bottom: 10, left: 30, right: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15.0),
                longButtons(CommonString.cImportButton, doImport),
                SizedBox(height: 15.0),
                longButtons(CommonString.cExportButton, doExport),
                SizedBox(height: 15.0),
                cardResult,
                ]
          )
          //
      ),
    );
  }
}