import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzacastle/Helpers/Footer.dart';
import 'package:pizzacastle/Helpers/Headers.dart';
import 'package:pizzacastle/Helpers/Middle.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Footers().floatingActionButton(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headers().appBar(context),
              Headers().headerText(),
              Headers().headerMenu(context),
              MiddleHelpers().textFav(),
              MiddleHelpers().dataFav(context, "favourite"),
              MiddleHelpers().textBusiness(),
              MiddleHelpers().dataBusiness(context, "business"),
            ],
          ),
        ),
      ),
    );
  }
}
