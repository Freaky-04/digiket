import 'dart:convert';
import 'package:digikit/Components/api.dart';
import 'package:digikit/Components/color.dart';
import 'package:digikit/Components/dbutton.dart';
import 'package:digikit/Pages/displayRoutes.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  // final List<dynamic> stopList;

  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<dynamic> items = [];
  List<String> sStop = [];
  List<String> dStop = [];
  int show = 0;

  getStations() async {
    var res = await CallApi().getData("stop");
    Map<String, dynamic> body = json.decode(res.body);
    List<dynamic> listdata = body['stops'];
    print(listdata);
    setState(() {
      items = listdata;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStations();
  }

  submit() async {
    if (sStop.length == 0 || dStop.length == 0) return;
    var source = sStop[0];
    var destination = dStop[0];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayRoutes(
                  dId: destination,
                  sId: source,
                  dStop: dStop[1],
                  sStop: sStop[1],
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        backgroundColor: ColorConstants.dAscentColor,
        title: Text(
          "DIGIKIT",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       prefixIcon: new Icon(Icons.arrow_upward),
                    //       hintText: "Enter Source",
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide:
                    //             BorderSide(width: 3, color: Colors.blueAccent),
                    //         borderRadius: BorderRadius.circular(25),
                    //       )),
                    //   controller: Source,
                    // ),
                    InkWell(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstants.dPrimaryColor, width: 3),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "From",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(sStop.length == 0
                                      ? "Select To Station"
                                      : sStop[1])
                                ],
                              ),
                              Icon(
                                Icons.arrow_right,
                                size: 40,
                                color: ColorConstants.dPrimaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          show = 1;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstants.dPrimaryColor, width: 3),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "To",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(dStop.length == 0
                                      ? "Select To Station"
                                      : dStop[1])
                                ],
                              ),
                              Icon(
                                Icons.arrow_right,
                                size: 40,
                                color: ColorConstants.dPrimaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          show = 2;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 200,
                      child:
                          // dButton(
                          //     Onpress: () => {submit()},
                          //     Tbutton: "find Bus"
                          // )
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: ColorConstants.dPrimaryColor,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                submit();
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Search Bus",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Icon(Icons.search)
                                  ])),
                    )
                    // TextField(
                    //   decoration: InputDecoration(
                    //       prefixIcon: new Icon(Icons.arrow_downward),
                    //       hintText: "Enter Destination",
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide:
                    //             BorderSide(width: 3, color: Colors.blueAccent),
                    //         borderRadius: BorderRadius.circular(25),
                    //       )),
                    //   onEditingComplete: () {
                    //     submit();
                    //   },
                    //   controller: Destination,
                    // )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: show == 0
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text("Select option from above."),
                    ))
                  : Container(
                      width: double.infinity,
                      // padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select from below",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Stops",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.directions_bus,
                                      color: Colors.red,
                                    ),
                                    Text("Bus")
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.train,
                                      color: Colors.indigo,
                                    ),
                                    Text("Metro")
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            color: Colors.transparent,
                            height: 300,
                            child: items == null
                                ? CircularProgressIndicator()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ListView.builder(
                                        itemCount: items.length,
                                        itemBuilder: (context, int index) {
                                          return Card(
                                            elevation: 0,
                                            color: Colors.transparent,
                                            child: ListTile(
                                              onTap: () {
                                                setState(() {
                                                  if (show == 1) {
                                                    sStop = [
                                                      items[index]["id"],
                                                      items[index]["name"]
                                                    ];
                                                  } else if (show == 2) {
                                                    dStop = [
                                                      items[index]["id"],
                                                      items[index]["name"]
                                                    ];
                                                  }
                                                  show = 0;
                                                });
                                              },
                                              leading:
                                                  ("${items[index]['type']}" ==
                                                          "BUS_STOP"
                                                      ? Icon(
                                                          Icons.directions_bus,
                                                          color: Colors.red,
                                                          shadows: [
                                                            Shadow(
                                                                color: Colors
                                                                    .deepOrangeAccent,
                                                                blurRadius: 5.0)
                                                          ],
                                                        )
                                                      : Icon(
                                                          Icons.train,
                                                          color: Colors.indigo,
                                                          shadows: [
                                                            Shadow(
                                                                color: Colors
                                                                    .blueGrey,
                                                                blurRadius: 5.0)
                                                          ],
                                                        )),
                                              title: Text(
                                                  '${items[index]["name"]}',
                                                  textAlign: TextAlign.start),
                                              tileColor:
                                                  ColorConstants.dAscentColor,
                                              selectedTileColor: ColorConstants
                                                  .dSecondaryColor,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: ColorConstants
                                                        .dSecondaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                          ))
                        ],
                      ),
                    ),
            ),
            Container(
              color: Colors.grey,
              child: Column(
                children: [
                  Row(
                    children: [Icon(Icons.help), Icon(Icons.feedback)],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Alertonbtn extends StatefulWidget {
  const Alertonbtn({Key? key}) : super(key: key);

  @override
  State<Alertonbtn> createState() => _AlertonbtnState();
}

class _AlertonbtnState extends State<Alertonbtn> {
  @override
  Widget build(BuildContext context) {
    return SnackBar(content: const Text("data"));
  }
}
