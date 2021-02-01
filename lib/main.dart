import 'package:flutter/material.dart';
import 'package:hqclass/screens/classes.dart';
import 'package:hqclass/screens/home.dart';
import 'package:hqclass/screens/onboarding.dart';
import 'package:provider/provider.dart';

import 'Domains/user.dart';
import 'Pages/dashboard.dart';
import 'Pages/login.dart';
import 'Pages/register.dart';
import 'Pages/Welcome/welcome.dart';
import 'Providers/auth.dart';
import 'Providers/user_provider.dart';
import 'Util/shared_preference.dart';

void main() {
  runApp(MyApp());
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
