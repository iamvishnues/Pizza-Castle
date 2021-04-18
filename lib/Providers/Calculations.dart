import 'package:flutter/material.dart';
import 'package:pizzacastle/Services/ManageData.dart';
import 'package:provider/provider.dart';

class calculations with ChangeNotifier {
  int cheeseValue = 0;
  int onionValue = 0;
  int oliverValue = 0;
  int cartData = 0;
  String size;
  String get getSize => size;
  bool isSelected = false,
      smallTapped = false,
      mediumTapped = false,
      largeTapped = false,
      selected = false;

  int get getcheeseValue => cheeseValue;

  int get getonionValue => onionValue;

  int get getoliverValue => oliverValue;

  int get getcartData => cartData;

  bool get getselected => selected;

  addCheese() {
    cheeseValue++;
    notifyListeners();
  }

  addOnion() {
    onionValue++;
    notifyListeners();
  }

  addOlivers() {
    oliverValue++;
    notifyListeners();
  }

  minusCheese() {
    cheeseValue--;
    notifyListeners();
  }

  minusOnion() {
    onionValue--;
    notifyListeners();
  }

  minusOlivers() {
    oliverValue--;
    notifyListeners();
  }

  selectSmallSize() {
    smallTapped = true;
    size = "S";
    notifyListeners();
  }

  selectMediumSize() {
    mediumTapped = true;
    size = "M";
    notifyListeners();
  }

  selectLargeSize() {
    largeTapped = true;
    size = "L";
    notifyListeners();
  }

  removeAllData() {
    cheeseValue = 0;
    onionValue = 0;
    oliverValue = 0;
    smallTapped = false;
    mediumTapped = false;
    largeTapped = false;
    notifyListeners();
  }

  addToCart(BuildContext context, dynamic data) async {
    if (smallTapped != false || mediumTapped != false || largeTapped != false) {
      cartData++;
      await Provider.of<ManageData>(context, listen: false)
          .submitData(context, data);
      notifyListeners();
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 50,
              child: Center(child: Text("Please select the size")),
            );
          });
    }
  }
}
