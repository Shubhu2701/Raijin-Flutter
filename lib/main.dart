import 'package:flutter/material.dart';
import 'package:Raijin/Pages/homepage.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Nunito'),
      routes: {
        '/': (context) => Homepage(),
        //'/search': (context) => SearchPage(),
      }));
}
