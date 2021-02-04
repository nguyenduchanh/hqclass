import 'package:flutter/material.dart';
import 'Components/splash_screen.dart';
import 'Pages/Welcome/welcome.dart';

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
      home: WelcomeScreen(),
    );
  }
}
