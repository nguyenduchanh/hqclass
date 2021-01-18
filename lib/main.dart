import 'package:flutter/material.dart';
import 'package:hqclass/screens/classes.dart';
import 'package:hqclass/screens/home.dart';
import 'package:hqclass/screens/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'OpenSans'),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        "/onboarding": (BuildContext context) => new Onboarding(),
        "/home": (BuildContext context) => new Home(),
        "/classes": (BuildContext context) => new Classes(),

      },
    );
  }
}
