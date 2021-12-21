import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loftfin/providers/signin_provider.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/custom_button.dart';
import 'package:loftfin/widgets/regster_screen_header.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../strings.dart';

class PhoneVerificationScreen extends StatefulWidget {
  static String routeName = "/phone_verification_screen";

  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RegisterScreenHeader(
              pageIndex: 2,
              subTitle: kStringsVerifyIdentity,
              showPagination: context.read<SignInProvider>().isSignUp,
            ),
            SizedBox(height: size.height * 0.1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                kStringsOtpInfo,
                textAlign: TextAlign.center,
                style: AppTheme.textStyleSmall,
              ),
            ),
            SizedBox(height: size.height * 0.07),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                autoFocus: true,
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5.0),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: Color(0XFFF5F5F8),
                  inactiveColor: Colors.black26,
                  activeFillColor: Color(0XFFF5F5F8),
                  inactiveFillColor: Color(0XFFF5F5F8),
                  selectedFillColor: Color(0XFFF5F5F8),
                  selectedColor: Colors.black45,
                ),
                enableActiveFill: true,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    context.read<SignInProvider>().otpString = value;
                  });
                },
                onSubmitted: (value) async {
                  EasyLoading.show(status: kStringsVerifyingUser);
                  bool status =
                      await context.read<SignInProvider>().verifyUserWithOtp();
                  EasyLoading.dismiss();
                  if (status) {
                    EasyLoading.showSuccess(kStringsCreateSuccess);
                  } else {
                    EasyLoading.showError(kStringsCreateFailed);
                  }
                },
              ),
            ),
            SizedBox(height: size.height * 0.2),
            CustomButton(
              title: kStringsResendCode,
              width: size.width * 0.45,
              backgroundColor: AppTheme.themeColor,
              onClick: () {},
              height: size.height * 0.055,
            ),
          ],
        ),
      ),
    );
  }
}
