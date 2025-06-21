/*
이 코드는 FirestoreService 라는 유틸리티 클래스를 정의하며 사용자의 문제 풀이 기록을
Firestore 데이터베이스에 저장하는 기능을 제공함. FieldValue.serverTimestamp()를 사용하여
서버 시간을 자동으로 기록함으로써 사용자가 문제를 푼 정확한 시간을 저장할 수 있음.
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  /* 정적 변수 선언 */
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /* 매개변수(arguments or parameters) */
  static Future<void> saveQuestionAttempt({
    required String sourceExamId,
    required Map<String, dynamic> questionData,
    required String userAnswer,
    required bool isCorrect,
    int? score,
    String? feedback,
  }) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      print("사용자가 로그인하지 않았습니다. 풀이 기록을 저장할 수 없습니다.");
      return;
    }

    final dynamic answer = questionData['answer'];
    /* Firebase에 저장할 데이터를 구성함, 여기에는 사용자 id, 풀이시간, 정답여부, 사용자 답변,
    문제 출처, 문제 번호, 문제 텍스트, 정답 정보, 문제 유형 그리고 문제의 전체 데이터가 포함된다.
     */
    final attemptData = {
      'userId': currentUser.uid,
      'solvedAt': FieldValue.serverTimestamp(), // 서버 시간을 자동으로 기록하여 저장함.
      'isCorrect': isCorrect,
      'userAnswer': userAnswer,
      'sourceExamId': sourceExamId,
      'originalQuestionNo': questionData['no'] ?? '원본 번호 없음',
      'questionText': questionData['question'] ?? '질문 내용 없음',
      'correctAnswer': (answer is List)
          ? answer
          : (answer?.toString() ?? '정답 정보 없음'),
      'questionType': questionData['type'] ?? '타입 정보 없음',
      'fullQuestionData': questionData,
      'score': score,
      'feedback': feedback,
    };

    /*
    collection 메소드를 통해 사용자 문제 풀이 기록을 저장할 컬렉션을 생성하고, 해당 컬렉션에
    새로운 문서를 추가함.
     */
    try {
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('solvedQuestions')
          .add(attemptData);

      print("풀이 기록이 성공적으로 저장되었습니다.");
    } catch (e) {
      print("풀이 기록 저장 중 오류 발생: $e");
    }
  }

  /// 시험 한 세트의 전체 결과를 저장합니다.
  static Future<void> saveExamResult({
    required String sourceExamId,
    required String examTitle,
    required int timeTaken,
    required int totalScore,
    required List<Map<String, dynamic>> attemptsData, // 개별 문제 풀이 결과 리스트
  }) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      print("사용자가 로그인하지 않았습니다. 시험 결과를 저장할 수 없습니다.");
      return;
    }

    // 1. 저장할 ExamResult 데이터 모델을 구성합니다.
    final examResultDoc = {
      'userId': currentUser.uid,
      'sourceExamId': sourceExamId,
      'examTitle': examTitle,
      'solvedAt': FieldValue.serverTimestamp(), // 서버 시간 기준으로 저장
      'timeTaken': timeTaken,
      'totalScore': totalScore,
      'totalQuestions': attemptsData.length,
      'correctCount': attemptsData.where((a) => a['isCorrect'] == true).length,
      'attempts': attemptsData, // 문제 풀이 기록 리스트를 그대로 포함
    };

    try {
      // 2. 'users/{userId}/examResults' 컬렉션에 새로운 문서를 추가합니다.
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('examResults')
          .add(examResultDoc);

      print("시험 결과 세트가 성공적으로 저장되었습니다.");

      // (선택 사항) 개별 문제 기록도 기존처럼 저장하고 싶다면 여기서 반복문 실행
      // for (var attempt in attemptsData) {
      //   saveQuestionAttempt(
      //     questionData: attempt['fullQuestionData'],
      //     userAnswer: attempt['userAnswer'],
      //     isCorrect: attempt['isCorrect'],
      //   );
      // }

    } catch (e) {
      print("시험 결과 저장 중 오류 발생: $e");
    }
  }
}