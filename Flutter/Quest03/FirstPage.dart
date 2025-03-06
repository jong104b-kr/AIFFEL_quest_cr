import 'package:flutter/material.dart';
import 'dart:io';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FirstPage'),
          centerTitle: true,
          leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu)// 좌측 상단 아이콘 하나 추가
          )),//앱바 상단 'OneScreen' 타이틀 지정
        body: Container(
          color: Colors.red,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FirstPage',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/two');
                  },//'/two' 버튼 생성
                  child: Text('Next'),
                ),
                SizedBox(height: 20),
                Image.network('https://raw.githubusercontent.com/jong104b-kr/AIFFEL_quest_cr/refs/heads/master/Flutter/Quest03/dog.jpeg')
              ],
            ),
          ),
        ),
      ),
    );
  }
}