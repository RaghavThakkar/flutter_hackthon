import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'modal/Dustbin.dart';

class DustBinRequestScreen extends StatefulWidget {
  @override
  _DustBinRequestState createState() => new _DustBinRequestState();
}

class _DustBinRequestState extends State<DustBinRequestScreen> {
  CollectionReference reference;
  List<Dustbin> dusbins=List();
  @override
  void initState() {
    super.initState();
    reference = Firestore.instance.collection('Dustbins');
    reference.snapshots().listen((querySnapshot) {
      dusbins.clear();
      querySnapshot.documentChanges.forEach((change) {
        Dustbin dustbin=Dustbin.fromSnapshot(change.document);
        dusbins.add(dustbin);
      });

      print(dusbins.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distbin Request'),
      ),
      body: Center(
        child: Text("Test data"),
      ),
    );
  }

  /// When we're ready to show the animations, this method will create the main
  /// content showcasing them.

}
