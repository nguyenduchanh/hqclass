import 'dart:developer';
import 'package:hqclass/Util/Constants/dtb_helper.dart';
import 'package:http/http.dart';
import '../models/classes.dart';
import 'dart:async';
import 'dart:convert';

class ClassController {

  Future<List<ClassesModel>> GetClasses(_domainStr) async {
    List<ClassesModel> result;
    Response response;
    try {
      response = await get(
        _domainStr + DBHelper.class_url,
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
      result = resultObjJson.map((cl) => ClassesModel.fromMap(cl)).toList();
    } else {
      result = null;
    }
    return result;
  }

  Future<bool> ExportClasses(_domainStr, List<ClassesModel> clsList) async {
    var result;
    List<Map> classesOptionJson = new List();
    clsList.forEach((item) {
      classesOptionJson.add(item.toMap());
    });
    Response response;
    try {
      response = await post(
        _domainStr + DBHelper.export_classes_url,
        body: json.encode({
          'classes': classesOptionJson,
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
  List<ClassesModel> postFromJson(String str) => List<ClassesModel>.from(
      json.decode(str).map((x) => ClassesModel.fromMap(x)));
}
