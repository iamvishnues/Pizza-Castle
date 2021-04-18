import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:pizzacastle/Views/DetailScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/Services/ManageData.dart';
import 'package:provider/provider.dart';

class MiddleHelpers extends ChangeNotifier {
  Widget textFav() {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10),
      child: RichText(
          text: TextSpan(
              text: "Favourite ",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              children: <TextSpan>[
            TextSpan(
                text: "Dishes",
                style: TextStyle(fontSize: 22, color: Colors.black54))
          ])),
    );
  }

  Widget dataFav(BuildContext context, String collection) {
    return Container(
        height: 320,
        child: FutureBuilder(
            future: Provider.of<ManageData>(context, listen: false)
                .fetchData(collection),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Center(
                  child: SizedBox(
                      width: 150,
                      child: Lottie.asset("Assets/Animations/loading.json")),
                ));
              }
              // print(
              //     "<<<<<<<<<<<<<<<<<<<<<<<<<<>.....................................");
              // print(snapshot);
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: DetailScreen(
                                indexx: index,
                                queryDocumentSnapshot: snapshot.data[index],
                              ),
                              type: PageTransitionType.bottomToTop),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 300,
                          width: 220,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 2,
                                    spreadRadius: 3)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 180,
                                    width: 220,
                                    child: Hero(
                                      tag: "tag$index",
                                      child: Image.network(
                                          snapshot.data[index].data()['image']),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: IconButton(
                                        icon: Icon(
                                          EvaIcons.heart,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  snapshot.data[index].data()["name"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  snapshot.data[index].data()["category"],
                                  style: TextStyle(
                                      color: Colors.indigo.shade800,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          EvaIcons.star,
                                          color: Colors.yellow.shade700,
                                        ),
                                        Text(snapshot.data[index]
                                            .data()["ratings"])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.rupeeSign,
                                          size: 14,
                                        ),
                                        Text(
                                          snapshot.data[index].data()["price"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }

  Widget textBusiness() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 10, top: 20),
      child: RichText(
          text: TextSpan(
              text: "Business ",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              children: <TextSpan>[
            TextSpan(
                text: "Lunch",
                style: TextStyle(fontSize: 22, color: Colors.black54))
          ])),
    );
  }

  Widget dataBusiness(BuildContext context, String collection) {
    return Container(
      height: 400,
      child: FutureBuilder(
        future: Provider.of<ManageData>(context, listen: false)
            .fetchData(collection),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                  width: 150,
                  child: Lottie.asset("Assets/Animations/loading.json")),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 18.0, left: 8.0, right: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 2,
                                spreadRadius: 3)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: Text(
                                    snapshot.data[index].data()["name"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Text(snapshot.data[index].data()["category"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.indigo.shade800)),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                    "₹ " +
                                        snapshot.data[index].data()["notPrice"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                        decorationThickness: 2)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.rupeeSign,
                                      size: 14,
                                    ),
                                    Text(snapshot.data[index].data()["price"],
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 2, top: 5, bottom: 5),
                            child: SizedBox(
                              height: 150,
                              child: Image.network(
                                  snapshot.data[index].data()["image"]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
