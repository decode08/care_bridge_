

import 'package:care_bridge_ui/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CommunityFeed.dart';
import 'councelling.dart';
import 'home.dart';
import 'login_page.dart';
import 'mood.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    Mood(),
   Councelling(),
    Profile(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home(); // Our first view in viewport

  final currentUser =FirebaseAuth.instance.currentUser!;

  void signUserOut(){
  //FirebaseAuth.instance.signOut();
  // Navigator.push(context,
  // MaterialPageRoute(builder: ((context) =>LoginPage())));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed:
      signUserOut, icon: Icon(Icons.logout),)],),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade200,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => CommunityFeed())));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Home(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Colors.pink.shade200
                              : Colors.blue.shade200,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.pink.shade200
                                  : Colors.blue.shade200,),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Mood(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.contactless_sharp,
                            color: currentTab == 1
                                ?Colors.pink.shade200
                                : Colors.blue.shade200,),
                        Text(
                          'Mood',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.pink.shade200
                                  : Colors.blue.shade200,),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Councelling(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.document_scanner,
                            color: currentTab == 2
                                ? Colors.pink.shade200
                                : Colors.blue.shade200),
                        Text(
                          'Councelling',
                          style: TextStyle(
                              color: currentTab == 2
                                  ? Colors.pink.shade200
                                  : Colors.blue.shade200,

                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Profile(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person,
                            color: currentTab == 3
                                ? Colors.pink.shade200
                                : Colors.blue.shade200,),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.pink.shade200
                                  : Colors.blue.shade200,),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
