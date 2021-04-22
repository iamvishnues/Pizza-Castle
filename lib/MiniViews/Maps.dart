import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzacastle/Services/ManageMaps.dart';
import 'package:pizzacastle/Views/MyCart.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 80,
            child: Stack(
              children: [
                Provider.of<GenerateMaps>(context, listen: false).fetchMaps(),
                Positioned(
                  top: 30,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white54,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: MyCart(),
                                type: PageTransitionType.topToBottom));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Provider.of<GenerateMaps>(context, listen: true)
                    .getmainAddress
                    .toString(),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
