import 'package:flutter/material.dart';
import 'package:hqclass/Domains/models/classes.dart';

class RollUpDetailBody extends StatelessWidget {
  final ClassesModel currentClasses;

  RollUpDetailBody({Key key, @required this.currentClasses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
//class RollUpDetailBody extends StatefulWidget {
//  final ClassesModel currentClasses;
//
//  RollUpDetailBody({Key key, @required this.currentClasses}) : super(key: key);
//
//  @override
//  _RollUpDetailBodyState createState() => _RollUpDetailBodyState();
//}
//
//class _RollUpDetailBodyState extends State<RollUpDetailBody> {
//  String studentCodeList ;
//  @override
//  void initState() {
//    super.initState();
//    studentCodeList = currentClasses.
////    baseDao = BaseDao();
////    refreshClassesList();
//  }
//
//  Widget build(BuildContext context) {
//    return Scaffold();
//  }
//}
