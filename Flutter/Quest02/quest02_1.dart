import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, // (3) 배경색상 파랑 지정
          title: Text("플러터 앱 만들기"), // (2) 플러터앱 만들기 텍스트 추가
          centerTitle: true,
          leading: IconButton(
              onPressed: (){},
              icon: Icon(Icons.menu) // (1) 좌측 상단에 메뉴 아이콘 추가
          ),),
        body : Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children:[
            ElevatedButton( // (4) Text버튼 추가, 디버그콘솔에 출력
                onPressed: (){
                  print("버튼이 눌렸습니다.");},
                child: Text('Text')),
            SizedBox(height: 20),
            Stack( // (5) 5개 컨테이너 추가
              alignment: Alignment.topLeft,
              children: [
                Container(width: 300, height: 300, color: Colors.blue),
                Container(width: 240, height: 240, color: Colors.orange),
                Container(width: 180, height: 180, color: Colors.red),
                Container(width: 120, height: 120, color: Colors.green),
                Container(width: 60, height: 60, color: Colors.yellow),
              ],
            ),],
        ),),
      ),);
  }
}