import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hqclass/Domains/user.dart';
import 'package:hqclass/Util/Constants/dtb_helper.dart';
import 'package:http/http.dart';

class UserController {
  Future<UserModel> GetUsers(_domainStr) async {
    UserModel result;
    Response response;
    try {
      response = await get(
        _domainStr + DBHelper.user_url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));
    } on TimeoutException catch (e) {
      result = null;
    } on Error catch (e) {
      result = null;
    }
    if (response.statusCode == 200) {
      var resultObjJson = jsonDecode(response.body)['data'];
      result = UserModel.fromJson(resultObjJson);
    } else {
      result = null;
    }
    return result;
  }
}
