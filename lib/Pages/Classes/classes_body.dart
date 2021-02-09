import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Domains/classes.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';

import 'classes_detail.dart';

class ClassesBody extends StatefulWidget {
  ClassesBody({Key key}) : super(key: key);
  @override
  _ClassesListState createState() => _ClassesListState();
}
class _ClassesListState extends State<ClassesBody>{
  List classes;
  @override
  void initState(){
    classes = getClasses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ListTile makeListClassesTile(Classes classes) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
          border: Border(right: new BorderSide(
            width: 1.0, color: CommonColors.kPrimaryColor
          ))),
        child: Text(classes.classCode,
        style: TextStyle(color: CommonColors.kPrimaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold)),
      ),
      title: Text(
        classes.className,
        style: TextStyle(color: CommonColors.kPrimaryColor, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.keyboard_arrow_right,color: CommonColors.kPrimaryColor, size: 30.0),
      onTap: (){
        // mở ra trang chi tiết
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClassesDetailPage(classes: classes)));
      },
    );
    Card makeClassesCard(Classes classes) => Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(width: 2, color: Colors.grey)
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListClassesTile(classes),
      ),
    );
    final makeBody = Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: classes.length,
          itemBuilder: (BuildContext context, int index){
            return makeClassesCard(classes[index]);
          }
      ),
    );
    return Scaffold(
      backgroundColor: CommonColors.lightGray,
      body: makeBody,
    );
  }
}