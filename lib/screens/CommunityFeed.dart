import 'dart:io';

import 'package:care_bridge_ui/screens/form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommunityFeed extends StatefulWidget {
  CommunityFeed();

  @override
  State<CommunityFeed> createState() => _CommunityFeedState();
}

final postList = [
  Colors.lightBlueAccent.shade100,
  Colors.yellowAccent.shade100,
];
int count = 0;

@override
class _CommunityFeedState extends State<CommunityFeed> {
  String downloadUrl = "";
  _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile1 = File(pickedFile.path);
      // img(imageFile1);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EForm(File(imageFile1.path))));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CommunityFeed()));
    }
  }

  _selectFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile2 = File(pickedFile.path);
      // img(imageFile2);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EForm(File(imageFile2.path))));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CommunityFeed()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Center(
                          child: Container(
                            height: 250,
                            child: AlertDialog(
                              title: Text("Select one"),
                              content: Column(
                                children: [
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Take photo",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    onTap: () {
                                      _selectFromCamera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Choose from Gallery",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    onTap: () {
                                      _getFromGallery();
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              )),
        ],
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (context.mounted) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data!.docs[index];
                String url = data['downloadURL'];
                String description = data['description'];

                return ListTile(
                  title: Image.network(url,
                      width: 300, height: 300, fit: BoxFit.cover),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("$description",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(Icons.share, size: 20),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            //  if (!snapshot.hasData) {
            return (SnackBar(content: Text("Select a picture")));
            //  }
          }
        },
      ),
    );
  }
}
