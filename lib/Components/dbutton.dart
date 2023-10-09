import 'package:flutter/material.dart';

import 'color.dart';

class dButton extends StatelessWidget {
  final Onpress;
  final Tbutton;
  const dButton({Key? key, required this.Onpress, required this.Tbutton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: ColorConstants.dPrimaryColor,padding: EdgeInsets.only(left: 20,right: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))
        ),
        onPressed: Onpress,
        child: Text(
          Tbutton,
          style: TextStyle(fontSize: 18),
        ));
  }
}
