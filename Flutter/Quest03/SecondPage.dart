import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  bool? is_cat;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('SecondPage'),//앱바 타이틀 (html타이틀 태그 비슷하게 작용)
            centerTitle: true,
            leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu)// 좌측 상단 아이콘 하나 추가
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
                  ),//컨테이너, 디테일 스크린 텍스트 삽입
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