
import 'package:flutter/material.dart';
import 'package:hqclass/Pages/RollUp/roll_up_page_body.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Widgets/card-category.dart';
import 'package:hqclass/Widgets/card-horizontal.dart';
import 'package:hqclass/Widgets/card-small.dart';
import 'package:hqclass/Widgets/card-square.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/list-page.dart';
import 'package:hqclass/Widgets/navbar.dart';
import 'package:hqclass/Widgets/slider-product.dart';
class RollUp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: CommonString.cRollUpNav,
          searchBar: false,
          rightOptions: false,
          isOnSearch: false,
        ),
        backgroundColor: CommonColors.bgColorScreen,
        drawer: CommonDrawer(currentPage: "RollUp"),
        body: new RollUpPageBody()
    );
  }
}