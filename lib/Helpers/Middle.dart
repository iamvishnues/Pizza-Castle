import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzacastle/Services/ManageData.dart';
import 'package:provider/provider.dart';

class MiddleHelpers extends ChangeNotifier {
  Widget textFav() {
    return Container(
      margin: EdgeInsets.only(left: 10),
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
                  child: Lottie.asset("Assets/Animations/loading.json"),
                );
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
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 300,
                          width: 220,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
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
                                    child: Image.network(
                                        snapshot.data[index].data()['image']),
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
                                  style:
                                      TextStyle(color: Colors.indigo.shade800),
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
}
