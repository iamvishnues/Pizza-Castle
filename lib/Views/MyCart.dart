import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/MiniViews/Maps.dart';
import 'package:pizzacastle/Providers/API_key.dart';
import 'package:pizzacastle/Providers/Authentication.dart';
import 'package:pizzacastle/Providers/Payment.dart';
import 'package:pizzacastle/Services/ManageData.dart';
import 'package:pizzacastle/Services/ManageMaps.dart';
import 'package:pizzacastle/Views/HomePage.dart';
import 'package:pizzacastle/Views/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Razorpay razorpay;
  String total = "320";
  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        Provider.of<PaymentHelper>(context, listen: false).handlePaymentSucess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        Provider.of<PaymentHelper>(context, listen: false).handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        Provider.of<PaymentHelper>(context, listen: false)
            .handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  Future checkMeOut() async {
    var options = {
      "key": API_Key,
      "amount": total,
      "name": Provider.of<Authentication>(context, listen: false)
                  .getUserEmail ==
              null
          ? userEmail
          : Provider.of<Authentication>(context, listen: false).getUserEmail,
      "description": "Payment",
      "prefill": {
        "contact": "9864532890",
        "email": Provider.of<Authentication>(context, listen: false)
                    .getUserEmail ==
                null
            ? userEmail
            : Provider.of<Authentication>(context, listen: false).getUserEmail,
      },
      "external": {
        "wallet": ["paytm"]
      },
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: floatingActionButton(),
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
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  "Assets/Images/space.png",
                ))),
              )
              // shippingDetails(context),
              // billingData()
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
                  size: 22,
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
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget cartData() {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 280,
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
                    child: GestureDetector(
                      onLongPress: () {
                        PlaceOrder(context, documentSnapshot);
                      },
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
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Image.network(
                                    documentSnapshot.data()["image"]),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    documentSnapshot.data()["name"],
                                    overflow: TextOverflow.ellipsis,
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

  PlaceOrder(BuildContext context, DocumentSnapshot documentSnapshot) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 160, vertical: 2),
                  child: Divider(
                    thickness: 4,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 30,
                            child: Text(
                              "Time: ${Provider.of<PaymentHelper>(context, listen: true).deliveryTiming.format(context)}",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 80,
                            child: Text(
                              "Location: ${Provider.of<GenerateMaps>(context, listen: true).getmainAddress}",
                              style: TextStyle(fontSize: 18),
                            )),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                        child: Icon(FontAwesomeIcons.clock),
                        onPressed: () {
                          Provider.of<PaymentHelper>(context, listen: false)
                              .selectTime(context);
                        }),
                    FloatingActionButton(
                        child: Icon(Icons.location_on),
                        onPressed: () {
                          Provider.of<PaymentHelper>(context, listen: false)
                              .selectLocation(context);
                        }),
                    FloatingActionButton(
                        child: Icon(FontAwesomeIcons.rupeeSign),
                        onPressed: () async {
                          await checkMeOut().whenComplete(() {
                            Provider.of<PaymentHelper>(context, listen: false)
                                .showCheckoutButtonMethod();
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 150,
                ),
                Provider.of<PaymentHelper>(context, listen: false)
                        .showCheckoutButton
                    ? MaterialButton(
                        color: Colors.redAccent,
                        child: Text("Place order",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("adminCollections")
                              .add({
                            "username": Provider.of<Authentication>(context,
                                            listen: false)
                                        .getUserEmail ==
                                    null
                                ? userEmail
                                : Provider.of<Authentication>(context,
                                        listen: false)
                                    .getUserEmail,
                            "image": documentSnapshot.data()["image"],
                            "pizza": documentSnapshot.data()["name"],
                            "price": documentSnapshot.data()["price"],
                            "time": Provider.of<PaymentHelper>(context,
                                    listen: false)
                                .deliveryTiming
                                .format(context),
                            "location": Provider.of<GenerateMaps>(context,
                                    listen: false)
                                .getmainAddress,
                            "size": documentSnapshot.data()["size"],
                            "onion": documentSnapshot.data()["onion"],
                            "cheese": documentSnapshot.data()["cheese"],
                            "oliver": documentSnapshot.data()["oliver"],
                          });
                        },
                      )
                    : Container()
              ],
            ),
          );
        });
  }
}
