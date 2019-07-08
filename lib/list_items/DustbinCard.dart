import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:flutter_hackthon/modal/Dustbin.dart';

class DustbinCard extends StatelessWidget {
  final Dustbin dustbin;

  DustbinCard({this.dustbin});

  _requestcleanDustbiin() {
    print('Request Dustbin Cleanrance Called');
  }

  double _getSinceLastEmptyDayCount(String date) {
    print('Since last Date :' + date);
    String revDate = date.split('-').reversed.join('');
    /*print('Last Date: ' + revDate.toString());
    print('Year Date: ' + revDate.substring(0,4));
    print('Year Date: ' + revDate.substring(4,6));
    print('Year Date: ' + revDate.substring(6,8));*/
    var lastDate = DateTime(int.parse(revDate.substring(0, 4)),
        int.parse(revDate.substring(4, 6)), int.parse(revDate.substring(6, 8)));
//    print('Last Date: ' + lastDate.toString());
    var todayDate = DateTime.now();

    return todayDate.difference(lastDate).inDays.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(6.0),
        child: Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Image.asset('assets/dustbin_image.jpg'),
                title: Text(dustbin.requestedStatus
                    ? 'Placed already'
                    : 'Processing your request'),
//                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                subtitle: Container(
                  height: 35.0,
                  margin: EdgeInsets.only(
                      left: 0.0, top: 4.0, right: 4.0, bottom: 0.0),
                  child: FluidSlider(
                    value: _getSinceLastEmptyDayCount(dustbin.sinceLastEmpty),
                    onChanged: (double value) {},
                    min: 0.0,
                    max: 5.0,
                    start: Text(
                      'Last empty',
                      style: TextStyle(color: Colors.white),
                    ),
                    end: Text(
                      'days before',
                      style: TextStyle(color: Colors.white),
                    ),
                    sliderColor: dustbin.level == 0
                        ? Colors.green
                        : (dustbin.level == 1 ? Colors.yellow : Colors.red),
                    thumbColor: Colors.black45,
                    valueTextStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ButtonTheme.bar(
                // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    bottomDisplayWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomDisplayWidget() {
    if (dustbin.clearRequest) {
      return Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 6.0),
              child: Text(
                'Clean Requested on ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic),
              )),
          Container(
              margin: EdgeInsets.only(right: 14),
              padding: EdgeInsets.all(9.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.green, width: 1.0),
              ),
              child: Text(
                dustbin.clearRequestedDate,
                style: TextStyle(color: Colors.white),
              )),
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 14.0),
        child: RaisedButton(
          child: const Text(
            'Request To Clean',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            print('Clean Request Accepted');
          },
          color: dustbin.level == 0
              ? Colors.green
              : (dustbin.level == 1 ? Colors.yellow : Colors.red),
        ),
      );
    }
  }

/*@override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: dustbin.level == 0
                      ? Colors.green
                      : (dustbin.level == 1 ? Colors.yellow : Colors.red),
                  width: 2),
            ),
            child: new Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://cdn1.vectorstock.com/i/thumb-large/57/50/a-recycle-grabage-bin-vector-24315750.jpg',
                        height: 200,
                        width: 150,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: dustbin.level == 0
                                      ? Colors.green
                                      : (dustbin.level == 1
                                          ? Colors.yellow
                                          : Colors.red),
                                  border: Border.all(
                                      color: dustbin.level == 0
                                          ? Colors.green
                                          : (dustbin.level == 1
                                              ? Colors.yellow
                                              : Colors.red),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  dustbin.level == 0
                                      ? 'Empty'
                                      : (dustbin.level == 1
                                          ? 'Half Full'
                                          : 'Full'),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Last Empty Date\n' +
                                    dustbin.sinceLastEmpty,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.0),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                Container(
                  child: RaisedButton(
                    onPressed: _requestcleanDustbiin(),
                    color: Colors.green,
                    child: Text(
                      'Request to Clean',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ))),
      ),
    );
  }*/
}
