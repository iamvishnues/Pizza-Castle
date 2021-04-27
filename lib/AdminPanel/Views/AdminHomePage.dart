import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/AdminPanel/Services/AdminDetailsHelper.dart';
import 'package:pizzacastle/AdminPanel/Views/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: Drawer(),
      appBar: appBar(context),
      body: SafeArea(
        child: Container(
          child: RefreshIndicator(
            onRefresh: () async {
              print("Woooooooooooooooooooooorking refresh");
            },
            child: Stack(
              children: [dateChips(context), orderData(context)],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.redAccent,
      title: Text(
        "Orders",
        style: TextStyle(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            EvaIcons.logOut,
            size: 35,
          ),
          onPressed: () async {
            SharedPreferences sharedPreference =
                await SharedPreferences.getInstance();
            sharedPreference.remove('uid');
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: AdminLogin(), type: PageTransitionType.fade));
          },
        ),
      ],
    );
  }

  Widget dateChips(BuildContext context) {
    return Positioned(
      top: 50,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionChip(
              label: Text("Today"),
              onPressed: () {},
            ),
            ActionChip(
              label: Text("This Week"),
              onPressed: () {},
            ),
            ActionChip(
              label: Text("This Month"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget orderData(BuildContext context) {
    return Positioned(
        top: 120,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 350,
            width: 350,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("adminCollections")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SizedBox(
                          width: 150,
                          child:
                              Lottie.asset("Assets/Animations/loading.json")));
                } else {
                  return ListView(
                    children: snapshot.data.docs
                        .map((DocumentSnapshot documentSnapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 8, bottom: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 2,
                                    spreadRadius: 3)
                              ]),
                          child: ListTile(
                            onTap: () {
                              Provider.of<AdminDetailsHelper>(context,
                                      listen: false)
                                  .detailSheet(context, documentSnapshot);
                            },
                            trailing: IconButton(
                              icon: Icon(FontAwesomeIcons.magnet),
                              onPressed: () {},
                            ),
                            title: Text(
                              documentSnapshot.data()["pizza"],
                              style: TextStyle(fontSize: 13),
                            ),
                            subtitle: Container(
                              child: Text(
                                documentSnapshot.data()["location"],
                                style: TextStyle(fontSize: 9),
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  documentSnapshot.data()["image"]),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ));
  }

  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(FontAwesomeIcons.check),
    );
  }
}
