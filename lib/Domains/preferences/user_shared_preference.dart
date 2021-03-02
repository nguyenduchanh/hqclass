import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  CreateUserConfig(String userName, String password, String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", userName);
    await prefs.setString("password", password);
    await prefs.setString("token", token);
  }
  Future<String> GetTokenConfig()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    return token;
  }
  Future<String> GetUserNameConfig()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('userName') ?? "";
    return token;
  }
  Future<String> GetPasswordConfig()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('password') ?? "";
    return token;
  }
}