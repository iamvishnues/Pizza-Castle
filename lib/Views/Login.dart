import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Container(
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
                          text: "Cast",
                          style: TextStyle(color: Colors.black87)),
                      TextSpan(text: "le", style: TextStyle(color: Colors.red)),
                    ]),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: Color(0xffffb770),
                    onPressed: () {
                      loginsheet(context);
                    },
                    child: Text("Login"),
                  ),
                  MaterialButton(
                    color: Color(0xffffb770),
                    onPressed: () {
                      signupsheet(context);
                    },
                    child: Text("Signup"),
                  )
                ],
              )
            ],
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
                      height: 10,
                    ),
                    MaterialButton(
                      color: Color(0xffffb770),
                      onPressed: () {
                        Provider.of<Authentication>(context, listen: false)
                            .loginIntoAccount(
                                emailcontroller.text, passwordcontroller.text)
                            .whenComplete(() {
                          return Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: HomePage(),
                                  type: PageTransitionType.bottomToTop));
                        });
                      },
                      child: Text("Login"),
                    )
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
                      height: 10,
                    ),
                    MaterialButton(
                      color: Color(0xffffb770),
                      onPressed: () {
                        Provider.of<Authentication>(context, listen: false)
                            .createNewAccount(
                                emailcontroller.text, passwordcontroller.text)
                            .whenComplete(() {
                          return Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: HomePage(),
                                  type: PageTransitionType.bottomToTop));
                        });
                      },
                      child: Text("Signup"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
