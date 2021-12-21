import 'package:loftfin/models/loft_user.dart';
import 'package:loftfin/networking/api_client.dart';
import 'package:loftfin/services/log_service.dart';

import 'firebase_auth.dart';

class ApiRepository {
  final FirebaseAuthHandler _authHandler = FirebaseAuthHandler();
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, String>> _getAuthHeader() async {
    String? accessToken = await _authHandler.getFirebaseToken();
    dPrint(accessToken);
    if (accessToken == null) {
      return <String, String>{};
    } else {
      return {'Authorization': 'Bearer ' + accessToken};
    }
  }

  Future<void> signInWithPhoneNumber({required String phoneNumber}) async {
    await _authHandler.phoneSignIn(
      phoneNumber: phoneNumber,
    );
  }

  Future<bool> verifyUserWithOtp({required String smsCode}) async {
    bool status = await _authHandler.verifyOtp(smsCode: smsCode);
    return status;
  }

  Future registerUser(LoftUser user) async {
    Map<String, String> header = await _getAuthHeader();
    _apiClient.createRecordOnServer(
        url: 'register-user', body: user.toMap(), header: header);
  }
}
