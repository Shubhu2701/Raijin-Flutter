import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text(
        'Loading..',
        style: TextStyle(fontSize: 40),
      ),
    ));
  }
}

// SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: topAirData
//                               .map((topair) => topTemplate(topair))
//                               .toList())),
