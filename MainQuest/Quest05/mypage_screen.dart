import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp 반환
    return MaterialApp(
      // Scafford 구조로 설계
      home: Scaffold(
        // 앱바에 타이틀 출력
        appBar: AppBar(
          title: Text('MyPageScreen'),
          centerTitle: true,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.back_hand)),
        ),
        // 본문에 컨테이너 위젯 배치
        body: Container(
          color: Colors.yellow,
          // 컨테이너 안에 들어간 자식 위젯
          child: Center(
            child: Column(
              // 칼럼 기준 세로로 가운데 정렬
              mainAxisAlignment: MainAxisAlignment.center,
              // 자식들에 텍스트와 버튼 출력
              children: [
                Container(
                  child: Image.asset('images/MyPage.jpg'),
                ),
                Text(
                  'MyPageScreen',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                // 네번째 페이지로 이동하는 버튼
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/four');
                    },
                    child: Text('Scan Wine'),
                ),
                // 이전 페이지로 이동하는 버튼
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}