import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: Text('MyPage'),//앱바 타이틀 (html타이틀 태그 비슷하게 작용)
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu)
              )
          ),
          body: Container(
            color: Colors.yellow,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MyPage',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),// 컨테이너, 디테일 스크린 텍스트 삽입
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/two');
                    },
                    child: Text('HomePage'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/five');
                    },
                    child: Text('ScannerPage'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/three');
                    },
                    child: Text('SignInPage'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}