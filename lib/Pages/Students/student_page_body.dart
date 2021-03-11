
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Pages/Students/student_detail_page.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';

class StudentPageBody extends StatefulWidget {
  StudentPageBody({Key key}) : super(key: key);

  @override
  _StudentListState createState() => _StudentListState();
}
class _StudentListState extends State<StudentPageBody> {
  Future<List<StudentModel>> studentList;
  BaseDao baseDao;

  @override
  void initState() {
    super.initState();
    baseDao = BaseDao();
    refreshStudentList();
  }
  refreshStudentList() async {
    setState(() {
      studentList = baseDao.getStudents();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      StudentDetailPage(currentStudent: null)))
        }),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
  ListTile makeListStudentTileV2(StudentModel studentModel) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: Border(
              right: new BorderSide(
                  width: 1.0, color: CommonColors.kPrimaryColor))),
      child: Text(studentModel.studentCode,
          style: TextStyle(
              color: CommonColors.kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
    ),
    title: Text(
      studentModel.studentName,
      style: TextStyle(
          color: CommonColors.kPrimaryColor, fontWeight: FontWeight.bold),
    ),
    trailing: Icon(Icons.keyboard_arrow_right,
        color: CommonColors.kPrimaryColor, size: 30.0),
  );

  Card makeStudentCardV2(StudentModel std) => Card(
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
                        StudentDetailPage(currentStudent: std)))
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            final StudentConfirmAction action = await CDialog._asyncConfirmDialog(
                context,
                'Xác nhận!',
                'Bạn có chắc chắn muốn xóa dữ liệu này!');
            if (action == StudentConfirmAction.ACCEPT) {
              await baseDao.deleteStudent(std.id);
              refreshStudentList();
            } else {}
          },
        ),
      ],
    ),
  );

  SingleChildScrollView generateStudentListV2(List<StudentModel> classesModel) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: classesModel.length,
              itemBuilder: (BuildContext context, int index) {
                return makeStudentCardV2(classesModel[index]);
              }),
        ));
  }
}


enum StudentConfirmAction { CANCEL, ACCEPT }

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
                Navigator.of(context).pop(StudentConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                Navigator.of(context).pop(StudentConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }
}