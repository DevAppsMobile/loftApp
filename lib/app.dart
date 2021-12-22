import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loftfin/providers/local_auth_provider.dart';
import 'package:loftfin/providers/signin_provider.dart';
import 'package:loftfin/screens/local_auth_screen.dart';
import 'package:loftfin/screens/phone_verification_screen.dart';
import 'package:loftfin/screens/register_screen.dart';
import 'package:loftfin/screens/signin_screen.dart';
import 'package:loftfin/screens/splash_screen.dart';
import 'package:loftfin/screens/welcome_screen.dart';
import 'package:loftfin/services/service_locator.dart';
import 'package:provider/provider.dart';

import 'services/internet_check.dart';
import 'services/navigation_service.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
       /* if (snapshot.hasError) {
          return SomethingWentWrong();
        }*/
        // Once complete, show your application
        //if (snapshot.connectionState == ConnectionState.done) {
          return app();
        //}
        // Otherwise, show something whilst waiting for initialization to complete
       // return Loading();
      },
    );
  }

  Widget app() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => LocalAuthInProvider()),
      ],
      child: StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.WiFi,
        create: (context) {
          return ConnectivityService().connectionStatusController.stream;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: serviceLocator<NavigationService>().navigatorKey,
          title: 'LoftFin',
          supportedLocales: [
            Locale('en'),
          ],
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            LocalAuthScreen.routeName: (context) => LocalAuthScreen(),
            PhoneVerificationScreen.routeName: (context) =>
                PhoneVerificationScreen(),
            SignInScreen.routeName: (context) => SignInScreen(),
          },
          theme: ThemeData(
            primaryColor: Color(0xFF00AA07),
            backgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Center(
            child: Icon(
              Icons.error_outline_outlined,
              color: Colors.pink,
              size: 50.0,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Center(
            child: Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 50.0,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
