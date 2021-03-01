import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

import 'classes_body.dart';

class Classes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
            title: CommonString.cClassTitle,
            searchBar: false,
            isOnSearch: false,
        ),
        backgroundColor: CommonColors.bgColorScreen,
        drawer: CommonDrawer(currentPage: "Classes"),
        body: new ClassesBody());
  }
}
