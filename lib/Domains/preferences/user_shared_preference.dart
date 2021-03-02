import 'package:hqclass/Domains/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  Future<bool> saveLoginConfig(String userName, String password, String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userName);
    prefs.setString("password", password);
    prefs.setString("token", token);
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