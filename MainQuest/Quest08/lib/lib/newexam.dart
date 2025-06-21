/*
이 플러터 코드는 NewExamPage라는 화면을 정의하며, 사용자가 새로운 문제를 풀거나
문제은행에 접근할 수 있는 기능을 제공함, 이 화면은 StatefulWidget으로 구현되어 있으며
Scaffold와 ElevatedButton을 사용하여 UI를 구성함.
 */
import 'package:flutter/material.dart';

import 'publishedexam.dart'; // 기출문제 화면을 정의하는 모듈
import 'qbank.dart'; // 문제은행 화면을 정의하는 모듈
import 'appbar.dart'; // 커스텀 앱바 위젯을 정의하는 모듈

/*
StatefulWidget으로 정의되어 있으며 title이라는 필수 매개변수를 받는다. 이 매개변수는
이전 페이지의 제목을 나타낸다.
 */
class NewExamPage extends StatefulWidget {
  final String title; // 이전 페이지 제목을 받을 변수

  const NewExamPage({super.key, required this.title});

  /* 화면의 상태를 관리하는 클래스 */
  @override
  State<NewExamPage> createState() => _NewExamPageState();
}

/*
build() 메서드는 UI를 구성하는 메서드로 Scaffold를 사용하여 화면의 기본 구조를 만든다.
CSAppBar : 커스텀 앱바를 설정함, title값을 전달하여 앱바의 제목을 설정함.
Row위젯 : 두 개의 ElevatedButton을 수평으로 배치함. 첫 번째 버튼은 기출문제,
두 번째 버튼은 문제은행 텍스트 표시, 각 버튼의 onPressed 콜백은 Navigator.push를 사용하여
해당 화면으로 네이게이션을 수행하며 title값을 전달한다.
 */
class _NewExamPageState extends State<NewExamPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(title: widget.title),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              // PublishedExam으로 이동하면서 title 값을 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PublishedExamPage(title: widget.title),
                ),
              );
            },
            child: Text('기출문제'),
          ),
          ElevatedButton(
            onPressed: () {
              // QnABBSPage로 이동하면서 title 값을 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionBankPage(title: widget.title),
                ),
              );
            },
            child: Text('문제은행'),
          ),
        ]
      ),
    );
  }
}