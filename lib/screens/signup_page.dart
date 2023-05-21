import 'package:flutter/material.dart';

import 'home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: SafeArea(child:
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.blueAccent.shade100,
              ],
            )
        ),
        child: Column(

          children: [
            const SizedBox(
              height: 50,
              width: 100,
            ),
            Image.asset(
              'lib/assets/logo (2).png',
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 50,
              width: 100,
            ),
            Text("SignUp", style: TextStyle(color: Colors.black, fontSize: 40)),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Hope you\'re doing great',
              style: TextStyle(
                color: Colors.blue.shade800,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(

                //  controller: usernameController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.black),


                ),

              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                //controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black),

                ),

              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                //controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Re-enter Password",
                  hintStyle: TextStyle(color: Colors.black),

                ),

              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
                child: IconButton(icon: Icon(Icons.arrow_circle_right, color: Colors.green, size: 40.0,),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => HomePage())));
                  },)),



          ],
        ),
      ),
      ),

    );
  }
}

