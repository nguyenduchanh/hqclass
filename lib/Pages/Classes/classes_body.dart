import 'dart:core';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/classes.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';

import 'classes_detail.dart';

class ClassesBody extends StatefulWidget {
  ClassesBody({Key key}) : super(key: key);

  @override
  _ClassesListState createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesBody> {
  List classes;

  @override
  void initState() {
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
                border: Border(
                    right: new BorderSide(
                        width: 1.0, color: CommonColors.kPrimaryColor))),
            child: Text(classes.classCode,
                style: TextStyle(
                    color: CommonColors.kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          title: Text(
            classes.className,
            style: TextStyle(
                color: CommonColors.kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: CommonColors.kPrimaryColor, size: 30.0),
        );
    Card makeClassesCard(Classes classes) => Card(
          elevation: 0,

          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: makeListClassesTile(classes),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Edit',
                color: Colors.black45,
                icon: Icons.edit,
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ClassesDetailPage(classes: classes)))
                },
              ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () async {
                  final ConfirmAction action =
                      await CDialog._asyncConfirmDialog(context, '123', '333');
                  // String action = "";
                  // Dialogs.ShowConfirmDialog(context, "Warning", "Warning message", actions: ["OK", "Cancel"],
                  //     onChanged: (value) {
                  //       action = value;
                  //     });
                  if (action == ConfirmAction.ACCEPT) {
                    Flushbar(
                      title: CommonString.cRegisterFailed,
                      message: "ACCEPT",
                      duration: Duration(seconds: 10),
                    ).show(context);
                  } else {
                    Flushbar(
                      title: CommonString.cRegisterFailed,
                      message: "CANCEL",
                      duration: Duration(seconds: 10),
                    ).show(context);
                  }
                },
              ),
            ],
          ),
        );

    final makeBody = Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: classes.length,
          itemBuilder: (BuildContext context, int index) {
            return makeClassesCard(classes[index]);
          }),
    );
    // final confirmDialog =
    return Scaffold(
      backgroundColor: CommonColors.lightGray,
      body: makeBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClassesDetailPage(classes: null)))
            }),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
enum ConfirmAction { CANCEL, ACCEPT }
class CDialog {
  static Future _asyncConfirmDialog(
      BuildContext context, String Title, String Content) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Title),
          content: Text(Content),
          actions: [
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }
}
