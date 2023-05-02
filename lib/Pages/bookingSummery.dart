import 'package:digikit/Components/color.dart';
import 'package:digikit/Components/dbutton.dart';
import 'package:digikit/Pages/bookingPage.dart';
import 'package:flutter/material.dart';

class BookingSummery extends StatefulWidget {
  final Map<String, dynamic> busData;
  final String sId;
  final String dId;
  const BookingSummery(
      {Key? key, required this.busData, required this.dId, required this.sId})
      : super(key: key);

  @override
  State<BookingSummery> createState() => _BookingSummeryState();
}

class _BookingSummeryState extends State<BookingSummery> {
  Map<String, dynamic> stopData = {
    "name": "",
    "time": "",
  };

  Map<String, dynamic> destinationData = {
    "name": "",
    "time": "",
  };

  travelledThrough(String time) {
    DateTime moment = DateTime.now();
    final givenTime = time.split(':');
    int hours = int.parse(givenTime[0]);
    int minutes = int.parse(givenTime[1]);
    int seconds = int.parse(givenTime[2]);
    if (hours < moment.hour) {
      return true;
    }
    if (hours > moment.hour) {
      return false;
    }
    if (minutes < moment.minute) {
      return true;
    }
    if (minutes > moment.minute) {
      return false;
    }
    if (seconds <= moment.second) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      int index =
          widget.busData['stops'].indexWhere((e) => e["id"] == widget.sId);
      stopData = widget.busData['stops'][index];

      int dIndex =
          widget.busData['stops'].indexWhere((e) => e["id"] == widget.dId);
      destinationData = widget.busData['stops'][dIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
        child: Container(
          child: Column(
            children: [
              Text(
                "Your Selected Route",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.dSecondaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_bus,
                          color: Colors.red,
                        ),
                        Column(
                          children: [
                            Text(widget.busData['name']),
                          ],
                        ),
                        Text("Time: ${stopData["time"]}")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              dButton(
                  Onpress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingTicket(
                                  Source: stopData,
                                  Destination: destinationData,
                                  Vehicledata: widget.busData,
                                )));
                  },
                  Tbutton: "Book Ticket"),
              Container(
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: ColorConstants.dPrimaryColor),
                borderRadius: BorderRadius.circular(20)
                ),
                child: ListView.builder(
                    itemCount: widget.busData['stops'].length,
                    itemBuilder: (context, int index) {
                      bool passed = travelledThrough(
                          widget.busData['stops'][index]['time']);
                      return Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: ListTile(
                          leading: passed == true
                              ? Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                )
                              : Icon(Icons.circle),
                          // ("${widget.busData['stops'][index]['type']}" ==
                          //     "BUS_STOP"
                          //     ? Icon(
                          //   Icons
                          //       .bus_alert_rounded,
                          // )
                          //     : Icon(
                          //   Icons
                          //       .electric_meter_rounded,
                          //   color:
                          //   Colors.red,
                          // )),

                          title:
                              Text('${widget.busData['stops'][index]['name']}'),
                          tileColor: ColorConstants.dAscentColor,
                          selectedTileColor: Colors.blue[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      );
                    }),
                // Card(
                //   child: ListTile(
                //     leading: Icon(Icons.circle),
                //     title: Text(${}),
                //   ),
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
