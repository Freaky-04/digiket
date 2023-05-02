import 'package:digikit/Components/color.dart';
import 'package:digikit/Components/dbutton.dart';
import 'package:digikit/Components/dtextfield.dart';
import 'package:digikit/Pages/PublicTransportationFinder.dart';
import 'package:flutter/material.dart';
import '../Components/api.dart';
import 'dart:convert';

class GetLocationAccess extends StatelessWidget {
  const GetLocationAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> stopsData = [];

    TextEditingController Pincode = new TextEditingController();
    print(Pincode.text);
    _getpin() async {
      var res = await CallApi().getData("location/${Pincode.text}");
      var body = json.decode(res.body);
      stopsData = body['stops'];
      print(body);
      if (res.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublicTranspotationFinder(
                      stopList: body['stops'],
                    )));
      }
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Stack(children: [
          Positioned.fill(
            top: 500,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/LocationAcess.png'),
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(
                //   Icons.location_on,
                //   size: 300.0,
                //   color: Colors.blue,
                // ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: Text(
                    "Give Location Access or Add Pin Code",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 50, 80, 10),
                  child: dTextField(
                      hintText: "Enter Area Pin Code", tController: Pincode),
                  //
                ),
                dButton(Onpress: () => {_getpin()}, Tbutton: "Submit")
              ],
            ),
          ]),
        ]),
      ),
    );
  }
}
