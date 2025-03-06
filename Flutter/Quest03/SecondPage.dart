import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  bool? is_cat; // 부울 자료형 초기화 하지 않은 상태로 선언(? 이용)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('SecondPage'),//앱바 타이틀 (html타이틀 태그 비슷하게 작용)
            centerTitle: true,
            leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu) // 아이콘 바꾸는 작업은 추가해야 함.
            )
          ),
          body: Container(
            color: Colors.green,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SecondPage',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),// 컨테이너, 디테일 스크린 텍스트 삽입
                  ElevatedButton(
                    onPressed: () {
                      is_cat = false;
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Image.network('https://raw.githubusercontent.com/jong104b-kr/AIFFEL_quest_cr/refs/heads/master/Flutter/Quest03/cat.jpeg'),
                    onTap: () {
                      is_cat=true;
                      print("is_cat:$is_cat");
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}