import 'package:flutter/material.dart';
import 'package:hqclass/Pages/Login/login.dart';
import 'package:hqclass/Pages/Register/register.dart';
import 'package:provider/provider.dart';
import 'Components/splash_screen.dart';
import 'Domains/auth.dart';
import 'Pages/Classes/classes_page.dart';
import 'Pages/Home/home.dart';
import 'Pages/RollUp/roll_up_page.dart';
import 'Pages/Students/students_page.dart';
import 'Util/Constants/strings.dart';

void main() {
  // runApp(MyApp());
  runApp(SplashScreenPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    Future<String> _getUserName() => UserPreferences().GetUserNameConfig();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
//        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: CommonString.cMainTitle,
          theme: ThemeData(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
//              future: _getUserName(),
              builder: (context, snapshot) {
            return Login();
//                switch (snapshot.connectionState) {
//                  case ConnectionState.none:
//                  case ConnectionState.waiting:
//                    return CircularProgressIndicator();
//                  default:
//                    if (snapshot.hasError)
//                      return Text('Error: ${snapshot.error}');
//                    else if (snapshot.data.token == null)
//                      return Login();
////                    else
////                      UserPreferences().removeUser();
//                    return Login();
//                }
          }),
          routes: {
            '/home': (context) => Home(),
            '/login': (context) => Login(),
            '/register': (context) => Register(),
            '/classes': (context) => ClassesPage(),
            '/students': (context) => StudentPage(),
            '/rollup': (context) => RollUp(),
          }),
    );
  }
}
