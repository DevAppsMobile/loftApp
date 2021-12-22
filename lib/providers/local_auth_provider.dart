import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthInProvider with ChangeNotifier {
  List<BiometricType>? availableBiometric;
  final LocalAuthentication auth = LocalAuthentication();
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (availableBiometrics.isEmpty) {
      return;
    }
    availableBiometric = availableBiometrics;
    notifyListeners();
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
        isAuthenticating = true;
        authorized = 'Authenticating';
        notifyListeners();
      authenticated = await auth.authenticate(
          localizedReason: 'Loft App ',
          useErrorDialogs: true,
          stickyAuth: true);
        isAuthenticating = false;
        notifyListeners();
    } on PlatformException catch (e) {
        isAuthenticating = false;
        authorized = 'Error - ${e.message}';
        notifyListeners();
      return;
    }
    authorized = authenticated ? 'Authorized' : 'Not Authorized';
    notifyListeners();
  }
}