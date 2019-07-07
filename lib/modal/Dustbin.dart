// To parse this JSON data, do
//
//     final Dustbin = DustbinFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Dustbin> DustbinFromJson(String str) =>
    new List<Dustbin>.from(json.decode(str).map((x) => Dustbin.fromJson(x)));

String DustbinToJson(List<Dustbin> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Dustbin {
  bool requestedStatus;
  GeoPoint location;
  int level;
  bool clearRequest;
  String clearRequestedDate;
  String sinceLastEmpty;

  Dustbin(
      {this.requestedStatus,
      this.location,
      this.level,
      this.clearRequest,
      this.clearRequestedDate,
      this.sinceLastEmpty});

  Dustbin.fromSnapshot(DocumentSnapshot snapshot)
      : requestedStatus = snapshot['requestedStatus'],
        location = snapshot['location'],
        level = snapshot['level'],
        clearRequest = snapshot['clearRequest'],
        clearRequestedDate = snapshot['clearRequestedDate'],
        sinceLastEmpty = snapshot['sinceLastEmpty'];

  factory Dustbin.fromJson(Map<String, dynamic> json) => new Dustbin(
        requestedStatus: json['requestedStatus'],
        location: json['location'],
        level: json['level'],
        clearRequest: json['clearRequest'],
        clearRequestedDate: json['clearRequestedDate'],
        sinceLastEmpty: json['sinceLastEmpty'],
      );

  Map<String, dynamic> toJson() => {
        "requestedStatus": requestedStatus,
        "location": location,
        "level": level,
        "clearRequest": clearRequest,
        "clearRequestedDate": clearRequestedDate,
        "sinceLastEmpty": sinceLastEmpty,
      };
}
