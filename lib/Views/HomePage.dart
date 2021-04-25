import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzacastle/Helpers/Footer.dart';
import 'package:pizzacastle/Helpers/Headers.dart';
import 'package:pizzacastle/Helpers/Middle.dart';
import 'package:pizzacastle/Services/ManageMaps.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // Provider.of<GenerateMaps>(context, listen: true).getCurrentLocation();
    Provider.of<GenerateMaps>(context, listen: false).getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Footers().floatingActionButton(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 0, bottom: 10),
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
