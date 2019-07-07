import 'package:flutter/material.dart';
import 'package:flutter_hackthon/modal/Dustbin.dart';

class DustbinCard extends StatelessWidget {
  final Dustbin dustbin;

  DustbinCard({this.dustbin});

  _requestcleanDustbiin() {
    print('Request Dustbin Cleanrance Called');
  }

  @override
  Widget build(BuildContext context) {


    return Container(
        child: Card(
      child: Container(
        /*decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(5.0)
        ),*/
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment:  Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: dustbin.level == 0 ? Colors.green : (dustbin.level == 1 ? Colors.yellow : Colors.red),
                  width: 2
                ),
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
                                    color: dustbin.level == 0 ? Colors.green : (dustbin.level == 1 ? Colors.yellow : Colors.red),
                                    border: Border.all(
                                        color: dustbin.level == 0 ? Colors.green : (dustbin.level ==1 ? Colors.yellow : Colors.red), width: 1),
                                    borderRadius: BorderRadius.circular(4.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(dustbin.level == 0 ? 'Empty' : (dustbin.level == 1 ? 'Half Full' : 'Full'),
                                    style: TextStyle(
                                        color: Colors.white
                                    ),),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Last Empty Date\n' + dustbin.sinceLastEmpty, style: TextStyle(color: Colors.black, fontSize:  12.0),),
                              )
                            ],
                          )
                      ),

                    ],
                  ),
                   Container(
                     child: RaisedButton(
                       onPressed: _requestcleanDustbiin(),
                       color: Colors.green,
                       child: Text('Request to Clean', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),),
                     ),
                   )
                ],
              )
            )),
      ),
    ));
  }
}
