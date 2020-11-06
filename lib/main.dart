import 'package:flutter/material.dart';

import 'screen/page1.dart';
// import 'package:firebasedemo/screen/signin.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Sarabun',
        
        primarySwatch: Colors.purple,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(title: 'Flutter Demo Home Page'),
    );
  }
}
