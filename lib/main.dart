import 'package:flutter/material.dart';
import 'package:frolicsports/screens/homeScreen.dart';
import 'package:frolicsports/screens/signInScreen.dart';

import 'main1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frolic Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //MyHomePage()
          //CreateExcelWidget()
          HomeScreen(),
    );
  }
}
