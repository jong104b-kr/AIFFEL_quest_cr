// main.dart
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'FirstPage.dart';
import 'SignInPage.dart';
import 'MyPage.dart';
import 'ScannerPage.dart';
import 'DetailPage.dart';

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
        '/two': (context) => HomePage(),
        '/three': (context) => SignInPage(),
        '/four': (context) => MyPage(),
        '/five': (context) => ScannerPage(),
        '/six': (context) => DetailPage()
      },
    );
  }
}