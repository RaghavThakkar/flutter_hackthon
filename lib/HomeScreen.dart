import 'package:flutter/material.dart';
import 'package:flutter_hackthon/DustbinListing.dart';

import 'CurrentLocation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
                tabs: [
                  Tab(text: 'List Dustbins', icon: Icon(Icons.restore_from_trash),),
                  Tab(text: 'Display On Map', icon: Icon(Icons.map),),
                ]
            ),
            title: Text('Get your Surroundings clean',
              style: TextStyle(
                  fontSize: 16
              ),),
          ),
          body: TabBarView(
              children: <Widget>[
                DustbinListing(),
                CurrentLocation()
              ]
          )
      ),
    );
  }
}
