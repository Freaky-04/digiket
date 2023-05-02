import 'dart:async';
import 'dart:convert';
import 'package:digikit/Components/color.dart';
import 'package:digikit/Pages/mainHomeScreen.dart';
import 'package:flutter/material.dart';

import '../Components/api.dart';

class BookingTicket extends StatefulWidget {
  final Map<String, dynamic> Source;
  final Map<String, dynamic> Destination;
  final Map<String, dynamic> Vehicledata;

  const BookingTicket(
      {Key? key,
      required this.Source,
      required this.Destination,
      required this.Vehicledata})
      : super(key: key);

  @override
  State<BookingTicket> createState() => _BookingTicketState();
}

class _BookingTicketState extends State<BookingTicket> {
  submitData() async {
    var url = "ticket";
    var data = {
      "source": widget.Source['id'],
      "destination": widget.Destination['id'],
      "vehicleId": widget.Vehicledata['id'],
      "user": aadharId.text
    };
    var res = await CallApi().postData(data, url);
    // var body = json.decode(res.body);
    // print("object");
    // print(res.statusCode);
    if (res.statusCode == 200) {
      Widget okButton = TextButton(
        child: Text("Ok"),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainHome()));
        },
      );
      AlertDialog(
        title: const Text("Ticket booked sucessfully"),
        content: Text("your ticket booked sucess" "Linked to aadhar"),
        actions: [
          okButton,
        ],
      );
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => PublicTranspotationFinder(
      //           stopList: body['stops'],
      //         )));
    }
  }

  TextEditingController aadharId = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print(VehicleId);
    return Scaffold(
      body: Container(
        width: double.infinity,
        // color: Colors.blueGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "Book Ticket",
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                color: ColorConstants.dSecondaryColor,
                width: 500,
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Source: " "${widget.Source['name']}     "),
                        Text("Destination: " "${widget.Destination['name']}")
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Vehicle Name: " "${widget.Vehicledata['name']}"),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: aadharId,
                      decoration: InputDecoration(
                          hintText: "Enter Users Aadhar ID Last Four Digits",
                          hintStyle: TextStyle(
                              leadingDistribution:
                                  TextLeadingDistribution.proportional),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(25),
                          )),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            primary: Colors.black),
                        onPressed: () {
                          submitData();
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => ()));
                        },
                        child: Text("Book Ticket")),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
