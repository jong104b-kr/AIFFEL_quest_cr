import 'package:flutter/material.dart';
import 'scanner_screen.dart';
import 'home_screen.dart';
import 'mypage_screen.dart';
import 'detail_screen.dart';

// 실행 시 처음 제어가 찾아오는 곳
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 초기에는 기본값으로 OneScreen() 이동
      initialRoute: '/one',
      routes: {
        // 각각 해당 경로 설정하는 정규표현식
        '/one': (context) => HomeScreen(),
        '/two': (context) => DetailScreen(),
        '/three': (context) => MyPageScreen(),
        '/four': (context) => ScannerScreen()
      },
    );
  }
}