import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  CreateUserConfig(String userName, String password, String token, SignInSource signInSource) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", userName);
    await prefs.setString("password", password);
    await prefs.setString("signInSource", signInSource.toString());
    await prefs.setString("token", token);
    await prefs.setBool("isBiometricAvailable", false);
  }
  SetBiometric(bool isBiometricAvailable) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isBiometricAvailable", isBiometricAvailable);
  }
  Future<String> GetTokenConfig()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    return token;
  }
  Future<String> GetUserNameConfig()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName') ?? "";
    return userName;
  }
  Future<String> GetPasswordConfig()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('password') ?? "";
    return token;
  }
}
enum SignInSource {
  none,
  google
}