/*
이 플러터 코드는 QuestionListView라는 이름의 공통 ListView위젯을 정의한다.
이 위젯은 질문 목록을 표시하고, 각 질문엗 대한 사용자 인터렉션을 처리하는 기능을 제공함.
 */
import 'package:flutter/material.dart';
import 'questions_common.dart'; // 질문 관련 공통 코드와 유틸리티 함수를 포함한 모듈

/// 문제 목록을 표시하는 공통 ListView 위젯
class QuestionListView extends StatelessWidget {
  /// 표시할 질문 목록
  final List<Map<String, dynamic>> questions;

  /// Mixin으로부터 전달받는 콜백 함수 및 상태
  final List<TextEditingController> Function(String, int) getControllers;
  final void Function(Map<String, dynamic>) onCheckAnswer;
  final void Function(String) onTryAgain;
  final Map<String, bool?> submissionStatus;
  final Map<String, List<String>> userSubmittedAnswers;

  /// 각 페이지의 특성에 맞게 UI를 커스터마이징하기 위한 빌더 함수들
  final Widget Function(BuildContext context, Map<String, dynamic> questionData, int index) titleBuilder;
  final Widget? Function(BuildContext context, Map<String, dynamic> questionData, int index)? subtitleBuilder;
  final Widget? Function(BuildContext context, Map<String, dynamic> questionData, int index)? leadingBuilder;

  /* 생성자 */
  const QuestionListView({
    super.key,
    required this.questions, // 표시할 질문 목록
    required this.getControllers, // 질문의 컨트롤러를 가져오는 함수
    required this.onCheckAnswer, // 답변 체크 결과를 처리하는 함수
    required this.onTryAgain, // 다시 시도 기능을 처리하는 함수
    required this.submissionStatus, // 각 질문의 제출 상태를 저장하는 맵
    required this.userSubmittedAnswers, // 사용자가 제출한 답변을 저장하는 맵
    required this.titleBuilder, // 각 질문의 UI를 커스터마이징하는 빌더 함수
    this.subtitleBuilder, // 각 질문의 부제목 UI를 커스터마이징하는 옵셔널 빌더 함수
    this.leadingBuilder, // 각 질문의 리딩 UI(예: 아이콘)를 커스터마이징하는 옵셔널 빌더 함수
  });

  /* build() 메서드 */
  @override
  Widget build(BuildContext context) {
    return ListView.builder( // 질문 목록을 빌드함.
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      itemCount: questions.length, // 질문의 개수로 설정됨.
      /* 각 항목을 빌드하는 람다함수 */
      itemBuilder: (context, index) {
        final mainQuestionData = questions[index]; // 현재 항목의 질문 데이터
        final uniqueId = mainQuestionData['uniqueDisplayId'] as String; // 질문의 고유 식별자
        final type = mainQuestionData['type'] as String? ?? ''; // 질문 유형

        final subQuestionsField = mainQuestionData['sub_questions']; // 하위 질문 데이터를 포함할지 여부를 확인함
        final bool hasSubQuestions = subQuestionsField is Map<String, dynamic> && subQuestionsField.isNotEmpty;
        /* 확장 가능한 타일의 자식 위젯 리스트 */
        final List<Widget> expansionTileChildren = [
          const Divider(height: 1, thickness: 1),
          /* 질문과 관련된 사용자 인터렉션을 처리하는 위젯 */
          QuestionInteractiveDisplay(
            questionData: mainQuestionData,
            leftIndent: 16.0,
            displayNoWithPrefix: "풀이",
            questionTypeToDisplay: hasSubQuestions
                ? ""
                : ((type == "발문" || type.isEmpty) ? "" : " ($type)"),
            showQuestionText: false,
            getControllers: getControllers,
            onCheckAnswer: onCheckAnswer,
            onTryAgain: onTryAgain,
            submissionStatus: submissionStatus[uniqueId],
            userSubmittedAnswers: userSubmittedAnswers[uniqueId],
          ),
        ];

        // 하위 문제 (sub_questions) 처리
        if (hasSubQuestions) {
          List<String> sortedSubKeys = subQuestionsField.keys.toList()
            ..sort((a, b) => (int.tryParse(a) ?? 99999).compareTo(int.tryParse(b) ?? 99999));
          int subOrderCounter = 0;
          for (String subKey in sortedSubKeys) {
            final subQuestionValue = subQuestionsField[subKey];
            if (subQuestionValue is Map<String, dynamic>) {
              subOrderCounter++;
              final String subType = subQuestionValue['type'] as String? ?? '';
              expansionTileChildren.add(QuestionInteractiveDisplay(
                questionData: subQuestionValue,
                leftIndent: 24.0,
                displayNoWithPrefix: "($subOrderCounter)",
                questionTypeToDisplay: (subType == "발문" || subType.isEmpty) ? "" : " ($subType)",
                showQuestionText: true,
                getControllers: getControllers,
                onCheckAnswer: onCheckAnswer,
                onTryAgain: onTryAgain,
                submissionStatus: submissionStatus[subQuestionValue['uniqueDisplayId']],
                userSubmittedAnswers: userSubmittedAnswers[subQuestionValue['uniqueDisplayId']],
              ));

              // NEW: 하위-하위 문제 (sub_sub_questions) 처리 로직 추가
              final subSubQuestionsField = subQuestionValue['sub_sub_questions'];
              if (subSubQuestionsField is Map<String, dynamic> && subSubQuestionsField.isNotEmpty) {
                List<String> sortedSubSubKeys = subSubQuestionsField.keys.toList()
                  ..sort((a,b) => (int.tryParse(a) ?? 99999).compareTo(int.tryParse(b) ?? 99999));
                int subSubOrderCounter = 0;
                for (String subSubKey in sortedSubSubKeys) {
                  final subSubQValue = subSubQuestionsField[subSubKey];
                  if (subSubQValue is Map<String, dynamic>) {
                    subSubOrderCounter++;
                    final String subSubType = subSubQValue['type'] as String? ?? '';
                    expansionTileChildren.add(QuestionInteractiveDisplay(
                      questionData: subSubQValue,
                      leftIndent: 32.0, // 들여쓰기 추가
                      displayNoWithPrefix: " - ($subSubOrderCounter)",
                      questionTypeToDisplay: (subSubType == "발문" || subSubType.isEmpty) ? "" : " ($subSubType)",
                      showQuestionText: true,
                      getControllers: getControllers,
                      onCheckAnswer: onCheckAnswer,
                      onTryAgain: onTryAgain,
                      submissionStatus: submissionStatus[subSubQValue['uniqueDisplayId']],
                      userSubmittedAnswers: userSubmittedAnswers[subSubQValue['uniqueDisplayId']],
                    ));
                  }
                }
              }
            }
          }
        }

        /*
        Card와 ExpansionTile을 사용하여 각 질문을 카드 형태로 표시하고 확장 가능하게 만든다.
         */
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          elevation: 1.5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: ExpansionTile(
            key: ValueKey(uniqueId),
            tilePadding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.zero,
            /* UI 커스터마이징 */
            leading: leadingBuilder?.call(context, mainQuestionData, index),
            title: titleBuilder(context, mainQuestionData, index),
            subtitle: subtitleBuilder?.call(context, mainQuestionData, index),
            children: expansionTileChildren,
          ),
        );
      },
    );
  }
}