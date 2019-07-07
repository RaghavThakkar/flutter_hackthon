import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'firbase/FirestoreDatabase.dart';
import 'modal/Dustbin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => new _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  bool _saving = false;
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  @override
  void initState() {
    reference = Firestore.instance.collection('Dustbins');
  }

  CollectionReference reference;

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(22.2926019, 73.1203902);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Future _onAddMarkerButtonPressed(LatLng latlang) async {
    setState(() {
      _saving = true;
    });
    var dustbin = Dustbin();
    GeoPoint geoPoint = GeoPoint(latlang.latitude, latlang.longitude);
    dustbin.location = geoPoint;
    dustbin.clearRequest = false;
    dustbin.requestedStatus = false;
    dustbin.level = 0;
    var currentDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    dustbin.clearRequestedDate = currentDate;
    print(currentDate);
    dustbin.sinceLastEmpty = currentDate;
    firestoreDatabase.storeNewEvent(dustbin, context);
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: LatLng(latlang.latitude, latlang.longitude),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _saving = false;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    loadDustBins();
  }

  void loadDustBins() {
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        Dustbin dustbin = Dustbin.fromSnapshot(change.document);
        setState(() {
          _markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(dustbin.location.toString()),
            position:
                LatLng(dustbin.location.latitude, dustbin.location.longitude),
            icon: BitmapDescriptor.defaultMarker,
          ));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: Container(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onLongPress: (latlang) {
                  _onAddMarkerButtonPressed(latlang);
                },
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(
                      () => PanGestureRecognizer()))
                  ..add(Factory<ScaleGestureRecognizer>(
                      () => ScaleGestureRecognizer()))
                  ..add(Factory<TapGestureRecognizer>(
                      () => TapGestureRecognizer()))
                  ..add(Factory<HorizontalDragGestureRecognizer>(
                      () => HorizontalDragGestureRecognizer()))
                  ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())),
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
                mapType: _currentMapType,
                markers: _markers,
                onCameraMove: _onCameraMove,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () async {
                          Position position = await Geolocator()
                              .getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                          print(position);
                          _onAddMarkerButtonPressed(
                              LatLng(position.latitude, position.longitude));
                        },
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.add_location, size: 36.0),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        inAsyncCall: _saving,
      ),
    );
  }

  /// When we're ready to show the animations, this method will create the main
  /// content showcasing them.

}
