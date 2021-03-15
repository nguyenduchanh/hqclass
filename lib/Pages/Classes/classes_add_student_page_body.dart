import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/student_add.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class ClassesAddStudentPageBody extends StatefulWidget {
  ClassesAddStudentPageBody({Key key}) : super(key: key);

  @override
  _ClassAddStudentPageBodyState createState() =>
      _ClassAddStudentPageBodyState();
}

class _ClassAddStudentPageBodyState extends State<ClassesAddStudentPageBody> {
  Future<List<StudentAddModel>> studentAddList;
  Future<List<StudentAddModel>> studentAddListOnSearch;
  bool valuesecond = false;
  BaseDao baseDao;
  String _searchText;

  @override
  void initState() {
    super.initState();
    baseDao = BaseDao();
    refreshStudentList();
  }

  refreshStudentList() async {
    setState(() {
      studentAddList = baseDao.getStudentsToAdd([]);
      studentAddListOnSearch =
          baseDao.searchStudentAdd(studentAddList, _searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchBox = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? CommonString.cEnterClassName : null,
      onChanged: (text) {
        _searchText = text;
        refreshStudentList();
      },
      decoration: buildSearchInputDecoration(
          "Tìm kiếm học sinh", "Nhập mã hoặc tên học sinh"),
    );
    final saveButton = Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Theme(
                data: ThemeData(
                    unselectedWidgetColor: CommonColors.kPrimaryColor),
                child: Checkbox(
                  value: false,
                  activeColor: CommonColors.kPrimaryColor,
                  onChanged: (bool value) {
                    setState(() {
//                      studentAddModel.isAdd = value;
                    });
                  },
                ),
              ),
              Text(
                'Check all ',
                style: TextStyle(fontSize: 16.0),
              ),
              MaterialButton(
                textColor: CommonColors.kPrimaryColor,
                color: CommonColors.kPrimaryColor,
                child: SizedBox(
//                  width: double.infinity,
                  child: Text(
                    "Save",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: CommonColors.lightGray,
      body: Column(
        children: <Widget>[
          // seach box
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 10, left: 15, right: 15),
            child: searchBox,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 5, left: 0, right: 15),
            child: saveButton,
          ),
          Expanded(
            child: FutureBuilder(
              future: studentAddListOnSearch,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateStudentListV2(snapshot.data);
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
    );
  }

  ListTile makeListStudentTileV2(StudentAddModel studentAddModel) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
        leading: Container(
            padding: EdgeInsets.only(right: 5.0),
            decoration: new BoxDecoration(
                border: Border(
                    right: new BorderSide(
                        width: 1.0, color: CommonColors.kPrimaryColor))),
            child: Theme(
              data:
                  ThemeData(unselectedWidgetColor: CommonColors.kPrimaryColor),
              child: Checkbox(
                value: studentAddModel.isAdd,
                activeColor: CommonColors.kPrimaryColor,
                onChanged: (bool value) {
                  setState(() {
                    studentAddModel.isAdd = value;
                  });
                },
              ),
            )),
        title: Text(
          studentAddModel.studentName,
          style: TextStyle(
              color: CommonColors.kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      );

  Card makeStudentCardV2(StudentAddModel std) => Card(
        elevation: 0,
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: makeListStudentTileV2(std),
            ),
          ),
        ),
      );

  generateStudentListV2(List<StudentAddModel> classesModel) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: classesModel.length,
        itemBuilder: (BuildContext context, int index) {
          return makeStudentCardV2(classesModel[index]);
        });
  }
}
