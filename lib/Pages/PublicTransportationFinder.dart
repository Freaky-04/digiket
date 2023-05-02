import 'dart:async';

import 'package:digikit/Pages/letsgo.dart';
import 'package:digikit/Pages/mainHomeScreen.dart';
import 'package:flutter/material.dart';

class PublicTranspotationFinder extends StatefulWidget {
  final List<dynamic> stopList;
  const PublicTranspotationFinder({Key? key, required this.stopList})
      : super(key: key);

  @override
  State<PublicTranspotationFinder> createState() =>
      _PublicTranspotationFinderState();
}

class _PublicTranspotationFinderState extends State<PublicTranspotationFinder> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.stopList.length);
    Timer(Duration(seconds: 7), () =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainHome()))
    );
  }

  @override
  Widget build(BuildContext context) {
    // print({widget.stopList['stops']['id']});

    return Scaffold(
      body: Container(
        child: Stack(children: [
          Positioned.fill(
              top: 50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/publictransport.png'),
                          fit: BoxFit.fitWidth),
                      ),
                ),
              )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 90,
              ),
              Text(
                "We Found the Following available transportation nearby you",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 220.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Text(
                        "Transport \n Medium",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text("Status",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ]),
                    TableRow(children: [
                      Icon(
                        Icons.train,
                        size: 95.0,
                        color: Colors.indigo,
                      ),
                      Column(children: [
                        Icon(
                          Icons.check,
                          size: 60,
                          color: Colors.red,
                        ),
                        Text(
                          "data",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        )
                      ]),
                    ]),
                    TableRow(children: [
                      Icon(
                        Icons.directions_bus,
                        size: 95.0,
                        color: Colors.red,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.close,
                            size: 60,
                            color: Colors.green,
                          ),
                          Text(
                            "data",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ])
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
