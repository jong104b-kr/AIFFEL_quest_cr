/*
이 Flutter코드는 IncorrectNotePage라는 화면을 정의하며 오답노트를 표시하는 기능을 제공한다.
이 화면은 StatelessWidget으로 구현되어 있으며, Scaffold와 Center 위젯을 사용하여 UI를 구성한다.
 */
import 'package:flutter/material.dart';

import 'appbar.dart';

/*
StatelessWidget으로 정의되어 있으며, title이라는 매개변수를 받는다. 이 매개변수는
이전 페이지의 제목을 의미한다.
 */
class IncorrectNotePage extends StatelessWidget {
  final String title; // 이전 페이지 제목을 받을 변수

  const IncorrectNotePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(title: title),
      body: const Center(
        child: Text(
          '오답노트 화면입니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}