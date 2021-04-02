import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: HomePage(),
                type: PageTransitionType.leftToRightWithFade)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset(
              "Assets/Animations/pizza-slice.json",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
                text: "Piz",
                style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 27,
                    fontWeight: FontWeight.w600),
                children: [
                  TextSpan(text: "za", style: TextStyle(color: Colors.red)),
                  TextSpan(text: " "),
                  TextSpan(
                      text: "Cast", style: TextStyle(color: Colors.black87)),
                  TextSpan(text: "le", style: TextStyle(color: Colors.red)),
                ]),
          ),
        ],
      ),
    );
  }
}
