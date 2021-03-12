import 'dart:async';
import 'dart:core';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Util/Constants/cEnum.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

import 'classes_detail.dart';

class ClassesBody extends StatefulWidget {
  ClassesBody({Key key}) : super(key: key);

  @override
  _ClassesListState createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesBody> {
  Future<List<ClassesModel>> classesList;
  Future<List<ClassesModel>> classesListOnSearch;
  BaseDao baseDao;
  String _searchText;
  @override
  void initState() {
    super.initState();
    baseDao = BaseDao();
    refreshClassesList();
  }

  refreshClassesList() async {
    setState(() {
      classesList = baseDao.getClasses();
      classesListOnSearch = baseDao.searchClasses(classesList, _searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchBox = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? CommonString.cEnterClassName : null,
      onChanged: (text) {
        _searchText = text;
        refreshClassesList();
      },
      decoration: buildSearchInputDecoration("Tìm kiếm lớp học","Nhập mã hoặc tên lớp học "),
    );
    return Scaffold(
      backgroundColor: CommonColors.lightGray,
      body: Column(
        children: <Widget>[
          Padding( padding: const EdgeInsets.only(
              top: 8, bottom: 10, left: 15, right: 15),
            child: searchBox,
          ),
          Expanded(
            child: FutureBuilder(
              future: classesListOnSearch,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateListV2(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('', textAlign: TextAlign.center);
                }
                return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.red)),
                );
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
          actions: <Widget>[
            IconSlideAction(
              caption: 'Gán học sinh',
              color: Colors.black45,
              icon: Icons.add_to_photos,
              onTap: () => {},
            ),
          ],
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
                            ClassesDetailPage(currentClass: cls)))
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                final ConfirmAction action = await CDialog._asyncConfirmDialog(
                    context,
                    'Xác nhận!',
                    'Bạn có chắc chắn muốn xóa dữ liệu này!');
                if (action == ConfirmAction.ACCEPT) {
                  await baseDao.deleteClass(cls.id);
                  refreshClassesList();
                } else {}
              },
            ),
          ],
        ),
      );

  ListView generateListV2(List<ClassesModel> classesModel) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: classesModel.length,
        itemBuilder: (BuildContext context, int index) {
          return makeClassesCardV2(classesModel[index]);
        });
  }
}



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
