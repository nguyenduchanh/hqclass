import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';


class BiometricPage extends StatefulWidget {
  BiometricPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BiometricPageState createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listofBiometrics;
    try {
      listofBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listofBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      var localAuth = LocalAuthentication();
      bool didAuthenticate =
      await localAuth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          biometricOnly: true);
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Can we check Biometric : $_canCheckBiometric"),
            TextButton(
              onPressed: _checkBiometric,
              child: Text("Check Biometric"),
            ),
            Text("List Of Biometric : ${_availableBiometricTypes.toString()}"),
            TextButton(
              onPressed: _getListOfBiometricTypes,
              child: Text("List of Biometric Types"),
            ),
            Text("Authorized : $_authorizedOrNot"),
            TextButton(
              onPressed: _authorizeNow,
              child: Text("Authorize now"),
            ),
          ],
        ),
      ),
    );
  }
}
