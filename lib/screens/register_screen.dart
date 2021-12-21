import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loftfin/providers/signin_provider.dart';
import 'package:loftfin/screens/phone_verification_screen.dart';
import 'package:loftfin/strings.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/outline_textdield.dart';
import 'package:loftfin/widgets/register_screen_footer.dart';
import 'package:loftfin/widgets/regster_screen_header.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register_screen";

  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FocusNode? focusNodeLastName;

  FocusNode? focusNodeName;

  FocusNode? focusNodeEmail;

  FocusNode? focusNodePhone;

  FocusNode? focusNodeRFCode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RegisterScreenHeader(
                  pageIndex: 1,
                  subTitle: kStringsRegisterLoft,
                ),
                profileInfo(),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RegisterScreenFooter(
                nextButtonAction: () {
                  if (Provider.of<SignInProvider>(context, listen: false)
                      .checkValidate()) {
                    context.read<SignInProvider>().isSignUp = true;
                    EasyLoading.show(status: kStringsSendingOtp);

                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        EasyLoading.dismiss();
                        Navigator.pushNamed(
                            context, PhoneVerificationScreen.routeName);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileInfo() {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.75,
      padding: EdgeInsets.only(
        left: size.width * 0.08,
        right: size.width * 0.08,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            context.watch<SignInProvider>().isAnyErrors
                ? Row(
                    children: [
                      Icon(
                        Icons.error,
                        color: AppTheme.red,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        kStringsErrorInfo,
                        style: AppTheme.textStyleSmall.copyWith(
                          color: AppTheme.red,
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: size.height * 0.03,
            ),
            OutlineTextField(
              title: kStringsFirstName,
              isError: context.watch<SignInProvider>().isNameError,
              controller: context.read<SignInProvider>().textName,
              keyboardType: TextInputType.name,
              focusNode: focusNodeName,
              nextFocusNode: focusNodeLastName,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            OutlineTextField(
              title: kStringsLastName,
              isError: context.watch<SignInProvider>().isLastNameError,
              keyboardType: TextInputType.name,
              controller: context.read<SignInProvider>().textLastName,
              focusNode: focusNodeLastName,
              nextFocusNode: focusNodeEmail,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            OutlineTextField(
              title: kStringsEmail,
              isError: context.watch<SignInProvider>().isEmailError,
              keyboardType: TextInputType.emailAddress,
              controller: context.read<SignInProvider>().textEmail,
              focusNode: focusNodeEmail,
              nextFocusNode: focusNodePhone,
              validator: context.read<SignInProvider>().validateEmail,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            OutlineTextField(
              title: kStringsPhoneNumber,
              isError: context.watch<SignInProvider>().isPhoneError,
              keyboardType: TextInputType.phone,
              controller: context.read<SignInProvider>().textPhone,
              focusNode: focusNodePhone,
              nextFocusNode: focusNodeRFCode,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp("[0-9 +]")),
              ],
              maxLength: 13,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            OutlineTextField(
              title: kStringsReferral,
              isError: false,
              controller: context.read<SignInProvider>().textRfCode,
              keyboardType: TextInputType.text,
              focusNode: focusNodeRFCode,
              isOptional: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom == 0
                  ? size.height * 0.18
                  : size.height * 0.4,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _backButton(BuildContext context) {
  //   TextStyle defaultStyle = TextStyle(
  //     color: kColorText,
  //     fontSize: 14,
  //     fontWeight: FontWeight.normal,
  //   );
  //   TextStyle linkStyle = TextStyle(
  //     color: kColorText,
  //     fontSize: 14,
  //     fontWeight: FontWeight.normal,
  //     decoration: TextDecoration.underline,
  //   );
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
  //     child: Align(
  //       alignment: Alignment.center,
  //       child: RichText(
  //         text: TextSpan(
  //           style: defaultStyle,
  //           children: <TextSpan>[
  //             TextSpan(
  //               text: kStringsBack,
  //               style: linkStyle,
  //               recognizer: TapGestureRecognizer()
  //                 ..onTap = () {
  //                   Navigator.pop(context);
  //                 },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
