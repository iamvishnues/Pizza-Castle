import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/Views/HomePage.dart';

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
                onPressed: () {})
          ],
        ),
      ),
    );
  }

  Widget headerText() {
    return Column(
      children: [
        Text("Your",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        Text("Cart",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget cartData() {
    return SizedBox(
      height: 300,
    );
  }

  Widget shippingDetails(BuildContext context) {
    return Container(
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
                          child: Text("Nehrunagara Puttur DK")),
                    )
                  ],
                ),
                IconButton(icon: Icon(Icons.edit), onPressed: () {}),
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
    );
  }

  Widget billingData() {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300, blurRadius: 2, spreadRadius: 3)
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: 170,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget floatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {},
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
