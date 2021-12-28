import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loftfin/strings.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/custom_button.dart';

class DashBoardScreen extends StatefulWidget {
  static String routeName = "/dash_board_screen";

  DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreen createState() => _DashBoardScreen();
}

class _DashBoardScreen extends State<DashBoardScreen> {


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final size = MediaQuery.of(context).size;
    return SafeArea(child:
      Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child:Column(
          children: [
            TopView(),
            Container(
                width: MediaQuery.of(context).size.width,
              color: AppTheme.grey,
              padding:new EdgeInsets.only(
                 top: 20.0,
                  right: 10.0,
                  bottom: 20.0,
                  left: 10.0),
             child: Column(
                  children: [
                    Refer_Freind(),
                    SizedBox(
                      height: size.height * 0.018,
                    ),

                    Phase2(),
                    ]
              )


            )

          ],
        ),)
    ));
  }

  Widget TopView(){
    final height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return   Stack(
      children: <Widget>[
        // The containers in the background and scrollable
        new Column(
          children: <Widget>[
            new Container(
              height: height * .3,
              width: MediaQuery.of(context).size.width,
              color: AppTheme.blue,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                  SizedBox(
                    height: 35,
                    child: Image.asset(
                      'assets/images/welcome_icon.png',
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    "Jeff,let's get you some cash",
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    kStringsLinkYourBank,
                    style: TextStyle(
                      color: AppTheme.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.015,
                    ),
                  ),
                ],
              ),
            ),
            BalanceMonitoring()
          ],

        ),
        new Container(
          alignment: Alignment.topCenter,
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .2,
              right: 20.0,
              left: 20.0),
          child: new Container(
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:  AppTheme.darkBlue,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        kStringsCurrentLofBalance,
                        style: TextStyle(
                          color: AppTheme.white,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.015,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),

                      Text(
                        "\$0.00",
                        style: TextStyle(
                          color: AppTheme.white,
                          fontWeight: FontWeight.w800,
                          fontSize: size.height * 0.04,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                    title: kStringsLoftMeCash,
                    width: size.width * 0.3,

                    backgroundColor: AppTheme.white,
                    txtColor: AppTheme.black,
                    onClick: () {},
                    height: size.height * 0.045,
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),

                ],
              )
          ),
        )
      ],
    );
  }

 Widget BalanceMonitoring(){
   final size = MediaQuery.of(context).size;
   return new Container(
          width: MediaQuery.of(context).size.width,
          color: AppTheme.white,
          padding: new EdgeInsets.only(
              right: 20.0,
              bottom: 20.0,
              left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'assets/images/welcome_icon.png',
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.015,
                  ),

                  Text(kStringsBalanceMonitoring,
                    style: TextStyle(
                      color: AppTheme.black,
                      fontWeight: FontWeight.w600,
                      fontSize: size.height * 0.02,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "When you link your bank account.Loft will send you an alert when your account balance falls below \$25",
                style: TextStyle(
                  color: AppTheme.black,
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.015,
                ),
              ),
              SizedBox(
                height: size.height * 0.016,
              ),

              CustomButton(
                title: kStringsSetUp,
                width: size.width * 0.3,
                backgroundColor: AppTheme.themeColor,
                txtColor: AppTheme.white,
                onClick: () {},
                height: size.height * 0.045,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),

            ],
          )
      );
  }


  Widget Refer_Freind(){
    final size = MediaQuery.of(context).size;
    return new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:  AppTheme.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),

        padding: new EdgeInsets.only(
            right: 20.0,
            top: 20.0,
            bottom: 20.0,
            left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    'assets/images/welcome_icon.png',
                  ),
                ),
                SizedBox(
                  height: size.width * 0.015,
                ),

                Text(
                 kStringsReferFriend,
                  style: TextStyle(
                    color: AppTheme.black,
                    fontWeight: FontWeight.w600,
                    fontSize: size.height * 0.02,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "Let's build a loft community together.Refer a friend and get the ability to get two lofts at a time",
              style: TextStyle(
                color: AppTheme.black,
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.015,
              ),
            ),
            SizedBox(
              height: size.height * 0.016,
            ),

            CustomButton(
              title: kStringsStartFeral,
              width: size.width * 0.3,
              backgroundColor: AppTheme.themeColor,
              txtColor: AppTheme.white,
              onClick: () {},
              height: size.height * 0.045,
            ),
            SizedBox(
              width: size.width * 0.02,
            ),

          ],
        )
    );
  }

  Widget Phase2(){
    final size = MediaQuery.of(context).size;
    return new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(
              color: Colors.blue, //                   <--- border color
              width: 2.0,
            )
        ),

        padding: new EdgeInsets.only(
            right: 20.0,
            top: 20.0,
            bottom: 20.0,
            left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    'assets/images/welcome_icon.png',
                  ),
                ),
                SizedBox(
                  height: size.width * 0.015,
                ),

                Text(
                  kStringsPhase2,
                  style: TextStyle(
                    color: AppTheme.black,
                    fontWeight: FontWeight.w600,
                    fontSize: size.height * 0.02,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "Better Budgeting",
              style: TextStyle(
                color:Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: size.height * 0.02,
              ),
              maxLines: 2,
            ),
            Text(
              "Let's build a loft community together.Refer a friend and get the ability to get two lofts at a time",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.015,
              ),
            ),
            SizedBox(
              height: size.height * 0.017,
            ),
            Text(
              "Credit Helper",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: size.height * 0.02,
              ),
              maxLines: 2,
            ),
            Text(
              "Let's build a loft community together.Refer a friend and get the ability to get two lofts at a time",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.015,
              ),
            ),
            SizedBox(
              height: size.height * 0.017,
            ),
            Text(
              "Goal Setting",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: size.height * 0.02,
              ),
              maxLines: 2,
            ),
            Text(
              "Let's build a loft community together.Refer a friend and get the ability to get two lofts at a time",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.015,
              ),
            ),
          ],
        )
    );
  }
}