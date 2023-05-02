import 'dart:convert';
import 'dart:ui';

import 'package:digikit/Components/color.dart';
import 'package:digikit/Pages/bookingSummery.dart';
import 'package:flutter/material.dart';

import '../Components/api.dart';

class DisplayRoutes extends StatefulWidget {
  final String sId;
  final String sStop;
  final String dId;
  final String dStop;
  // // DisplayRoutes({
  // //   required this.stext,
  // //   required this.dtext,
  // // });
  //
  const DisplayRoutes(
      {Key? key,
      required this.sId,
      required this.sStop,
      required this.dStop,
      required this.dId})
      : super(key: key);
  @override
  State<DisplayRoutes> createState() => _DisplayRoutesState();
}

class _DisplayRoutesState extends State<DisplayRoutes> {
  List<dynamic> items = [];
  List<dynamic> sItems = [];
  List<dynamic> rItems = [];

  getStations() async {
    var source = widget.sId;
    var destination = widget.dId;
    var directUrl = "route/direct?source=${source}&destination=${destination}";
    var relaxedUrl =
        "route/relaxed?source=${source}&destination=${destination}";
    var smartUrl = "route/smart?source=${source}&destination=${destination}";
    var res = await CallApi().getData(directUrl);
    var body = json.decode(res.body);
    List listdata = body['vehicles'];
    var rRes = await CallApi().getData(relaxedUrl);
    var rBody = json.decode(rRes.body);
    List rListdata = rBody['vehicles'];
    var sRes = await CallApi().getData(smartUrl);
    var sBody = json.decode(sRes.body);
    List sListdata = sBody['vehicles'];
    print("hereis data");
    print(rListdata);
    setState(() {
      items = listdata;
      rItems = rListdata;
      sItems = sListdata;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStations();
  }

  @override
  Widget build(BuildContext context) {
    print("object");
    print(items);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorConstants.dPrimaryColor, width: 3),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Source: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${widget.sStop}",
                        style: TextStyle(fontSize: 15),
                      ),
                      Divider(),
                      Text(
                        "Destination: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${widget.dStop}",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ),
            DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Column(children: [
                TabBar(
                  unselectedLabelColor: Colors.black87,
                  indicatorColor: ColorConstants.dPrimaryColor,
                  labelColor: Colors.black,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(
                      text: 'Smart Routes',
                    ),
                    Tab(
                      text: 'Relax Routes',
                    ),
                    Tab(
                      text: 'All Routes',
                    ),
                  ],
                ),
                items.length == 0
                    ? Container(
                        transformAlignment: Alignment.center,
                        child: Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text("no data found"),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/Routefingbg.png'),
                                fit: BoxFit.cover)),
                        height: 630,
                        child: Column(
                          children: [
                            Expanded(
                              child: TabBarView(children: [
                                new BackdropFilter(
                                  filter: new ImageFilter.blur(
                                      sigmaX: 3.0, sigmaY: 3.0),
                                  child: Container(
                                    child: sItems == null
                                        ? CircularProgressIndicator()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: ListView.builder(
                                                itemCount: sItems.length,
                                                itemBuilder:
                                                    (context, int index) {
                                                  return Card(
                                                    elevation: 0,
                                                    color: Colors.transparent,
                                                    child: ListTile(
                                                      leading:
                                                          ("${sItems[index]['type']}" ==
                                                                  "BUS"
                                                              ? Icon(
                                                                  Icons
                                                                      .directions_bus,
                                                                  color: Colors
                                                                      .red,
                                                                  shadows: [
                                                                    Shadow(
                                                                        color: Colors
                                                                            .deepOrangeAccent,
                                                                        blurRadius:
                                                                            5.0)
                                                                  ],
                                                                )
                                                              : Icon(
                                                                  Icons.train,
                                                                  color: Colors
                                                                      .indigo,
                                                                  shadows: [
                                                                    Shadow(
                                                                        color: Colors
                                                                            .blueGrey,
                                                                        blurRadius:
                                                                            5.0)
                                                                  ],
                                                                )),
                                                      title: Text(
                                                          '${sItems[index]['name']}'),
                                                      tileColor: ColorConstants
                                                          .dAscentColor,
                                                      selectedTileColor:
                                                          Colors.blue[300],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BookingSummery(
                                                                    busData:
                                                                        (sItems[
                                                                            index]),
                                                                    sId: widget
                                                                        .sId,
                                                                    dId: widget
                                                                        .dId,
                                                                  )),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }),
                                          ),
                                  ),
                                ),
                                Container(
                                  child: rItems == null
                                      ? CircularProgressIndicator()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: ListView.builder(
                                              itemCount: items.length,
                                              itemBuilder:
                                                  (context, int index) {
                                                return Card(
                                                  elevation: 0,
                                                  color: Colors.transparent,
                                                  child: ListTile(
                                                    trailing: Text(
                                                        'avilable seats: '
                                                        '${rItems[index]['availabilty']}'),
                                                    leading:
                                                        ("${rItems[index]['type']}" ==
                                                                "BUS"
                                                            ? Icon(
                                                                Icons
                                                                    .directions_bus,
                                                                color:
                                                                    Colors.red,
                                                                shadows: [
                                                                  Shadow(
                                                                      color: Colors
                                                                          .deepOrangeAccent,
                                                                      blurRadius:
                                                                          5.0)
                                                                ],
                                                              )
                                                            : Icon(
                                                                Icons.train,
                                                                color: Colors
                                                                    .indigo,
                                                                shadows: [
                                                                  Shadow(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      blurRadius:
                                                                          5.0)
                                                                ],
                                                              )),
                                                    title: Text(
                                                        '${rItems[index]['name']}'),
                                                    tileColor: ColorConstants
                                                        .dAscentColor,
                                                    selectedTileColor:
                                                        Colors.blue[300],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BookingSummery(
                                                                  busData:
                                                                      (rItems[
                                                                          index]),
                                                                  sId: widget
                                                                      .sId,
                                                                  dId: widget
                                                                      .dId,
                                                                )),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }),
                                        ),
                                ),
                                Container(
                                  child: items == null
                                      ? CircularProgressIndicator()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: ListView.builder(
                                              itemCount: items.length,
                                              itemBuilder:
                                                  (context, int index) {
                                                return Card(
                                                  elevation: 0,
                                                  color: Colors.transparent,
                                                  child: ListTile(
                                                    leading:
                                                        ("${items[index]['type']}" ==
                                                                "BUS"
                                                            ? Icon(
                                                                Icons
                                                                    .directions_bus,
                                                                color:
                                                                    Colors.red,
                                                                shadows: [
                                                                  Shadow(
                                                                      color: Colors
                                                                          .deepOrangeAccent,
                                                                      blurRadius:
                                                                          5.0)
                                                                ],
                                                              )
                                                            : Icon(
                                                                Icons.train,
                                                                color: Colors
                                                                    .indigo,
                                                                shadows: [
                                                                  Shadow(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      blurRadius:
                                                                          5.0)
                                                                ],
                                                              )),
                                                    title: Text(
                                                        '${items[index]['name']}'),
                                                    tileColor: ColorConstants
                                                        .dAscentColor,
                                                    selectedTileColor:
                                                        Colors.blue[300],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BookingSummery(
                                                                  busData: (items[
                                                                      index]),
                                                                  sId: widget
                                                                      .sId,
                                                                  dId: widget
                                                                      .dId,
                                                                )),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }),
                                        ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
