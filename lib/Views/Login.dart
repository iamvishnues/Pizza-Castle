import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/Providers/Authentication.dart';
import 'package:pizzacastle/Views/HomePage.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200,
                    child: Lottie.asset("Assets/Animations/pizza-slice.json")),
                RichText(
                  text: TextSpan(
                      text: "Piz",
                      style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                            text: "za", style: TextStyle(color: Colors.red)),
                        TextSpan(text: " "),
                        TextSpan(
                            text: "Cast",
                            style: TextStyle(color: Colors.black87)),
                        TextSpan(
                            text: "le", style: TextStyle(color: Colors.red)),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      Provider.of<Authentication>(context, listen: true)
                          .getErrorMessage,
                      style: TextStyle(fontSize: 22, color: Colors.redAccent),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: MaterialButton(
                        color: Color(0xffffb770),
                        onPressed: () {
                          loginsheet(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: MaterialButton(
                        color: Color(0xffffb770),
                        onPressed: () {
                          signupsheet(context);
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginsheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
              ),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 5),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            hintText: "Enter Email",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 5),
                      child: TextField(
                        controller: passwordcontroller,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Enter password",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 380,
                      height: 50,
                      child: MaterialButton(
                        color: Color(0xffffb770),
                        onPressed: () {
                          Provider.of<Authentication>(context, listen: false)
                              .loginIntoAccount(
                                  emailcontroller.text, passwordcontroller.text)
                              .whenComplete(() {
                            if (Provider.of<Authentication>(context,
                                        listen: false)
                                    .getErrorMessage ==
                                "") {
                              return Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: HomePage(),
                                      type: PageTransitionType.bottomToTop));
                            }
                            if (Provider.of<Authentication>(context,
                                        listen: false)
                                    .getErrorMessage !=
                                "") {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: Login(),
                                      type: PageTransitionType.fade));
                            }
                          });
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  signupsheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
              ),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 5),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            hintText: "Enter Email",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 5),
                      child: TextField(
                        controller: passwordcontroller,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Enter password",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 380,
                      height: 50,
                      child: MaterialButton(
                        color: Color(0xffffb770),
                        onPressed: () {
                          Provider.of<Authentication>(context, listen: false)
                              .createNewAccount(
                                  emailcontroller.text, passwordcontroller.text)
                              .whenComplete(() {
                            if (Provider.of<Authentication>(context,
                                        listen: false)
                                    .getErrorMessage ==
                                "") {
                              return Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: HomePage(),
                                      type: PageTransitionType.bottomToTop));
                            }
                            if (Provider.of<Authentication>(context,
                                        listen: false)
                                    .getErrorMessage !=
                                "") {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: Login(),
                                      type: PageTransitionType.fade));
                            }
                          });
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
