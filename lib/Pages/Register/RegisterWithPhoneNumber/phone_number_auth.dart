import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, VoidCallback;
import 'package:hqclass/Pages/Register/RegisterWithPhoneNumber/FireBase.dart';

enum PhoneAuthState {
  Started,
  CodeSend,
  CodeRequest,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeout
}

class PhoneNumberAuthDataProvider with ChangeNotifier {
  VoidCallback onStarted,
      onCodeSent,
      onCodeResent,
      onVerified,
      onFailed,
      onError,
      onAutoRetrievalTimeout;
  bool _loading = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  PhoneAuthState _status;
  var _authCredential;
  String _actualCode;
  String _phone, _message;

  TextEditingController get phoneNumberController => _phoneNumberController;
  get phone => _phone;
  set phone(String value){
    _phone = value;
    notifyListeners();
  }
  get actualCode => _actualCode;
  set actualCode(String value){
    _actualCode = value;
    notifyListeners();
  }
  get message => _message;
  set message(String value){
    _message = value;
    notifyListeners();
  }
  PhoneAuthState get status => _status;
  set status(PhoneAuthState value){
    _status = value;
    notifyListeners();
  }
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }
  setMethods(
      {VoidCallback onStarted,
      VoidCallback onCodeSent,
      VoidCallback onCodeResent,
      VoidCallback onVerified,
      VoidCallback onFailed,
      VoidCallback onError,
      VoidCallback onAutoRetrievalTimeout}) {
    this.onStarted = onStarted;
    this.onCodeSent = onCodeSent;
    this.onCodeResent = onCodeResent;
    this.onVerified = onVerified;
    this.onFailed = onFailed;
    this.onError = onError;
    this.onAutoRetrievalTimeout = onAutoRetrievalTimeout;
  }
  Future<bool> instantiate(
      String dialCode,
      VoidCallback onStarted,
      VoidCallback onCodeSent,
      VoidCallback onCodeResent,
      VoidCallback onVerified,
      VoidCallback onFailed,
      VoidCallback onError,
      VoidCallback onAutoRetrievalTimeout
      ) async {
    this.onStarted = onStarted;
    this.onCodeSent = onCodeSent;
    this.onCodeResent = onCodeResent;
    this.onVerified = onVerified;
    this.onFailed = onFailed;
    this.onError = onError;
    this.onAutoRetrievalTimeout = onAutoRetrievalTimeout;
    if(phoneNumberController.text.length < 10){
      return false;
    }
    phone = dialCode +phoneNumberController.text;
    _startAuth();
    return true;
  }
  _startAuth(){
    final PhoneCodeSent codeSent = (String verificationId,[int forceResendingToken])async{
      actualCode = verificationId;
      _addStatusMessage("\nEnter the code sent to " + phone);
      _addStatus(PhoneAuthState.CodeSend);
      if(onCodeSent != null) onCodeSent();
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
     actualCode = verificationId;
     _addStatusMessage("\nAuto retrieval time out");
     if(onAutoRetrievalTimeout != null) onAutoRetrievalTimeout();
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException error) {
      _addStatusMessage('${error.message}');
      _addStatus(PhoneAuthState.Failed);
      if (onFailed != null) onFailed();
      if (error.message.contains('not authorized'))
        _addStatusMessage('App not authroized');
      else if (error.message.contains('Network'))
        _addStatusMessage(
            'Please check your internet connection and try again');
      else
        _addStatusMessage('Something has gone wrong, please try later ' +
            error.message);
    };
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      _addStatusMessage('Auto retrieving verification code');

      FireBase.auth.signInWithCredential(auth).then((UserCredential value) {
        if (value.user != null) {
          _addStatusMessage('Authentication successful');
          _addStatus(PhoneAuthState.Verified);
          if (onVerified != null) onVerified();
        } else {
          if (onFailed != null) onFailed();
          _addStatus(PhoneAuthState.Failed);
          _addStatusMessage('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        if (onError != null) onError();
        _addStatus(PhoneAuthState.Error);
        _addStatusMessage('Something has gone wrong, please try later $error');
      });
    };
    FireBase.auth.verifyPhoneNumber(phoneNumber: phone.toString(),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout).then((value) {

    }).catchError((error){

    });





  }
  _addStatus(PhoneAuthState state){
    status = state;
  }
  _addStatusMessage(String s){
    message = s;
  }
}
