import 'package:flutter/material.dart';

//widgets
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Widgets/card-horizontal.dart';
import 'package:hqclass/Widgets/card-small.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

import '../../Widgets/list-page.dart';

class Home extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Trang chủ",
          searchBar: false,
        ),
        backgroundColor: CommonColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: CommonDrawer(currentPage: "Home"),
//        body: new ListPage(title: 'Lessons')
        body: Container(
        // padding: EdgeInsets.only(left: 24.0, right: 24.0),
        // child: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //
        //     ],
        //   ),
         ),

        // )
        );
  }
}
