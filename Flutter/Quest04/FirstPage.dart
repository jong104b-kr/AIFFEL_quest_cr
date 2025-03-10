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
                icon: Icon(Icons.menu)
            )),
        body: Container(
          color: Colors.red,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                     Navigator.pushNamed(context, '/two');
                  },//'/two' 버튼 생성
                  child: Text('Vivino Wine Searcher'),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}