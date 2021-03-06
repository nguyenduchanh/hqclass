import 'package:flutter/material.dart';
import 'package:hqclass/Pages/Students/student_page_body.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/list-page.dart';
import 'package:hqclass/Widgets/navbar.dart';

class StudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: CommonString.cStudentTitle,
          searchBar: false,
          isOnSearch: false,
        ),
        backgroundColor: CommonColors.bgColorScreen,
        drawer: CommonDrawer(currentPage: "Students"),
        body: new StudentPageBody());
//        body: new ListPage());
  }
}