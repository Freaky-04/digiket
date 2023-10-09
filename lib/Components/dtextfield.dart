import 'package:digikit/Components/color.dart';
import 'package:flutter/material.dart';

class dTextField extends StatelessWidget {
  final tController;
  final hintText;
  const dTextField(
      {Key? key, required this.hintText, required this.tController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
              leadingDistribution: TextLeadingDistribution.proportional),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: ColorConstants.dPrimaryColor),
            borderRadius: BorderRadius.circular(25),
          ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: ColorConstants.dSecondaryColor),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
