import 'package:flutter/material.dart';
import 'package:hqclass/Constants/common_colors.dart';
import 'package:hqclass/Pages/Login/login_screen.dart';
import 'package:hqclass/Pages/login.dart';
import 'package:hqclass/Pages/register.dart';
import 'package:hqclass/Providers/auth.dart';
import 'package:hqclass/Providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'Components/splash_screen.dart';
import 'Domains/user.dart';
import 'Util/shared_preference.dart';

void main() {
 // runApp(MyApp());
  runApp(SplashScreenPage());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data.token == null)
                      return Login();
                    else
                      UserPreferences().removeUser();
                    return Login();
                }
              }),
          routes: {
            '/login': (context) => Login(),
          }),
    );
  }
}

class MyApp2 extends StatelessWidget {
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
