import 'package:flutter/cupertino.dart';
import 'package:hqclass/Domains/user.dart';

class UserProvider with ChangeNotifier{
  User _user = new User();
  User get user => _user;
  void setUser(User user){
    _user = user;
    notifyListeners();
  }
}