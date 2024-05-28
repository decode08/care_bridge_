import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.pinkAccent.shade100,
              ],
            )),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Image.asset(
                    'lib/assets/logo (2).png',
                    width: 150,
                    height: 330,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45.0),
                  child: Text(
                    "CARE\nBRIDGE",
                    style: TextStyle(color: Colors.black, fontSize: 38),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Text(
                    "Your Doctor",
                    style: TextStyle(fontSize: 18),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text("Dr Ashish Malhotra"),
                    subtitle: Text("Physiotherapist"),
                    trailing: Icon(Icons.medical_information),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white,
                    Colors.yellow.shade500,
                  ],
                )),
                child: Center(child: Text("No therapy Scheduled for today")),
              ),
            ),
          )
        ],
      )),
    );
  }
}
