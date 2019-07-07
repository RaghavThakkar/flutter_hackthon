import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackthon/list_items/DustbinCard.dart';
import 'package:flutter_hackthon/modal/Dustbin.dart';

import 'firbase/FirestoreDatabase.dart';

class DustbinListing extends StatefulWidget {
  @override
  _DustbinListingState createState() => _DustbinListingState();
}

class _DustbinListingState extends State<DustbinListing> {
  FirestoreDatabase firestoreDatabase = new FirestoreDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: firestoreDatabase.getDustbins(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var newDustbin = snapshot.data.documents.map((snapshot) {
                    return Dustbin.fromSnapshot(snapshot);
                  }).toList();

                  print(newDustbin.toString());

                  return ListView.builder(
//                      scrollDirection: Axis.vertical,
                      itemCount: newDustbin.length,
                      itemBuilder: (context, index) => DustbinCard(
                        dustbin: newDustbin[index],
                      ));
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
