import 'package:flutter/cupertino.dart';
import 'package:loftfin/models/loft_user.dart';
import 'package:loftfin/networking/api_repository.dart';

class SignInProvider with ChangeNotifier {
  bool isSignUp = false;

  final textName = TextEditingController();
  final textLastName = TextEditingController();
  final textEmail = TextEditingController();
  final textPhone = TextEditingController();
  final textRfCode = TextEditingController();

  bool isNameError = false;
  bool isLastNameError = false;
  bool isPhoneError = false;
  bool isEmailError = false;
  bool isAnyErrors = false;

  String otpString = '';

  late LoftUser loftUser;

  ApiRepository _apiRepository = ApiRepository();

  void resetFieldValues() {
    textName.text = '';
    textLastName.text = '';
    textPhone.text = '';
    textEmail.text = '';
    textRfCode.text = '';
  }

  bool checkValidate() {
    if (textName.text.trim().isEmpty) {
      isNameError = true;
    } else {
      isNameError = false;
    }

    if (textLastName.text.trim().isEmpty) {
      isLastNameError = true;
    } else {
      isLastNameError = false;
    }

    if (textEmail.text.trim().isEmpty ||
        !validateEmail(textEmail.text.trim())) {
      isEmailError = true;
    } else {
      isEmailError = false;
    }

    if (!validatePhoneNumber()) {
      isPhoneError = true;
    } else {
      isPhoneError = false;
    }
    if (isNameError || isLastNameError || isEmailError || isPhoneError) {
      isAnyErrors = true;
      notifyListeners();
      return false;
    } else {
      loftUser = LoftUser(
        firstName: textName.text,
        lastName: textLastName.text,
        email: textEmail.text,
        phone: textPhone.text,
      );
      sendVerificationCode();
      isAnyErrors = false;
      notifyListeners();
      return true;
    }
  }

  void sendVerificationCode() {
    _apiRepository.signInWithPhoneNumber(phoneNumber: '+${textPhone.text}');
  }

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool isPhoneNoValid(String? phoneNo) {
    if (phoneNo == null) return false;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return regExp.hasMatch(phoneNo);
  }

  bool validatePhoneNumber() {
    if (textPhone.text.trim().isEmpty && !isPhoneNoValid(textPhone.text)) {
      isPhoneError = true;
      notifyListeners();
      return false;
    } else {
      isPhoneError = false;
      notifyListeners();
      return true;
    }
  }

  Future<bool> verifyUserWithOtp() async {
    bool status = await _apiRepository.verifyUserWithOtp(smsCode: otpString);
    if (status) {
      _apiRepository.registerUser(loftUser);
    }
    return status;
  }
}
