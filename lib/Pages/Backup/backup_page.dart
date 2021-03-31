import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hqclass/Domains/ClassController.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/dtb_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

class BackupPage extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    String _domain =  DBHelper.class_url;
    List<ClassesModel> classesList;
    Map<String, dynamic> res;
    const String logStr = CommonString.cBackUpInitString;
    var doImport = () async {

    };
    var doExport = () async {
      classesList = await ClassController().GetClasses();
      log(classesList[0].className);
    };
    final urlFromField = new TextFormField(
      autofocus: false,
      initialValue: _domain,
      keyboardType: TextInputType.url,
      onSaved: (value) => _domain = value,
      decoration: buildInputDecoration(
          CommonString.cEnterUrlString, Icons.add_link,
          CommonString.cUrlString),
    );
    final cardResult = new Container(
      // adding padding
      padding: const EdgeInsets.only(top: 25, bottom: 10, left: 0, right: 0),
      // height should be fixed for vertical scrolling
      height: 500.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white30,
          width: 1.0,
        ),
      ),
      child: Form(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            logStr,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.normal,
              fontSize: 16.0,
              letterSpacing: 1,
              wordSpacing: 1,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                urlFromField,
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