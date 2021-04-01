import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hqclass/Domains/Storage/base_dao.dart';
import 'package:hqclass/Domains/models/classes.dart';
import 'package:hqclass/Domains/models/rollup.dart';
import 'package:hqclass/Pages/RollUp/roll_up_detail_page.dart';
import 'package:hqclass/Pages/RollUp/roll_up_detail_page_body.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';

class RollUpHistoryDetailBody extends StatefulWidget {
  final ClassesModel currentClasses;

  RollUpHistoryDetailBody({Key key, this.currentClasses}) : super(key: key);

  @override
  _RollUpHistoryDetailBodyState createState() => _RollUpHistoryDetailBodyState();
}

class _RollUpHistoryDetailBodyState extends State<RollUpHistoryDetailBody> {
  Future<List<RollUpModel>> rollUpModel;
  List<RollUpModel> rollUpModel2;
  BaseDao baseDao;
  @override
  void initState() {
    super.initState();
    baseDao = BaseDao();
    refreshRollupList();
  }
  refreshRollupList() async {
    rollUpModel =  baseDao.getRollup();
    rollUpModel2 = await baseDao.getRollup();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: CommonColors.lightGray,
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: rollUpModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateRollupListV2(snapshot.data);
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
  Card makeRollupCardV2(RollUpModel std) => Card(
    elevation: 0,
    child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: makeListRollupTileV2(std),
        ),
      ),
    ),
  );
  generateRollupListV2(List<RollUpModel> rollUpModel) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: rollUpModel.length,
        itemBuilder: (BuildContext context, int index) {
          return makeRollupCardV2(rollUpModel[index]);
        });
  }
  ListTile makeListRollupTileV2(RollUpModel rollUpModel) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
//    leading: Container(
//      padding: EdgeInsets.only(right: 12.0),
//      decoration: new BoxDecoration(
//          border: Border(
//              right: new BorderSide(
//                  width: 1.0, color: CommonColors.kPrimaryColor))),
//      child: Text('',
//          style: TextStyle(
//              color: CommonColors.kPrimaryColor,
//              fontSize: 18,
//              fontWeight: FontWeight.bold)),
//    ),
    title: Text(
      rollUpModel.createDate.day.toString() + "-"
          + rollUpModel.createDate.month.toString() +"-"
          +rollUpModel.createDate.year.toString()+" : "
          + rollUpModel.createDate.hour.toString() + "-"
          + rollUpModel.createDate.minute.toString() ,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: CommonColors.kPrimaryColor,
          fontSize: 22,
          fontWeight: FontWeight.bold),
    ),
    trailing: Icon(Icons.keyboard_arrow_right,
        color: CommonColors.kPrimaryColor, size: 30.0),
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RollUpDetailPage(classesModel: widget.currentClasses, state: rollUpModel.rollupData)));
    },
  );
}