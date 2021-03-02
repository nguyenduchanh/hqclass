import 'dart:developer';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/classes.dart';
import 'package:hqclass/Pages/Classes/classes_detail_body.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Widgets/navbar.dart';
import 'package:sqflite/sqflite.dart';

class ClassesDetailPage extends StatelessWidget {
  final Classes classes;
//  final dbHelper = DTBHelper.instance;
  ClassesDetailPage({Key key, this.classes}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _query();

    return Scaffold(
      appBar: Navbar(
        title: "Chi tiết lớp học",
        searchBar: false,
        isOnSearch: false,
        backButton: true,
      ),
      backgroundColor: CommonColors.bgColorScreen,
      body: new ClassDetailBody(classes: classes),
    );
  }
  void _query() async {
//    await dbHelper.database;
//    final allRows = await dbHelper.queryRowCount();
//    log('data: tesssssssst');
  }
}
