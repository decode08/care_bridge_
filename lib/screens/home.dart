import'package:flutter/material.dart';

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
        body:
          Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text("CARE BRIDGE", style: TextStyle(color: Colors.black, fontSize: 30)),
              ),
            Stack(
              children:[
                Image.asset(
                  'lib/assets/img.png',
                  width: 600,
                  height: 380,
                ),
                Row(
                  children:[
                    Image.asset(
                      'lib/assets/logo (2).png',
                      width: 150,
                      height: 330,
                    ),
                  ]
                )


          ]

              ),
              Container(
                height:200,
                width: 380,
                child: Card(
                  elevation: 10,
                  color: Colors.grey.shade300,
                  child: Column(
                    children: [
                      Text("Your Doctor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                      Container(
                        padding: EdgeInsets.only(top:10),
                        color: Colors.white,
                        height: 100,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
