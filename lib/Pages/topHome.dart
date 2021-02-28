import 'package:Raijin/Pages/topTemp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TopHome extends StatelessWidget {
  List top;
  bool air;
  TopHome(this.top, this.air);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            toolbarHeight: 40,
            title: air == true ? Text('Top Airing') : Text('Top Upcoming')),
        body: toptemp(top));
  }
}
