import 'dart:convert';

import 'package:hqclass/Util/Constants/cEnum.dart';

class UserModel {
  int id;
  String userName;
  String password;
  String email;
  String deviceLogin;
  bool isBiometricAvailable;
  RegisterTypeEnum registerType;

  UserModel(
    this.id,
    this.userName,
    this.password,
    this.email,
    this.deviceLogin,
    this.isBiometricAvailable,
    this.registerType,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
//      'id': id,
      'username': userName,
      'password': password,
      'email': email,
      'devicelogin': deviceLogin,
      'isbiometricavailable': isBiometricAvailable ? 1 : 0,
      'registertype':registerType.toString(),
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userName = map['username'];
    password = map['password'];
    email = map['email'];
    deviceLogin = map['devicelogin'];
    isBiometricAvailable = map['isbiometricavailable'] == 1 ? true : false;
    registerType = map['registerType']==RegisterTypeEnum.Email.toString()?RegisterTypeEnum.Email:RegisterTypeEnum.Google;
  }

  @override
  String toString() {
    return '{id: $id, username: $userName, password: $password, email: $email, devicelogin: $deviceLogin, isbiometricavailable: $isBiometricAvailable,registertype: $registerType}';
  }
}
