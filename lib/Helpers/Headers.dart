import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/Views/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Headers extends ChangeNotifier {
  Widget appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Home",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      automaticallyImplyLeading: false,
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
            Navigator.pushReplacement(context,
                PageTransition(child: Login(), type: PageTransitionType.fade));
          },
        ),
      ],
    );
    //   Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Icon(FontAwesomeIcons.locationArrow),
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Container(
    //             constraints: BoxConstraints(maxWidth: 150, maxHeight: 50),
    //             child: Text(
    //               finalAddress,
    //               overflow: TextOverflow.fade,
    //               style: TextStyle(fontSize: 11),
    //             ))
    //       ],
    //     ),
    //
    //     IconButton(icon: Icon(FontAwesomeIcons.search), onPressed: () {}),
    //     SizedBox(
    //       height: 30,
    //     ),
    //
    //   ],
    // );
  }

  Widget headerText() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 80, top: 20),
      constraints: BoxConstraints(maxWidth: 250),
      child: RichText(
        text: TextSpan(
            text: "What would you like \n ",
            style: TextStyle(color: Colors.black, fontSize: 25),
            children: <TextSpan>[
              TextSpan(
                  text: "to eat ?",
                  style: TextStyle(
                      color: Colors.green.shade600,
                      fontSize: 40,
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
            child: Text("Pasta"),
          ),
        ))
      ],
    );
  }
}
