import 'package:hqclass/Domains/preferences/user_shared_preference.dart';

class User {
  String name;
  String password;
  String email;
  String phone;
  String type;
  String token;
  String renewalToken;

  User({
    this.name,
    this.password,
    this.email,
    this.phone,
    this.type,
    this.token,
    this.renewalToken
  });

  factory User.fromJson(Map<String, dynamic> responseData){
    return User(
        name: responseData['name'],
        email: responseData['email'],
        phone: responseData['phone'],
        type: responseData['type'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']
    );
  }
}
