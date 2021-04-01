import 'package:flutter/material.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Pages/RollUp/roll_up_detail_page_body.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Widgets/navbar.dart';

class RollUpDetailPage extends StatelessWidget{
  final ClassesModel classesModel;
  RollUpDetailPage({Key key,this.classesModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Điểm danh",
        searchBar: false,
        isOnSearch: false,
        backButton: true,
      ),
      backgroundColor: CommonColors.bgColorScreen,
      body: new RollUpDetailBody(currentClasses: classesModel),
    );
  }
}