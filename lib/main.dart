import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/ResetPassword.dart';
import 'package:flutter_app_demo/Signup_page.dart';
import 'package:flutter_app_demo/user_profile.dart';
import 'package:flutter_app_demo/next_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Sweet Home: Home Cleaning Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MySecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Text(
                              'Sweet Home: Home Cleaning Tracker',
                              style: GoogleFonts.caveat(fontSize: 30, fontWeight: FontWeight.bold),
                              // TextStyle(
                              //   fontSize: 15,
                              //   fontWeight: FontWeight.bold
                              // ),
                          ),
                        )
                      ],
                    )
                ),
                const Expanded(
                  flex: 30,
                  child: Image(
                    // image: AssetImage('assets/home.jpg'),
                    image: AssetImage('assets/homelogo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top:20, bottom: 20),
                        child: Text(
                          'Login',
                            style: GoogleFonts.caveat(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                        child: TextField(
                          controller: emailController,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          style: GoogleFonts.caveat(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                        child: TextField(
                          controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                            style: GoogleFonts.caveat(),
                      ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child:
                        TextButton(
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.caveat(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResetPassword()),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 10),
                        width: 100,
                        height: 20,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)
                                  )
                              ),
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupPage()),
                            );
                          },
                        child:
                        Text(
                          'Sign up',
                          style: GoogleFonts.caveat(color: Colors.black),
                        ),
                      )
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.black)
                                    )
                                ),
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepOrangeAccent)
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                              .then((value){
                                print("Login successfully!");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                                );
                              }).catchError((error) {
                                print("Failed to login!");
                                print(error.toString());
                              });
                            },
                            child: Text('Login',
                                style: GoogleFonts.caveat(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
