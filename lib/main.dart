import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:loftfin/services/service_locator.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    name: 'dev',
    color: Colors.green,
    location: BannerLocation.bottomStart,
    variables: {
      'dev': 'dev',
      'BASE_URL':
          'http://ec2-44-201-64-80.compute-1.amazonaws.com:8980/api/loftfin/v1/',
    },
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    setupLocator();
    runApp(
      MyApp(),
    );
  });
}
