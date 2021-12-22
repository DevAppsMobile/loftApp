import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:loftfin/providers/local_auth_provider.dart';
import 'package:loftfin/strings.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/custom_button.dart';
import 'package:loftfin/widgets/regster_screen_header.dart';
import 'package:provider/provider.dart';

class LocalAuthScreen extends StatefulWidget {
  static String routeName = "/local_auth_screen";

  LocalAuthScreen({Key? key}) : super(key: key);

  @override
  _LocalAuthScreenState createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Provider.of<LocalAuthInProvider>(context, listen: false)
        .getAvailableBiometrics();
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
                authData(),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
               children: [
                 CustomButton(
                   title: kStringsFaceId,
                   width: size.width * 0.3,
                   backgroundColor: AppTheme.themeColor,
                   onClick: () {
                     Provider.of<LocalAuthInProvider>(context, listen: false)
                         .authenticate();
                   },
                   height: size.height * 0.055,
                 ),

                 SizedBox(
                   height: size.height * 0.03,
                 ),
                 Text(
                   kStringsSkip,
                   style: AppTheme.textStyleSmall,
                   textAlign: TextAlign.center,
                 ),
                 SizedBox(
                   height: size.height * 0.04,
                 ),
               ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget authData() {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.75,
      padding: EdgeInsets.only(
        left: size.width * 0.08,
        right: size.width * 0.08,
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height *0.05,
            ),
            Text(
              kStringsscan,
              style: AppTheme.textStyleSmall,
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            SizedBox(
              height: 60,
              width: 60,
              child:
              context.read<LocalAuthInProvider>().availableBiometric!=null?
              context.read<LocalAuthInProvider>().availableBiometric![0]==BiometricType.face?
              Image.asset(
                'assets/images/face_id.png',
              ):Icon(
                  Icons.fingerprint,
                size:60)
              :Container(),
            ),
          ],
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
