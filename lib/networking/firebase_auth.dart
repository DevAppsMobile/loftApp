import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:loftfin/services/log_service.dart';

class FirebaseAuthHandler {
  FirebaseAuthHandler._privateConstructor();

  static final FirebaseAuthHandler _instance =
      FirebaseAuthHandler._privateConstructor();

  factory FirebaseAuthHandler() {
    return _instance;
  }

  //..........//

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;

  bool isUserLoggedIn() {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  void listenAuthStateChanges() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    dPrint(phoneNumber);
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeTimeout,
    );
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    dPrint('code sent');
    return true;
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
    }
  }

  Future<String?> getFirebaseToken() async {
    await _auth.currentUser!.getIdToken();
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      dPrint("The phone number entered is invalid!");
    }
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  Future<bool> verifyOtp({required String smsCode}) async {
    dPrint(smsCode);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: this.verificationId!,
      smsCode: smsCode,
    );

    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user == null) {
        dPrint('failed');
        return false;
      } else {
        dPrint('success -');
        return true;
      }
    } catch (e) {
      dPrint('Login error - $e');
      return false;
    }
  }

  Future<dynamic> logout({
    required Function errorCallback,
    required Function successCallback,
  }) async {
    listenAuthStateChanges();
    try {
      try {
        await _auth.signOut().then(
          (value) {
            successCallback();
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorCallback('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          errorCallback('Wrong password provided for that user.');
        }
      }
    } on SocketException {
      errorCallback('No internet connection');
    }
  }
}
