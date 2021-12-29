import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/custom_button.dart';
import 'package:loftfin/widgets/regster_screen_header.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../strings.dart';

class CreatePinScreen extends StatefulWidget {
  static String routeName = "/create_pin_screen";

  const CreatePinScreen({Key? key}) : super(key: key);

  @override
  _CreatePinScreenState createState() =>
      _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RegisterScreenHeader(
              pageIndex: 3,
              subTitle: kStringsExtraSecurity,
            ),
            SizedBox(height: size.height * 0.1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                kStringsCreatePinInfo,
                textAlign: TextAlign.center,
                style: AppTheme.textStyleSmall,
              ),
            ),
            SizedBox(height: size.height * 0.07),

             Container(
               width: size.width * 0.55,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   border: Border.all(color: AppTheme.grey, width: 1),
                   color: AppTheme.white,
                 ),
               child:Center(
                   child:
                   TextFormField(
                     textAlign: TextAlign.center,
                     style: AppTheme.textStyleHeading.copyWith(fontSize: 28,letterSpacing: 15.0,),
                     obscureText: true,
                     maxLength: 4,
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       contentPadding: EdgeInsets.all(5),
                       counterText: '',
                       // hintText: title,
                     ),
                     ),
                   ),
            ),
            SizedBox(height: size.height * 0.08),
            CustomButton(
              title: kStringsSave,
              width: size.width * 0.35,
              backgroundColor: AppTheme.themeColor,
              onClick: () {},
              height: size.height * 0.07,
            ),
          ],
        ),
      ),
    );
  }
}
