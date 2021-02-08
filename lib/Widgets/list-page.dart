import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';

import '../detailPage.dart';

void main() => runApp(new MyApp1());

class MyApp1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: CommonColors.kPrimaryLightColor, fontFamily: 'Raleway'),
      home: new ListPage(title: 'Lessons'),
      // home: DetailPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List lessons;

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    ListTile makeListTile(Lesson lesson) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: CommonColors.kPrimaryColor))),
            // child: Icon(Icons.autorenew, color: CommonColors.kPrimaryColor),
            child: Text("9C", style: TextStyle(color: CommonColors.kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            lesson.title,
            style: TextStyle(
                color: CommonColors.kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
          //
          // subtitle: Row(
          //   children: <Widget>[
          //     Expanded(
          //         flex: 1,
          //         child: Container(
          //           // tag: 'hero',
          //           child: LinearProgressIndicator(
          //               backgroundColor: CommonColors.kPrimaryLightColor,
          //               value: lesson.indicatorValue,
          //               valueColor: AlwaysStoppedAnimation(Colors.green)),
          //         )),
          //     Expanded(
          //       flex: 4,
          //       child: Padding(
          //           padding: EdgeInsets.only(left: 10.0),
          //           child: Text(lesson.level,
          //               style: TextStyle(color: Colors.white))),
          //     )
          //   ],
          // ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: CommonColors.kPrimaryColor, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(lesson: lesson)));
          },
        );

    Card makeCard(Lesson lesson) => Card(
          // elevation: 0.0,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(width: 2, color: Colors.grey)),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: makeListTile(lesson),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );
    //
    // final makeBottom = Container(
    //   height: 55.0,
    //   child: BottomAppBar(
    //     color: CommonColors.kPrimaryColor,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: <Widget>[
    //         IconButton(
    //           icon: Icon(Icons.home, color: Colors.white),
    //           onPressed: () {},
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.blur_on, color: Colors.white),
    //           onPressed: () {},
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.hotel, color: Colors.white),
    //           onPressed: () {},
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.account_box, color: Colors.white),
    //           onPressed: () {},
    //         )
    //       ],
    //     ),
    //   ),
    // );
    final topAppBar = AppBar(
      elevation: 0.0,
      backgroundColor: CommonColors.kPrimaryColor,
      // title: Text(widget.title),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.list),
        //   onPressed: () {},
        // )
      ],
    );

    return Scaffold(
      backgroundColor: CommonColors.lightGray,
      // appBar: topAppBar,
      body: makeBody,
      // bottomNavigationBar: makeBottom,
    );
  }
}

List getLessons() {
  return [
    Lesson(
        title: "Introduction to Driving",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 20,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Start by taking a couple of minutes to read the info in this section."),
    Lesson(
        title: "Observation at Junctions",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  "
            "While on the settings page, click the Save button."),
    Lesson(
        title: "Reverse parallel Parking",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu. "),
    Lesson(
        title: "Reversing around the corner",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  "),
    Lesson(
        title: "Incorrect Use of Signal",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  "),
    Lesson(
        title: "Engine Challenges",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "),
    Lesson(
        title: "Self Driving Car",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  ")
  ];
}

class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;

  Lesson(
      {this.title, this.level, this.indicatorValue, this.price, this.content});
}
