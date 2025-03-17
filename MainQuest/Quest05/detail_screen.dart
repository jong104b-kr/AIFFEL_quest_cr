import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // materialapp 반환
    return MaterialApp(
      // scafford 구조
      home: Scaffold(
        // 앱바에는 타이틀 출력
        appBar: AppBar(
          title: Text('DetailScreen'),
          centerTitle: true,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.alarm)),
        ),
        // 본문에 컨테이너 위젯 배치
        body: Container(
          color: Colors.green,
          // 자식 위젯으로 화면 구성, 중앙에 출력
          child: Center(
            // 세로로 배치
            child: Column(
              // 세로축 기준 가운데 정렬
              mainAxisAlignment: MainAxisAlignment.center,
              // 텍스트와 버튼 배치(설계)
              children: [
                Container(
                  child: Image.asset('images/DetailPage.jpg'),
                ),
                Text(
                  'DetailScreen',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/three');
                    },
                    child: Text('My Page'),
                ),
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