import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/AdminPanel/Views/AdminHomePage.dart';
import 'package:pizzacastle/Providers/Authentication.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 80,
              left: 10,
              right: 10,
              child: Image.asset("Assets/Images/admin.png")),
          Positioned(
              top: 350,
              left: 10,
              child: Provider.of<Authentication>(context, listen: true)
                          .getErrorMessage ==
                      ""
                  ? Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                          child: RichText(
                        text: TextSpan(
                            text: "Pizz",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: "za",
                                  style: TextStyle(color: Colors.red)),
                              TextSpan(text: " "),
                              TextSpan(
                                  text: "Cast",
                                  style: TextStyle(color: Colors.black87)),
                              TextSpan(
                                  text: "le\n",
                                  style: TextStyle(color: Colors.red)),
                              TextSpan(
                                text: "Admin ",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 25),
                              ),
                              TextSpan(
                                text: "Arena",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 27),
                              )
                            ]),
                      )),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text(
                        Provider.of<Authentication>(context, listen: true)
                            .getErrorMessage,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
          Positioned(
            top: MediaQuery.of(context).size.height - 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      loginsheet(context);
                    },
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Login",
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
                      signupsheet(context);
                    },
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Signup",
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
          Positioned(
              top: MediaQuery.of(context).size.height - 40,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By continuing you agree to Pizza Castle's terms",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black38,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Services & Privacy policy",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black38,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              )),
        ],
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
                color: Color(0xFFE6E6EA),
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
                            hintStyle: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 5),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 380,
                      height: 50,
                      child: FloatingActionButton(
                          // backgroundColor: Color(0xFFf2a154),
                          backgroundColor: Colors.blue.shade900,
                          onPressed: () {
                            Provider.of<Authentication>(context, listen: false)
                                .loginIntoAccount(emailcontroller.text,
                                    passwordcontroller.text)
                                .whenComplete(() {
                              if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .getErrorMessage ==
                                  "") {
                                return Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: AdminHomePage(),
                                        type: PageTransitionType.bottomToTop));
                              }
                              if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .getErrorMessage !=
                                  "") {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: AdminLogin(),
                                        type: PageTransitionType.fade));
                              }
                            });
                          },
                          child: Icon(
                            EvaIcons.logIn,
                            size: 35,
                          )),
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
                color: Color(0xFFE7E6EC),
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
                            hintStyle: TextStyle(
                              fontSize: 14,
                            )),
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
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 380,
                      height: 50,
                      child: FloatingActionButton(
                          // backgroundColor: Color(0xFFf2a154),
                          backgroundColor: Colors.blue.shade900,
                          onPressed: () {
                            Provider.of<Authentication>(context, listen: false)
                                .createNewAccount(emailcontroller.text,
                                    passwordcontroller.text)
                                .whenComplete(() {
                              if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .getErrorMessage ==
                                  "") {
                                return Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: AdminHomePage(),
                                        type: PageTransitionType.bottomToTop));
                              }
                              if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .getErrorMessage !=
                                  "") {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: AdminLogin(),
                                        type: PageTransitionType.fade));
                              }
                            });
                          },
                          child: Icon(FontAwesomeIcons.check)),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
