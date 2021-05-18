
import 'dart:convert';

class UserModel {
  int id;
  String userName;
  String password;
  String email;
  String deviceLogin;
  bool isBiometricAvailable;

  UserModel(
    this.id,
    this.userName,
    this.password,
    this.email,
    this.deviceLogin,
    this.isBiometricAvailable
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
//      'id': id,
      'username': userName,
      'password': password,
      'email': email,
      'devicelogin': deviceLogin,
      'isbiometricavailable':isBiometricAvailable?1:0
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
      id = map['id'];
      userName= map['username'];
      password= map['password'];
      email= map['email'];
      deviceLogin= map['devicelogin'];
      isBiometricAvailable= map['isbiometricavailable']==1?true:false;
  }

  @override
  String toString() {
    return '{id: $id, username: $userName, password: $password, email: $email, devicelogin: $deviceLogin, isbiometricavailable: $isBiometricAvailable}';
  }
}
