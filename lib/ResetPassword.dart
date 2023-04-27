import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_demo/Reusuable_widget.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.grey),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(top:20, bottom: 20),
                        width: 120,
                        height: 50,
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
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          child:
                          Text(
                            'Go back to Login',
                            style: GoogleFonts.caveat(color: Colors.black),
                          ),
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:20, bottom: 20),
                      child: Text(
                        'Enter your email to reset your password',
                        style: GoogleFonts.caveat(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Reset Password", () {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailTextController.text)
                          .then((value) => Navigator.of(context).pop());
                    })
                  ],
                ),
              )
          )),
    );
  }
}