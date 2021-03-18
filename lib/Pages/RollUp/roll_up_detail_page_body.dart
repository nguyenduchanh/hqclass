import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Domains/models/student_add.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class RollUpDetailBody extends StatefulWidget {
  final ClassesModel currentClasses;

  RollUpDetailBody({Key key, this.currentClasses}) : super(key: key);

  @override
  _RollUpDetailBodyState createState() => _RollUpDetailBodyState();
}

class _RollUpDetailBodyState extends State<RollUpDetailBody> {
  Future<List<StudentAddModel>> studentList;
  List<StudentModel> students;
  List<String> studentCodeList;
  BaseDao baseDao;
  String _searchText;
  bool isSelectedAll = false;
  @override
  void initState() {
    super.initState();
    baseDao = BaseDao();
    refreshStudentList();
  }

  refreshStudentList() async {
    setState(() {
      var studentCode = widget.currentClasses.studentCodeList;
//      if(studentCode[0]==','){
//        studentCode = studentCode.substring(0, studentCode.length - 1);
//      }
      if (studentCode != null && studentCode.isNotEmpty) {
        studentList = baseDao.getStudentsByCode(studentCode);
      }
    });
  }
  chkCheckedClicked() async {
    setState(() {
      studentList = baseDao.studentAddCheckedAll(studentList);
    });
  }
  @override
  Widget build(BuildContext context) {
    var btnSaveClicked = () async {

    };
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
    final checkedRow = Row(
      //Creates even space between each item and their parent container
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(
                        unselectedWidgetColor: CommonColors.kPrimaryColor),
                    child: Checkbox(
                      value: isSelectedAll,
                      activeColor: CommonColors.kPrimaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          isSelectedAll = !isSelectedAll;
                          chkCheckedClicked();
                        });
                      },
                    ),
                  ),
                  Text(
                    'Check all ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
            child: Container(
              height: 50,
              child: Padding(
                padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 75),
                child: longButtons(CommonString.cSaveButton, btnSaveClicked),
              ),
            )),
      ],
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
            child: checkedRow,
          ),
          Expanded(
            child: FutureBuilder(
              future: studentList,
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

  ListTile makeListStudentTileV2(StudentAddModel studentModel) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
        leading:Container(
            padding: EdgeInsets.only(right: 5.0),
            decoration: new BoxDecoration(
                border: Border(
                    right: new BorderSide(
                        width: 1.0, color: CommonColors.kPrimaryColor))),
            child: Theme(
              data:
              ThemeData(unselectedWidgetColor: CommonColors.kPrimaryColor),
              child: Checkbox(
                value: studentModel.isAdd,
                activeColor: CommonColors.kPrimaryColor,
                onChanged: (bool value) {
                  setState(() {
                    studentModel.isAdd = value;
                  });
                },
              ),
            )),
        title: Text(
          studentModel.studentName,
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
