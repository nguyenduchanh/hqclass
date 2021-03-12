import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Pages/Classes/classes_detail.dart';
import 'package:hqclass/Pages/RollUp/roll_up_detail_page.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:hqclass/Util/widgets.dart';

class RollUpPageBody extends StatefulWidget {
  RollUpPageBody({Key key}) : super(key: key);

  @override
  _RollUpBodyListState createState() => _RollUpBodyListState();
}

class _RollUpBodyListState extends State<RollUpPageBody> {
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
  List<ClassesModel> getStudentCodeListFromClass(ClassesModel classesModel)  {
    return [];
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
      decoration: buildSearchInputDecoration(
          "Tìm kiếm lớp học", "Nhập mã hoặc tên lớp học "),
    );
    return Scaffold(
      backgroundColor: CommonColors.lightGray,
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 10, left: 15, right: 15),
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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RollUpDetailPage(classesModel: classesModel)));
        },
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
//      secondaryActions: <Widget>[
//        IconSlideAction(
//          caption: 'Edit',
//          color: Colors.black45,
//          icon: Icons.edit,
//          onTap: () => {
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) =>
//                        ClassesDetailPage(currentClass: cls)))
//          },
//        ),
//      ],
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
