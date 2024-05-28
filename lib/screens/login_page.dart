import 'package:care_bridge_ui/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signUSerIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBar(
          content: Text('No user found '),
        );
      } else if (e.code == 'wrong-password') {
        SnackBar(
          content: Text('Wrong Password'),
        );
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.blueAccent.shade100,
            ],
          )),
          child: SingleChildScrollView(
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
                Text("Login",
                    style: TextStyle(color: Colors.black, fontSize: 40)),
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
                    controller: emailController,
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
                    controller: passwordController,
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
                Center(
                    child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_right,
                    color: Colors.green,
                    size: 40.0,
                  ),
                  onPressed: () {
                    signUSerIn();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: ((context) => HomePage())));
                  },
                )),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    child: Text(
                      "Don't have account?",
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SignupPage())));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
