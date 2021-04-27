import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DeliveryOptions extends ChangeNotifier {
  showOrders(BuildContext context, String collection) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.80,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection(collection).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Lottie.asset("Assets/Animations/loading.json");
                } else {
                  return ListView(
                    children: snapshot.data.docs
                        .map((DocumentSnapshot documentSnapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 2,
                                    spreadRadius: 3)
                              ]),
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.location_on),
                              onPressed: () {},
                            ),
                            title: Text(documentSnapshot.data()["name"]),
                            subtitle: Text(documentSnapshot.data()["address"]),
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                  documentSnapshot.data()["image"]),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          );
        });
  }

  Future managedOrders(BuildContext context, DocumentSnapshot documentSnapshot,
      String collection, String message) async {
    await FirebaseFirestore.instance.collection(collection).add({
      'image': documentSnapshot.data()["image"],
      "name": documentSnapshot.data()["username"],
      "pizza": documentSnapshot.data()["pizza"],
      "address": documentSnapshot.data()["location"],
      "location": documentSnapshot.data()["latlong"],
    }).whenComplete(() {
      showMessage(context, message);
    });
  }

  showMessage(BuildContext context, String message) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 50,
            child: Center(child: Text(message)),
          );
        });
  }
}
