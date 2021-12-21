import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loftfin/screens/register_screen.dart';
import 'package:loftfin/screens/signin_screen.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../strings.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeName = "/welcome_screen";

  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _pageController =
      PageController(viewportFraction: 0.8, keepPage: false, initialPage: 0);
  int _currentPage = 0;

  final List<String> titles = [
    kStringsWelcomeTitle1,
    kStringsWelcomeTitle2,
    kStringsWelcomeTitle3
  ];
  final List<String> subTitles = [
    kStringsWelcomeMessage1,
    kStringsWelcomeMessage2,
    kStringsWelcomeMessage3
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = List.generate(
      3,
      (index) => Column(
        children: [
          Container(
            width: size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.shade300,
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Container(
              height: size.height * 0.22,
            ),
          ),
          SizedBox(height: 10),
          Text(
            titles[index],
            style: TextStyle(
              color: AppTheme.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.8,
            child: Text(
              subTitles[index],
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textColor,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            SizedBox(
              height: 35,
              child: Image.asset(
                'assets/images/welcome_icon.png',
              ),
            ),
            Text(
              kStringsAppName,
              style: TextStyle(
                color: AppTheme.textColor,
                fontWeight: FontWeight.w800,
                fontSize: size.height * 0.035,
              ),
            ),
            SizedBox(height: 10),
            Text(
              kStringsAppSubTitle,
              style: TextStyle(
                color: AppTheme.textColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              height: size.height * 0.36,
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            SizedBox(
              height: 10,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: pages.length,
                effect: WormEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  type: WormType.thin,
                  // strokeWidth: 5,
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              title: kStringsSignIn,
              width: size.width * 0.35,
              backgroundColor: AppTheme.themeColor,
              onClick: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
              height: size.height * 0.055,
            ),
            SizedBox(height: 20),
            Text(
              kStringsNoAccount,
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              title: kStringsRegister,
              width: size.width * 0.30,
              backgroundColor: AppTheme.themeColor,
              onClick: () {
                Navigator.pushNamed(context, RegisterScreen.routeName);
              },
              height: size.height * 0.049,
            ),
            SizedBox(height: 20),
            _terms(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _terms(BuildContext context) {
    TextStyle defaultStyle = TextStyle(
      color: AppTheme.textColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
    TextStyle linkStyle = TextStyle(
      color: AppTheme.textButtonColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      // decoration: TextDecoration.underline,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            style: defaultStyle,
            children: <TextSpan>[
              TextSpan(text: kStringsLoftTerms),
              TextSpan(
                text: kStringsTerms,
                style: linkStyle,
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
