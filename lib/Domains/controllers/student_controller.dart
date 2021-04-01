import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hqclass/Domains/models/student.dart';
import 'package:hqclass/Util/Constants/dtb_helper.dart';
import 'package:http/http.dart';

class StudentController {
  Future<List<StudentModel>> GetStudents(_domainStr) async {
    List<StudentModel> result;
    Response response;
    try {
      response = await get(
        _domainStr + DBHelper.student_url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));
    } on TimeoutException catch (e) {
      result = null;
      log("login timeout");
    } on Error catch (e) {
      result = null;
      log('Error: $e');
    }
    if (response.statusCode == 200) {
      var resultObjJson = jsonDecode(response.body)['data'] as List;
      result = resultObjJson.map((cl) => StudentModel.fromMap(cl)).toList();
    } else {
      result = null;
    }
    return result;
  }

  Future<bool> ExportStudents(_domainStr, List<StudentModel> stdList) async {
    var result;
    List<Map> studentOptionJson = new List();
    stdList.forEach((item) {
      studentOptionJson.add(item.toMap());
    });
    Response response;
    try {
      response = await post(
        _domainStr + DBHelper.export_student_url,
        body: json.encode({
          'student': studentOptionJson,
        }),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));
    } on TimeoutException catch (e) {
      result = false;
    } on Error catch (e) {
      result = false;
    }

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }
}
