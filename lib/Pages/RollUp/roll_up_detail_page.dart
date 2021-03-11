import 'package:flutter/material.dart';
import 'package:hqclass/Domains/models/roll_up.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Widgets/navbar.dart';

class RollUpDetailPage extends StatelessWidget{
  final RollUpModel currentRollUp;
  RollUpDetailPage({Key key,this.currentRollUp}) : super(key: key);
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
//      body: new StudentDetailBodyPage(studentModel: currentStudent),
    );
  }
}