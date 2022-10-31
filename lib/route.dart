import 'package:flutter/material.dart';

import 'home.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Home.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Home(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Error 404'),
          ),
        ),
      );
  }
}
