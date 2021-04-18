import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/Providers/Calculations.dart';
import 'package:pizzacastle/Views/HomePage.dart';
import 'package:pizzacastle/Views/MyCart.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  final int indexx;

  const DetailScreen({Key key, this.queryDocumentSnapshot, this.indexx})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int cheeseValue = 0;
  int onionValue = 0;
  int olivesValue = 0;
  int totalItems = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context),
              pizzaImage(),
              middleData(),
              footerDetails()
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                Provider.of<calculations>(context, listen: false)
                    .removeAllData();
              })
        ],
      ),
    );
  }

  Widget pizzaImage() {
    return Center(
      child: SizedBox(
        height: 280.0,
        child: Container(
          child: Hero(
              tag: "tag$widget.indexx",
              child: Image.network(widget.queryDocumentSnapshot["image"])),
          decoration: BoxDecoration(shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget middleData() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Row(
            children: [
              Icon(
                EvaIcons.star,
                color: Colors.yellow.shade800,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.queryDocumentSnapshot["ratings"]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                constraints: BoxConstraints(maxWidth: 300),
                child: Text(
                  widget.queryDocumentSnapshot["name"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                )),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.rupeeSign,
                  size: 16,
                ),
                Text(widget.queryDocumentSnapshot["price"],
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.redAccent))
              ],
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget footerDetails() {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2,
                      spreadRadius: 3)
                ],
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xfff8f1ec),
              ),
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, top: 70, bottom: 10),
                    child: Text(
                      "Add more stuff",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Cheese",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                EvaIcons.minus,
                                size: 16,
                              ),
                              onPressed: () {
                                Provider.of<calculations>(context,
                                        listen: false)
                                    .minusCheese();
                              }),
                          Text(
                            Provider.of<calculations>(context, listen: true)
                                .getcheeseValue
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          IconButton(
                              icon: Icon(
                                EvaIcons.plus,
                                size: 16,
                              ),
                              onPressed: () {
                                Provider.of<calculations>(context,
                                        listen: false)
                                    .addCheese();
                              }),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Onion",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                EvaIcons.minus,
                                size: 16,
                              ),
                              onPressed: () {
                                Provider.of<calculations>(context,
                                        listen: false)
                                    .minusOnion();
                              }),
                          Text(
                            Provider.of<calculations>(context, listen: true)
                                .getonionValue
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          IconButton(
                              icon: Icon(
                                EvaIcons.plus,
                                size: 16,
                              ),
                              onPressed: () {
                                Provider.of<calculations>(context,
                                        listen: false)
                                    .addOnion();
                              }),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Olives",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                EvaIcons.minus,
                                size: 16,
                              ),
                              onPressed: () {
                                Provider.of<calculations>(context,
                                        listen: false)
                                    .minusOlivers();
                              }),
                          Text(
                            Provider.of<calculations>(context, listen: true)
                                .getoliverValue
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          IconButton(
                              icon: Icon(
                                EvaIcons.plus,
                                size: 16,
                              ),
                              onPressed: () {
                                Provider.of<calculations>(context,
                                        listen: false)
                                    .addOlivers();
                              }),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<calculations>(context, listen: false)
                      .selectSmallSize();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Provider.of<calculations>(context, listen: true)
                              .smallTapped
                          ? Colors.white
                          : Color(0xfffaac61),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      "S",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<calculations>(context, listen: false)
                      .selectMediumSize();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Provider.of<calculations>(context, listen: true)
                              .mediumTapped
                          ? Colors.white
                          : Color(0xfffaac61),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      "M",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<calculations>(context, listen: false)
                      .selectLargeSize();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Provider.of<calculations>(context, listen: true)
                              .largeTapped
                          ? Colors.white
                          : Color(0xfffaac61),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      "L",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget floatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<calculations>(context, listen: false)
                .addToCart(context, {
              'image': widget.queryDocumentSnapshot["image"],
              'name': widget.queryDocumentSnapshot["name"],
              'price': widget.queryDocumentSnapshot["price"],
              'onion': Provider.of<calculations>(context, listen: false)
                  .getonionValue,
              'cheese': Provider.of<calculations>(context, listen: false)
                  .getcheeseValue,
              'oliver':
                  Provider.of<calculations>(context, listen: false).oliverValue,
              'size': Provider.of<calculations>(context, listen: false).getSize,
            });
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
                "Add to cart",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              )),
            ),
          ),
        ),
        Stack(
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: MyCart(), type: PageTransitionType.bottomToTop));
              },
              child: Icon(EvaIcons.shoppingCart),
            ),
            Positioned(
                left: 35,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                  child: Text("$totalItems"),
                ))
          ],
        )
      ],
    );
  }
}
