import 'package:flutter/material.dart';
import 'package:hqclass/Domains/classes.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

class ClassesDetailPage extends StatelessWidget {
  final Classes classes;

  ClassesDetailPage({Key key, this.classes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Chi tiết lớp học",
          searchBar: false,
          rightOptions: false,
          isOnSearch: false,
          backButton: true,
        ),
        backgroundColor: CommonColors.bgColorScreen,
//        drawer: CommonDrawer(currentPage: "Classes"),
        body:Text("anh hanh")
    );
  }
}
