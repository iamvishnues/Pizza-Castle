import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminDetailsHelper extends ChangeNotifier {
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  initMarker(coll, collId) {
    var varMarkerId = collId;
    final MarkerId markerId = MarkerId(varMarkerId);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(coll['latlong'].latitude, coll['latlong'].longitude),
        infoWindow: InfoWindow(title: "Order", snippet: coll["location"]));
    markers[markerId] = marker;
  }

  getMarkerData() async {
    FirebaseFirestore.instance
        .collection("adminCollections")
        .get()
        .then((docData) {
      if (docData.docs.isNotEmpty) {
        for (int i = 0; i < docData.docs.length; i++) {
          initMarker(docData.docs[i].data(), docData.docs[i].id);
          print(docData.docs[i].data());
        }
      }
    });
  }

  showGoogleMaps(BuildContext context, DocumentSnapshot documentSnapshot) {
    return GoogleMap(
      mapType: MapType.hybrid,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      compassEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(documentSnapshot.data()['latlong'].latitude,
              documentSnapshot.data()['latlong'].longitude),
          zoom: 17),
      onMapCreated: (GoogleMapController mapcontroller) {
        googleMapController = mapcontroller;
        notifyListeners();
      },
    );
  }

  detailSheet(BuildContext context, DocumentSnapshot documentSnapshot) {
    getMarkerData();
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: 900,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120.0, vertical: 2),
                    child: Divider(
                      thickness: 3,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(documentSnapshot.data()["username"])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 280,
                              child: Text(documentSnapshot.data()["location"],
                                  style: TextStyle(fontSize: 11)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 400,
                    child: showGoogleMaps(context, documentSnapshot),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.clock),
                              SizedBox(
                                width: 20,
                              ),
                              Text(documentSnapshot.data()["time"])
                            ],
                          ),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.rupeeSign),
                              SizedBox(
                                width: 20,
                              ),
                              Text(documentSnapshot.data()["price"])
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 2,
                                spreadRadius: 3)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    documentSnapshot.data()["image"]),
                              ),
                              Column(
                                children: [
                                  Text(
                                      "Pizza: ${documentSnapshot.data()["pizza"]}"),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Cheese: ${documentSnapshot.data()["cheese"]}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        "Onion: ${documentSnapshot.data()["onion"]}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        "Oliver: ${documentSnapshot.data()["oliver"]}",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              CircleAvatar(
                                child: Text(documentSnapshot.data()["size"]),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.redAccent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              )),
                          icon: Icon(FontAwesomeIcons.eye),
                          label: Text("Skip"),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.redAccent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              )),
                          icon: Icon(FontAwesomeIcons.gift),
                          label: Text("Deliver"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.redAccent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        )),
                    icon: Icon(FontAwesomeIcons.phone),
                    label: Text("Contact the owner"),
                  )
                ],
              ),
            ),
          );
        });
  }
}
