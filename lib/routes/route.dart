import 'package:care_bridge/routes/routes_name.dart';
import 'package:care_bridge/screens/homescreen.dart';
import 'package:flutter/material.dart';

class Routes{
  static Route<dynamic>generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.homescreen:
      return MaterialPageRoute(builder: (context) => const Homescreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}