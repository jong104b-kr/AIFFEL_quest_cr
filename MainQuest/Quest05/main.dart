import 'package:flutter/material.dart';
import 'scanner_screen.dart';
import 'home_screen.dart';
import 'mypage_screen.dart';
import 'detail_screen.dart';

/* 실행 시 처음 제어가 찾아오는 곳 */
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* 초기에는 기본값으로 HomeScreen() 이동 */
      initialRoute: '/one',
      routes: {
        /* 각각 해당 경로 설정하는 정규표현식 */
        '/one': (context) => HomeScreen(),
        '/two': (context) => DetailScreen(),
        /* 동적 라우트를 이용하므로 원래 라우트에 해당하는 코드 삭제(주석 처리) */
        // '/three': (context) => MyPageScreen(),
        // '/four': (context) => ScannerScreen()
      },
      /* onGenerateRoute를 이용하여 동적 라우트 등록,
      같은 라우트 이름으로 화면을 전환하더라도 상황에 따라 다른 화면이 나와야 할 경우,
      또한 화면을 전환할 때 전달된 데이터를 분석해 데이터를 추가하거나 제거하는 등
      동적 라우트가 필요할 때 onGenerateRoute 속성 활용
      */
      onGenerateRoute: (settings) {
        if(settings.name == '/three') {
          return MaterialPageRoute(
              builder: (context) => MyPageScreen(),
              settings: settings
          );
        }
        else if(settings.name == '/four') {
          return MaterialPageRoute(
              builder: (context) => ScannerScreen(),
              settings: settings
          );
        }
      },
    );
  }
}