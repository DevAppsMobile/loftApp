import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loftfin/providers/signin_provider.dart';
import 'package:loftfin/screens/phone_verification_screen.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/outline_textdield.dart';
import 'package:loftfin/widgets/register_screen_footer.dart';
import 'package:loftfin/widgets/regster_screen_header.dart';
import 'package:provider/provider.dart';

import '../strings.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in_screen";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FocusNode focusNodePhone = FocusNode();

  @override
  void initState() {
    context.read<SignInProvider>().resetFieldValues();
    focusNodePhone.requestFocus();
    super.initState();
  }

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
                  showPagination: false,
                ),
                loginInfo(context),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RegisterScreenFooter(
                nextButtonAction: () {
                  if (Provider.of<SignInProvider>(context, listen: false)
                      .validatePhoneNumber()) {
                    if (context.read<SignInProvider>().validatePhoneNumber()) {
                      context.read<SignInProvider>().isSignUp = false;
                      context.read<SignInProvider>().sendVerificationCode();

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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginInfo(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                kStringsWelcomeBack,
                textAlign: TextAlign.center,
                style: AppTheme.textStyleSmall,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                kStringsAskPhoneNumber,
                textAlign: TextAlign.center,
                style: AppTheme.textStyleSmall,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            OutlineTextField(
              title: kStringsPhoneNumber,
              isError: context.watch<SignInProvider>().isPhoneError,
              keyboardType: TextInputType.number,
              controller: context.read<SignInProvider>().textPhone,
              focusNode: focusNodePhone,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              maxLength: 13,
            ),
            SizedBox(
              height: size.height * 0.4,
            ),
          ],
        ),
      ),
    );
  }
}
