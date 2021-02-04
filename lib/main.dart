import 'package:flutter/material.dart';
import 'package:hqclass/Pages/Login/login_screen.dart';
import 'Components/splash_screen.dart';

void main() {
//  runApp(MyApp());
  runApp(SplashScreenPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HQ Class',
      theme: ThemeData(),
      home: LoginScreen(),
    );
  }
}
