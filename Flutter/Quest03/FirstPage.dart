import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  bool? is_cat; // 부울 자료형 초기화 하지 않은 상태로 선언(? 이용)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FirstPage'),
          centerTitle: true, // 가운데 정렬 추가
          leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu) // 아이콘 바꾸는 작업은 추가해야 함.
          )),
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
                    is_cat = true; // is_cat 부울 자료형을 바꾸는 과정을 구현하는
                    // 부분이 어려워 chatgpt에 해당부분 소스를 붙여 물어봄, 유추가 좋다.
                    Navigator.pushNamed(context, '/two');
                  },//'/two' 버튼 생성
                  child: Text('Next'),
                ),
                SizedBox(height: 20),
                GestureDetector( // 네트워크 이미지 호출 과정을 chatgpt에 물어봄
                  child: Image.network('https://raw.githubusercontent.com/jong104b-kr/AIFFEL_quest_cr/refs/heads/master/Flutter/Quest03/dog.jpeg'),
                  onTap: () {
                    is_cat=false; // 제스처 감지기 작동시 불 자료형 값 대입
                    print("is_cat:$is_cat"); // 화면 출력
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}