import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoco;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String finalAddress = "Searching...";

class GenerateMaps extends ChangeNotifier {
  Position position;
  Position get getPosition => position;
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String countryName, mainAddress = "";
  String get getcountryName => countryName;
  String get getmainAddress => mainAddress;
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

  getMarkers(double lat, double lng) {
    MarkerId markerId = MarkerId(lat.toString() + lng.toString());
    Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: "My  Title", snippet: "Country Name"));
    markers[markerId] = marker;
  }

  Widget fetchMaps() {
    // getCurrentLocation().whenComplete(() {
    return GoogleMap(
      mapType: MapType.hybrid,
      myLocationEnabled: true,
      mapToolbarEnabled: true,
      onTap: (loc) async {
        final cords = geoco.Coordinates(loc.latitude, loc.longitude);
        var address =
            await geoco.Geocoder.local.findAddressesFromCoordinates(cords);
        countryName = address.first.countryName;
        mainAddress = address.first.addressLine;
        notifyListeners();
        // markers.isNotEmpty
        //     ? getMarkers(loc.latitude, loc.longitude)
        //     : markers.clear();
        markers == null
            ? getMarkers(loc.latitude, loc.longitude)
            : markers.clear();
        print(countryName);
        print(mainAddress);
        print(loc);
      },
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController mapController) {
        googleMapController = mapController;
        notifyListeners();
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(12.972442, 77.580643),
        zoom: 14.0,
      ),
    );
    // });
  }
}
