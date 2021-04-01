import 'package:flutter/material.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Pages/RollUp/roll_up_history_detail_page.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Widgets/navbar.dart';

class RollUpHistoryPage extends StatelessWidget{
  final ClassesModel clsModel;
  RollUpHistoryPage({Key key,this.clsModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Lịch sử điểm danh",
        searchBar: false,
        isOnSearch: false,
        backButton: true,
      ),
      backgroundColor: CommonColors.bgColorScreen,
      body: new RollUpHistoryDetailBody(currentClasses: clsModel),
    );
  }
}