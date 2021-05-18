import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hqclass/Domains/models/user.dart';
import 'package:hqclass/Util/Constants/dtb_helper.dart';
import 'package:http/http.dart';

class UserController {
  // Future<UserModel> GetUsers(_domainStr) async {
  //   UserModel result;
  //   Response response;
  //   try {
  //     response = await get(
  //       _domainStr + DBHelper.user_url,
  //       headers: {'Content-Type': 'application/json'},
  //     ).timeout(const Duration(seconds: 5));
  //   } on TimeoutException catch (e) {
  //     result = null;
  //   } on Error catch (e) {
  //     result = null;
  //   }
  //   if (response.statusCode == 200) {
  //     var resultObjJson = jsonDecode(response.body)['data'];
  //     result = UserModel.fromJson(resultObjJson);
  //   } else {
  //     result = null;
  //   }
  //   return result;
  // }
  // Future<bool> ExportUsers(_domainStr, UserModel usr) async {
  //   var result;
  //
  //   Response response;
  //   try {
  //     response = await post(
  //       _domainStr + DBHelper.export_user_url,
  //       body: json.encode({
  //         'student': usr.toString(),
  //       }),
  //       headers: {'Content-Type': 'application/json'},
  //     ).timeout(const Duration(seconds: 5));
  //   } on TimeoutException catch (e) {
  //     result = false;
  //   } on Error catch (e) {
  //     result = false;
  //   }
  //
  //   if (response.statusCode == 200) {
  //     result = true;
  //   } else {
  //     result = false;
  //   }
  //   return result;
  // }
}
