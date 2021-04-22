import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/MiniViews/Maps.dart';
import 'package:pizzacastle/Services/ManageData.dart';
import 'package:pizzacastle/Services/ManageMaps.dart';
import 'package:pizzacastle/Views/HomePage.dart';
import 'package:pizzacastle/Views/SplashScreen.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context),
              headerText(),
              cartData(),
              shippingDetails(context),
              billingData()
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: HomePage(),
                          type: PageTransitionType.topToBottom));
                }),
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.trash,
                  size: 16,
                ),
                onPressed: () {
                  Provider.of<ManageData>(context, listen: false)
                      .deleteData(context);
                })
          ],
        ),
      ),
    );
  }

  Widget headerText() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          Text("My",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Text("Cart",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget cartData() {
    return SizedBox(
        height: 280,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("myorders").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset("Assets/Animations/loading.json"));
            } else {
              return ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 2,
                                spreadRadius: 3)
                          ]),
                      height: 220,
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              child: Image.network(
                                  documentSnapshot.data()["image"]),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  documentSnapshot.data()["name"],
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Price ${documentSnapshot.data()['price']}",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Cheese: ${documentSnapshot.data()['cheese']}",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Onion: ${documentSnapshot.data()['onion']}",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Oliver: ${documentSnapshot.data()['oliver']}",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    child: Text(
                                      "${documentSnapshot.data()['size']}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ));
  }

  Widget shippingDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Container(
        margin: EdgeInsets.only(top: 2, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300, blurRadius: 2, spreadRadius: 3)
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 130,
        width: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(FontAwesomeIcons.locationArrow),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                            constraints: BoxConstraints(maxWidth: 250),
                            child: Text(
                              Provider.of<GenerateMaps>(context, listen: true)
                                  .getmainAddress
                                  .toString(),
                            )),
                      )
                    ],
                  ),
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Maps(),
                                type: PageTransitionType.topToBottom));
                      }),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(EvaIcons.clock),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: Text("6PM-8PM")),
                    )
                  ],
                ),
                IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget billingData() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Container(
        margin: EdgeInsets.only(top: 20, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300, blurRadius: 2, spreadRadius: 3)
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,

            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sub total",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.rupeeSign,
                        size: 14,
                      ),
                      Text("300.0",
                          style: TextStyle(
                            fontSize: 18,
                          ))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery Charges",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.rupeeSign,
                        size: 14,
                      ),
                      Text("20.0",
                          style: TextStyle(
                            fontSize: 18,
                          ))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.rupeeSign,
                        size: 14,
                      ),
                      Text("320.0",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget floatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            print(userUid);
          },
          child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "Place order",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
