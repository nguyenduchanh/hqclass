import 'dart:core';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/Storage/class_dao.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';

import 'classes_detail.dart';

class ClassesBody extends StatefulWidget {
  ClassesBody({Key key}) : super(key: key);

  @override
  _ClassesListState createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesBody> {
  Future<List<ClassesModel>> classesList;
  ClassesDao classesDao;

  @override
  void initState() {
    super.initState();
    classesDao = ClassesDao();
    refreshClassesList();
  }

  refreshClassesList() async {
    setState(() {
      classesList = classesDao.getClasses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.lightGray,
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: classesList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateListV2(snapshot.data);
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ClassesDetailPage(currentClass: null)))
            }),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
  ListTile makeListClassesTileV2(ClassesModel classesModel) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: Border(
              right: new BorderSide(
                  width: 1.0, color: CommonColors.kPrimaryColor))),
      child: Text(classesModel.classCode,
          style: TextStyle(
              color: CommonColors.kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
    ),
    title: Text(
      classesModel.className,
      style: TextStyle(
          color: CommonColors.kPrimaryColor, fontWeight: FontWeight.bold),
    ),
    trailing: Icon(Icons.keyboard_arrow_right,
        color: CommonColors.kPrimaryColor, size: 30.0),
  );
  Card makeClassesCardV2(ClassesModel cls) => Card(
    elevation: 0,
    child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: makeListClassesTileV2(cls),
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
                        ClassesDetailPage(currentClass: null)))
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            final ConfirmAction action =
            await CDialog._asyncConfirmDialog(context, '123', '333');
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
  SingleChildScrollView generateListV2(List<ClassesModel> classesModel){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: classesModel.length,
            itemBuilder: (BuildContext context, int index) {
              return makeClassesCardV2(classesModel[index]);
            }),
      )
    );
  }
  SingleChildScrollView generateList(List<ClassesModel> classesModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          rows: classesModel
              .map(
                (cls) =>
                    DataRow(
                  cells: [
                    DataCell(
                      Text(cls.classCode),
                      onTap: () {

                      },
                    ),
                    DataCell(
                      Text(cls.className),
                      onTap: () {
                      },
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                        },
                      ),
                    )
                  ],
                ),
            //end row
              )
              .toList(),
        ),
      ),
    );
  }
}

// confirm dialog

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
