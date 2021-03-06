import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Domains/models/rollup.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Domains/models/student_add.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class RollUpDetailBody extends StatefulWidget {
  final ClassesModel currentClasses;
  final Map<String, bool> stdState;

  RollUpDetailBody({Key key, this.currentClasses, this.stdState})
      : super(key: key);

  @override
  _RollUpDetailBodyState createState() => _RollUpDetailBodyState();
}

class _RollUpDetailBodyState extends State<RollUpDetailBody> {
  Future<List<StudentAddModel>> studentList;
  List<StudentAddModel> studentList2;
  List<StudentModel> students;
  List<String> studentCodeList;
  RollUpModel rollUpModel;
  List<RollUpModel> rollUpModel2;
  BaseDao baseDao;
  String _searchText;
  bool isSelectedAll = false;

  @override
  void initState() {
    super.initState();
    baseDao = BaseDao();
    if (widget.stdState == null) {
      refreshRollupDetailList();
    } else {
      geStdState(widget.stdState);
    }
  }

  geStdState(Map<String, bool> state) async {
    var studentCode = widget.currentClasses.studentCodeList;
    studentList2 = await baseDao.getStudentsByCode(studentCode);
    setState(() {
      studentList = baseDao.convertToStudentAddCode(studentList2, state);
      isSelectedAll = checkState(state);
    });
  }
  bool checkState(Map<String, bool> state){
    bool result = true;
    state.forEach((key, value) {
      if(value == false){
        result =  false;
      }
    }
    );
    return result;
  }
  refreshRollupDetailList() async {
    var studentCode = widget.currentClasses.studentCodeList;
    setState(() {
      if (studentCode != null && studentCode.isNotEmpty) {
        studentList = baseDao.getStudentsByCode(studentCode);
      }
    });
  }

  chkCheckedClicked() async {
    setState(() {
      studentList = baseDao.studentAddCheckedAll(studentList, isSelectedAll);
    });
  }

  btnSaveClicked() async {
    studentList2 = await studentList;
    Map<String, bool> rollupData = new Map<String, bool>();
    studentList2.forEach((element) {
      rollupData[element.studentCode] = element.isAdd;
    });
    setState(() {
      rollUpModel = new RollUpModel(0, widget.currentClasses.classCode,
          widget.currentClasses.studentCodeList, DateTime.now(), rollupData);
      if (widget.stdState == null) { //insert
        baseDao.addRollup(rollUpModel);
        Navigator.pop(context);
      }else{  // update

      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final searchBox = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? CommonString.cEnterClassName : null,
      onChanged: (text) {
        _searchText = text;
        refreshRollupDetailList();
      },
      decoration: buildSearchInputDecoration(
          "Tìm kiếm học sinh", "Nhập mã hoặc tên học sinh"),
    );
    final checkedRow = Row(
      //Creates even space between each item and their parent container
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
            child: Row(
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
        ),
        Container(
           child: Expanded(
                child: Container(
                  height: 50,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    child: longButtons(CommonString.cSaveButton, btnSaveClicked),
                  ),
                ))
        ),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
