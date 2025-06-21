/*
이 플러터 코드는 SolvedQuestionPage라는 화면을 정의하며, 사용자가 정답체크, 오답노트, 다시풀기
등의 기능을 선택할 수 있는 메뉴를 제공함. Navigator를 통해 다른 화면으로 이동할 수 있도록 구성함.
Column과 Row를 사용하여 버튼들을 적절하게 배치하고 CSAppBar를 통해 커스텀 앱바를 설정한다.
 */
import 'package:flutter/material.dart';

import 'answers.dart'; // 정답 체크 화면을 정의하는 모듈
import 'incorrectnote.dart'; // 오답 노트 화면을 정의하는 모듈
import 'rematch.dart'; // 다시 풀기 화면을 정의하는 모듈
import 'appbar.dart';

/* StatelessWidget으로 정의되어 있으며, title이라는 필수 매개변수를 받는다 */
class SolvedQuestionPage extends StatelessWidget {
  final String title; // 이전 페이지 제목을 받을 변수

  const SolvedQuestionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    /* 화면의 기본 구조를 제공하며, 커스텀 앱바를 설정한다. */
    return Scaffold(
      appBar: CSAppBar(title: title),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // AnswersPage로 이동하면서 title 값을 전달
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnswersPage(title: title),
                    ),
                  );
                },
                child: Text('정답체크'),
              ),
              ElevatedButton(
                onPressed: () {
                  // IncorrectNotePage로 이동하면서 title 값을 전달
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IncorrectNotePage(title: title),
                    ),
                  );
                },
                child: Text('오답노트'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // RematchPage로 이동하면서 title 값을 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RematchPage(title: title),
                ),
              );
            },
            child: Text('다시 풀어보기'),
          ),
        ]
      ),
    );
  }
}