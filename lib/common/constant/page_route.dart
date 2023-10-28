import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oh_dog_app/common/constant/route_constant.dart';
import 'package:oh_dog_app/presentation/screens/dashboard/dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLiterals.dashboard:
        return CupertinoPageRoute(
            builder: (_) => DashBoardScreen(),
            settings: RouteSettings(name: settings.name));

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route specified for ${settings.name}'),
                  ),
                ));
    }
  }
}
