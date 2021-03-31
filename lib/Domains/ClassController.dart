import 'dart:developer';

import 'package:hqclass/Util/Constants/dtb_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:http/http.dart';

import 'auth.dart';
import 'models/classes.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassController {
  Future<List<ClassesModel>> GetClasses() async {
    List<ClassesModel> result;

    Response response;
    try {
      response = await get(
        DBHelper.class_url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));
    } on TimeoutException catch (e) {
//      result = {
//        'status': false,
//        'data': null,
//        'message': json.decode(response.body)['error']
//      };
      result = null;
      log("login timeout");
    } on Error catch (e) {
//      result = {
//        'status': false,
//        'data': null,
//        'message': json.decode(response.body)['error']
//      };
      result = null;
      log('Error: $e');
    }

    if (response.statusCode == 200) {
      var resultObjJson = jsonDecode(response.body)['data'] as List;
      result = resultObjJson.map((cl) => ClassesModel.fromMap(cl)).toList();
    } else {
//      result = {
//        'status': false,
//        'data': null,
//        'message': json.decode(response.body)['error']
//      };
    result = null;
    }
    return result;
  }

  Future<List<ClassesModel>> fetchClasses() async {
    final response = await http.get("http://localhost:9999/v1/classes");
    if (response.statusCode == 200) {
      return postFromJson(jsonDecode(response.body));
    }
  }

  List<ClassesModel> postFromJson(String str) => List<ClassesModel>.from(
      json.decode(str).map((x) => ClassesModel.fromMap(x)));
}
