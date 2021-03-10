import 'package:flutter/material.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Pages/Students/student_detail_body_page.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Widgets/navbar.dart';

class StudentDetailPage extends StatelessWidget {
  final StudentModel currentStudent;
  StudentDetailPage({Key key,this.currentStudent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Chi tiết học sinh",
        searchBar: false,
        isOnSearch: false,
        backButton: true,
      ),
      backgroundColor: CommonColors.bgColorScreen,
      body: new StudentDetailBodyPage(studentModel: currentStudent),
    );
  }
}