import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loftfin/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var duration = const Duration(seconds: 2);
    Timer(duration, loadNextScreen);

    super.initState();
  }

  void loadNextScreen() async {
    Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}
