import 'package:flutter/material.dart';
import '../presentation/problem_search_screen/problem_search_screen.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String problemSearchScreen = '/problem_search_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
    problemSearchScreen: (context) => ProblemSearchScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => AppNavigationScreen(),
  };
}
