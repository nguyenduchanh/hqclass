import 'package:flutter/material.dart';
import 'file:///D:/Study/Github/hqclass/lib/Domains/models/classes.dart';
import 'package:hqclass/Pages/Classes/classes_detail_body.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Widgets/navbar.dart';

class ClassesDetailPage extends StatelessWidget {
  final ClassesModel currentClass;
  ClassesDetailPage({Key key,this.currentClass}) : super(key: key);
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
      body: new ClassDetailBody(classes: currentClass),
    );
  }
  void _query() async {
//    await dbHelper.database;
//    final allRows = await dbHelper.queryRowCount();
//    log('data: tesssssssst');
  }
}
