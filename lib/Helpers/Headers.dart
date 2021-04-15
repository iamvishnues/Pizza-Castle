import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Headers extends ChangeNotifier {
  Widget appBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(FontAwesomeIcons.userAlt),
            Row(
              children: [
                Icon(FontAwesomeIcons.locationArrow),
                Text("Nehrunagara")
              ],
            ),
            IconButton(icon: Icon(FontAwesomeIcons.search), onPressed: () {}),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget headerText() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 80, top: 10),
      constraints: BoxConstraints(maxWidth: 250),
      child: RichText(
        text: TextSpan(
            text: "What would you like \n ",
            style: TextStyle(color: Colors.black, fontSize: 22),
            children: <TextSpan>[
              TextSpan(
                  text: "to eat ?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ]),
      ),
    );
  }

  Widget headerMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 100,
        ),
        GestureDetector(
            child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Color(0xFFf2a154), blurRadius: 20)],
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.grey.shade100),
          height: 40,
          width: 90,
          child: Center(
            child: Text("All Food"),
          ),
        )),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
            child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Color(0xFFf2a154), blurRadius: 20)],
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.grey.shade100),
          height: 40,
          width: 90,
          child: Center(
            child: Text("Pizza"),
          ),
        )),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
            child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Color(0xFFf2a154), blurRadius: 20)],
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.grey.shade100),
          height: 40,
          width: 90,
          child: Center(
            child: Text("pasta"),
          ),
        ))
      ],
    );
  }
}
