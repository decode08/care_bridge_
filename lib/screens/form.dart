import 'dart:developer';
import 'dart:io';

import 'package:care_bridge_ui/screens/CommunityFeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EForm extends StatefulWidget {
  final File? imageFile;
  const EForm(this.imageFile);

  @override
  State<EForm> createState() => _EFormState();
}

class _EFormState extends State<EForm> {
  String downloadURL = "";
  Future uploadImage() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance.ref().child("posts.png");
    await ref.putFile(widget.imageFile!);
    downloadURL = await ref.getDownloadURL();
    log(downloadURL);

    await firebaseFirestore.collection('posts').add({
      'description': descriptionController.text,
      'downloadURL': downloadURL,
    }).whenComplete(() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommunityFeed(),
        )));

    print('Data uploaded to Firestore.');
  }

  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void postPhoto() {
    if (_formKey.currentState!.validate()) {
      log("HIIII");
      uploadImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          "Your Post",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              Image.file(widget.imageFile!,
                  width: 300, height: 300, fit: BoxFit.cover),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.topic),
                  labelText: 'Description',
                  hintText: 'Add the description of the post',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please describe your post';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    postPhoto();
                  },
                  child: Text("Submit"))
            ]),
          ),
        ),
      ),
    );
  }
}
