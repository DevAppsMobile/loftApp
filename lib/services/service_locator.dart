import 'package:get_it/get_it.dart';

import 'navigation_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerSingleton<NavigationService>(NavigationService());
}
