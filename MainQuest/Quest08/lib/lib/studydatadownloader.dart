/*
이 코드는 QuestionAttempt라는 클래스를 정의하며 사용자가 특정 문제를 푼 기록을 나타냄.
이 클래스는 Firebase 데이터베이스와 연동하여 사용자의 문제 풀이 정보를 저장하고 불러오는데 사용됨.
final 속성들과 팩토리 생성자를 통해 데이터의 무결성을 유지하며, Firebase와의 상호작용을 간편하게 처리할 수 있음.
 */
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore 데이터베이스와 상호작용을 위한 패키지

/* 사용자 문제 풀이 기록을 나타내는 속성들을 포함함 */
class QuestionAttempt {
  final String userId; // 문제를 푼 사용자의 id
  final DateTime solvedAt; // Firestore의 Timestamp를 DateTime으로 변환하여 사용
  final bool isCorrect;
  final dynamic userAnswer;
  final String sourceExamId;
  final String originalQuestionNo;
  final String questionText;
  final dynamic correctAnswer;
  final String questionType;
  final Map<String, dynamic> fullQuestionData;

  QuestionAttempt({
    required this.userId,
    required this.solvedAt,
    required this.isCorrect,
    required this.userAnswer,
    required this.sourceExamId,
    required this.originalQuestionNo,
    required this.questionText,
    required this.correctAnswer,
    required this.questionType,
    required this.fullQuestionData,
  });

  // Firestore DocumentSnapshot으로부터 ProblemAttempt 객체를 생성하는 factory 생성자
  factory QuestionAttempt.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return QuestionAttempt(
      userId: data['userId'] ?? '',
      // Firestore의 Timestamp 타입은 toDate()를 통해 Dart의 DateTime으로 변환
      solvedAt: (data['solvedAt'] as Timestamp).toDate(),
      isCorrect: data['isCorrect'] ?? false,
      userAnswer: data['userAnswer'] ?? '답안 없음',
      sourceExamId: data['sourceExamId'] ?? '출처 없음',
      originalQuestionNo: data['originalQuestionNo'] ?? '번호 없음',
      questionText: data['questionText'] ?? '문제 내용 없음',
      correctAnswer: data['correctAnswer'] ?? '정답 정보 없음',
      questionType: data['questionType'] ?? '타입 없음',
      fullQuestionData: Map<String, dynamic>.from(data['fullQuestionData'] ?? {}),
    );
  }
}