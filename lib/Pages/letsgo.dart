import 'dart:async';

import 'package:digikit/Pages/mainHomeScreen.dart';
import 'package:flutter/material.dart';

class LetsGo extends StatelessWidget {

  const LetsGo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainHome(),maintainState: true))
    );

    return Scaffold(
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("Lets Go",style: TextStyle(fontSize: 50),),
            Icon(Icons.start_rounded,size: 50.0,)
          ]
        ),
      ),
    );
  }
}
