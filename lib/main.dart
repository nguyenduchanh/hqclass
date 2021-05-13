// @dart=2.10
import 'package:flutter/material.dart';
import 'package:hqclass/Pages/Backup/backup_page.dart';
import 'package:hqclass/Pages/Login/login.dart';
import 'package:hqclass/Pages/Register/register_page.dart';
import 'package:hqclass/Pages/UserInfo/user_info_page.dart';
import 'package:provider/provider.dart';
import 'Components/splash_screen.dart';
import 'Domains/auth.dart';
import 'Pages/Classes/classes_page.dart';
import 'Pages/Home/home.dart';
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
              builder: (context, snapshot) {
//                final mediaQueryData = MediaQuery.of(context);
//                final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);
                return MediaQuery(
                  child: Login(),
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                );
            return Login();
          }),
          routes: {
            '/home': (context) => Home(),
            '/login': (context) => Login(),
            '/register': (context) => RegisterPage(),
            '/classes': (context) => ClassesPage(),
            '/students': (context) => StudentPage(),
//            '/rollup': (context) => RollUp(),
            '/backup': (context) => BackupPage(),
            '/user_info': (context) => UserInfoPage(),
          }),

    );
  }
}
