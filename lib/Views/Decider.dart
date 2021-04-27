import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/AdminPanel/Views/LoginPage.dart';
import 'package:pizzacastle/Views/Login.dart';

class Decider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                  height: 250, child: Image.asset("Assets/Images/decider.png")),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                  child: RichText(
                text: TextSpan(
                    text: "Pizz",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: "za", style: TextStyle(color: Colors.red)),
                      TextSpan(text: " "),
                      TextSpan(
                          text: "Cast",
                          style: TextStyle(color: Colors.black87)),
                      TextSpan(
                          text: "le\n", style: TextStyle(color: Colors.red)),
                      TextSpan(
                        text: "Choose your ",
                        style: TextStyle(
                            color: Colors.yellow.shade800, fontSize: 25),
                      ),
                      TextSpan(
                        text: "Role",
                        style: TextStyle(color: Colors.redAccent, fontSize: 27),
                      )
                    ]),
              )),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height - 40,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pizza Castle",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black38,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "All copyrigths reserved 2021 ",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black38,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                )),
            Positioned(
              top: MediaQuery.of(context).size.height - 110,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Login(),
                                type: PageTransitionType.bottomToTop));
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            "User",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: AdminLogin(),
                                type: PageTransitionType.bottomToTop));
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            "Admin",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
