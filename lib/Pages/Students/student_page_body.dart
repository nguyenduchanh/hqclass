
import 'package:flutter/material.dart';
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
  Future<List<StudentModel>> classesList;
  BaseDao baseDao;

  @override
  void initState() {
    super.initState();
    baseDao = BaseDao();
    refreshStudentList();
  }
  refreshStudentList() async {
    setState(() {
      classesList = baseDao.getStudents();
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
  SingleChildScrollView generateListV2(List<StudentModel> classesModel) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
//          child: ListView.builder(
//              scrollDirection: Axis.vertical,
//              shrinkWrap: true,
//              itemCount: classesModel.length,
//              itemBuilder: (BuildContext context, int index) {
//                return makeClassesCardV2(classesModel[index]);
//              }),
        ));
  }
}