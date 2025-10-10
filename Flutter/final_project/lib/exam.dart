import 'package:final_project/main.dart';

class Exam {
  final String id;
  final String subject;
  final DateTime date;
  final double score;

  Exam({
    required this.id,
    required this.subject,
    required this.date,
    required this.score,
  });

  /* Firestore에 시험 데이터 저장 */
  static Future<void> addExam(Exam exam) {
    return firestore.collection('exam').doc(exam.id).set({
      'subject': exam.subject,
      'date': exam.date.toIso8601String(),
      'score': exam.score,
    });
  }

  /* 모든 시험데이터 조회 */
  static Stream<List<Exam>> getExams() {
    return firestore.collection('exams').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Exam(
      id: doc.id,
      subject: doc['subject'],
      date: DateTime.parse(doc['date']),
      score: doc['score'],
    ))
        .toList());
  }
}