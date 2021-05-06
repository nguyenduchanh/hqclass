import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Widgets/drawer.dart';
import 'package:hqclass/Widgets/navbar.dart';

import '../../Widgets/list-page.dart';

class Home extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: CommonString.cHomePageNav,
        searchBar: false,
        rightOptions: false,
      ),
      backgroundColor: CommonColors.bgColorScreen,
      drawer: CommonDrawer(currentPage: "Home"),
      body: Container(
        margin: EdgeInsets.all(20),
        height: 100.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              width: 190.0,
              child: Card(
                color: CommonColors.kPrimaryColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.person,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      title: Center(
                        child: Text(CommonString.cStudentNav,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600)),
                      ),

                      subtitle: Center(
                        child: Text('1250',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              width: 190.0,
              child: Card(
                color: CommonColors.kPrimaryColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.group,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      title: Center(
                        child: Text(CommonString.cClassNav,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600)),
                      ),

                      subtitle: Center(
                        child: Text('20',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
