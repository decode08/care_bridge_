import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CommunityFeed extends StatefulWidget {

  CommunityFeed();

  @override
  State<CommunityFeed> createState() => _CommunityFeedState();
}

final postList = [Colors.pink.shade200, Colors.lightBlue.shade200, Colors.pink.shade200, Colors.lightBlue.shade200];
int count = 0;

@override
class _CommunityFeedState extends State<CommunityFeed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts",style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back, color: Colors.black,

              )),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: postList.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  color: postList[index],
                  child: Container(
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'lib/assets/photo1.jpg',
                            width: 250,
                            height: 200,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color:Colors.red),
                            Text("by Aakash Kaamra", style: TextStyle(color: Colors.black)),

                          ],
                        )

                      ],
                    )

                  ),
                ),
              );
            }));
  }
}
