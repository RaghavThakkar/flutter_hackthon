
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hackthon/modal/Dustbin.dart';

class FirestoreDatabase {

  getDustbins(){
    return Firestore.instance.collection('Dustbins').snapshots();
  }

  storeNewEvent(Dustbin dustbin, context){
    Firestore.instance.collection('Dustbins').add({
      'requestedStatus' : dustbin.requestedStatus,
      'location' : dustbin.location,
      'level' : dustbin.level,
      'clearRequest' : dustbin.clearRequest,
      'clearRequestedDate' : dustbin.clearRequestedDate,
      'sinceLastEmpty' : dustbin.sinceLastEmpty,
    }).then((value) {

    }).catchError((e) {
      print(e);
    });
  }
}