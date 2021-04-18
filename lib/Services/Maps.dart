import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoco;
import 'package:geolocator/geolocator.dart';

String finalAddress = "Searching...";

class GenerateMaps extends ChangeNotifier {
  Position position;

  Future getCurrentLocation() async {
    var positionData = await GeolocatorPlatform.instance.getCurrentPosition();
    final cords =
        await geoco.Coordinates(positionData.latitude, positionData.longitude);
    var address =
        await geoco.Geocoder.local.findAddressesFromCoordinates(cords);
    String mainAddress = address.first.addressLine;
    print(mainAddress);
    finalAddress = mainAddress;
    notifyListeners();
  }
}
