import 'package:flutter/material.dart';

class Councelling extends StatefulWidget {
  const Councelling({Key? key}) : super(key: key);

  @override
  State<Councelling> createState() => _CouncellingState();
}

class _CouncellingState extends State<Councelling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get yourself a counsel"),
      ),
      body: Center(child: Container()),
    );
  }
}
