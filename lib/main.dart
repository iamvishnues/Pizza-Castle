import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:pizzacastle/Helpers/Headers.dart';
import 'package:pizzacastle/Helpers/Middle.dart';
import 'package:pizzacastle/Services/ManageData.dart';
import 'package:pizzacastle/Views/SplashScreen.dart';
import 'package:pizzacastle/Helpers/Footer.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Headers()),
        ChangeNotifierProvider.value(value: MiddleHelpers()),
        ChangeNotifierProvider.value(value: ManageData()),
        ChangeNotifierProvider.value(value: Footers()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: SplashScreen(),
      ),
    );
  }
}
