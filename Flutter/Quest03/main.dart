// main.dart
import 'package:flutter/material.dart';
import 'FirstPage.dart';
import 'SecondPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/one',
      routes: {
        '/one': (context) => FirstPage(),
        '/two': (context) => SecondPage()
      },
    );
  }
}