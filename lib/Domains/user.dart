
class UserModel {
  int id;
  String userName;
  String password;
  String email;
  String deviceLogin;

  UserModel({
    this.id,
    this.userName,
    this.password,
    this.email,
    this.deviceLogin,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
//      'id': id,
      'username': userName,
      'password': password,
      'email': email,
      'devicelogin': deviceLogin,
    };
    return map;
  }

  factory UserModel.fromJson(Map<String, dynamic> responseData) {
    return UserModel(
      id : responseData['id'],
      userName: responseData['username'],
      password: responseData['password'],
      email: responseData['email'],
      deviceLogin: responseData['devicelogin'],
    );
  }
}
