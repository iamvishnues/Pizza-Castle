import 'package:flutter/material.dart';
import 'package:pizzacastle/Services/ManageData.dart';
import 'package:pizzacastle/Services/ManageMaps.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHelper extends ChangeNotifier {
  TimeOfDay deliveryTiming = TimeOfDay.now();
  bool showCheckoutButton = false;
  bool get getShowCheckButton => showCheckoutButton;
  Future selectTime(BuildContext context) async {
    final selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null && selectedTime != deliveryTiming) {
      deliveryTiming = selectedTime;
      print("<<<<<<<<<<<<<<<<<////////////////////////////////");
      print(deliveryTiming.format(context));
      notifyListeners();
    }
  }

  showCheckoutButtonMethod() {
    showCheckoutButton = true;
    notifyListeners();
  }

  selectLocation(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: 550,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: Text(
                      "Location: ${Provider.of<GenerateMaps>(context, listen: true).getmainAddress}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  child: Provider.of<GenerateMaps>(context, listen: false)
                      .fetchMaps(),
                  height: 480,
                )
              ],
            ),
          );
        });
  }

  handlePaymentSucess(
      BuildContext context, PaymentSuccessResponse paymentSuccessResponse) {
    return showResponse(context, paymentSuccessResponse.paymentId);
  }

  handlePaymentError(
      BuildContext context, PaymentFailureResponse paymentFailureResponse) {
    return showResponse(context, paymentFailureResponse.message);
  }

  handleExternalWallet(
      BuildContext context, ExternalWalletResponse externalWalletResponse) {
    return showResponse(context, externalWalletResponse.walletName);
  }

  showResponse(BuildContext context, String response) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Text(
              response,
              style: TextStyle(fontSize: 18),
            ),
          );
        });
  }
}
