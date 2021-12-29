import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/custom_button.dart';
import 'package:loftfin/widgets/regster_screen_header.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../strings.dart';

class AddBankAccountScreen extends StatefulWidget {
  static String routeName = "/add_bank_screen";

  const AddBankAccountScreen({Key? key}) : super(key: key);

  @override
  _AddBankAccountScreenState createState() =>
      _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.07,
            ),
            SizedBox(
              height: 35,
              child: Image.asset(
                'assets/images/welcome_icon.png',
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                kStringsBankAccount,
                textAlign: TextAlign.center,
                style: AppTheme.textStyleHeading.copyWith(fontSize: 19),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height: 145,
              child: Image.asset(
                'assets/images/welcome_icon.png',
              ),
            ),
            SizedBox(height: size.height * 0.03),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                kStringsAddBankAccountInfo,
                textAlign: TextAlign.center,
                style: AppTheme.textStyleSmall,
              ),
            ),
            SizedBox(height: size.height * 0.042),
            CustomButton(
              title: kStringsAddBank,
              width: size.width * 0.43,
              backgroundColor: AppTheme.themeColor,
              onClick: () {

    showModalBottomSheet<void>(
    context: context,
    barrierColor: AppTheme.blue.withOpacity(0.4),
    backgroundColor:  AppTheme.blue.withOpacity(0.1),
    builder: (BuildContext context) {
    return _popupAlert();});
              },
              height: size.height * 0.065,
            ),
          ],
        ),
    );
  }

  Widget _popupAlert(){
    final size = MediaQuery.of(context).size;
    return Container(
      height: 300,
      margin: EdgeInsets.only(
        right: 10.0,
        left: 10.0,
      ),
      padding: EdgeInsets.only(
        top: 2.0,
        bottom: 10.0,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0)),
        color: AppTheme.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_outlined,color: AppTheme.buttonBlue,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    kStringsInstantVerification,
                    textAlign: TextAlign.center,
                    style: AppTheme.textStyleHeading,
                  ),
                ),
              ),

            ],
          ),
          Container(
            color: AppTheme.grey,
            height: 1,
            width:size.width,
          ),
          Padding(padding: EdgeInsets.only(
              top: 2.0,
              left: 10.0,
              right:10.0
          ),child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: AppTheme.textStyleSmall.copyWith(
                      color: AppTheme.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: kStringsAppName,
                        style: AppTheme.textStyleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                          text: " uses",
                          style: AppTheme.textStyleSmall
                      ),
                      TextSpan(
                        text: " paid",
                        style: AppTheme.textStyleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                          text: " to verify your bank account information and, periodically, your bank account balance to check you have enough funds to cover certain transactions",
                          style: AppTheme.textStyleSmall
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15,),
                RichText(
                  text: TextSpan(
                    style: AppTheme.textStyleSmall.copyWith(
                      color: AppTheme.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "You can turn off",
                          style: AppTheme.textStyleSmall
                      ),
                      TextSpan(
                        text: " Loft\'s",
                        style: AppTheme.textStyleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                          text: " use of",
                          style: AppTheme.textStyleSmall
                      ),
                      TextSpan(
                        text: " paid",
                        style: AppTheme.textStyleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                          text: " by removing the bank account. You can always our manual verification process to add a bank account, which doesn\'t use ",
                          style: AppTheme.textStyleSmall
                      ),
                      TextSpan(
                        text: " paid",
                        style: AppTheme.textStyleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                CustomButton(
                  title: kStringsContinue,
                  width: size.width ,
                  backgroundColor: AppTheme.buttonBlue,
                  onClick: () {
                  },

                  height: 40,
                ),
              ])),
        ],
      ),
    );
  }
}
