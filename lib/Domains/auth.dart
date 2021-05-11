import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/dtb_helper.dart';
import 'package:http/http.dart';
enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}
class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  Future<Map<String, dynamic>> login(String userName, String password) async{
    var result;
    final Map<String, dynamic> loginData = {
      'username':  userName,
      'password':   password
    };
    _loggedInStatus = Status.Authenticating;
    notifyListeners();
    Response response ;
    try{

      response  = await post(
        Uri(path: DBHelper.login_url),
        body: json.encode(loginData),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 5));
    } on TimeoutException catch(e){
      _loggedInStatus = Status.NotLoggedIn;
      result = {
        'status': false,
        'data': null,
        'message': json.decode(response.body)['error']
      };
      log("login timeout");
    } on Error catch (e) {
      result = {
        'status': false,
        'data': null,
        'message': json.decode(response.body)['error']
      };
      _loggedInStatus = Status.NotLoggedIn;
      log('Error: $e');
    }

    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = json.decode(response.body);
      var userData = responseData['data'];
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();
      result = {'status': true, 'message': 'Successful', 'data': userData.toString()};
    }else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'data': null,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
}