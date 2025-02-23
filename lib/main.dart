import 'package:care_bridge/res/color.dart';
import 'package:care_bridge/routes/route.dart';
import 'package:care_bridge/routes/routes_name.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.generalColor),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.homescreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}


 