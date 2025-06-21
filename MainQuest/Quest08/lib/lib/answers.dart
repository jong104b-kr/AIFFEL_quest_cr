/* AnswerPage 라는 화면을 정의하며 사용자가 풀었던 문제들의 목록을 보여준다
* 이 코드는 Firebase Firestore를 사용하여 데이터베이스에서 데이터를 가져오고
* 사용자 인터페이스를 구성함
* */
import 'package:flutter/material.dart'; // Flutter의 Material Design 위젯을 사용하기 위한 패키지
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase 데이터베이스와 상호작용하기 위한 Firebase 패키지
import 'package:firebase_auth/firebase_auth.dart'; // Firebase 인증 서비스를 사용하기 위한 패키지
import 'package:intl/intl.dart'; // 날짜 포맷팅을 위해 import

import 'studydatadownloader.dart'; // 사용자 정의 모듈, 데이터 다운로드와 관련한 기능
import 'appbar.dart'; // 커스텀 앱바를 정의하는 모듈

/* StatefulWidget으로 정의되어 있으며 title이라는 필수 매개변수가 있다 */
class AnswersPage extends StatefulWidget {
  final String title;
  const AnswersPage({super.key, required this.title});

  /* 화면의 상태를 관리하는 클래스 */
  @override
  State<AnswersPage> createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
  List<QuestionAttempt> _attempts = []; // 사용자가 푼 문제들의 리스트를 저장하는 변수
  bool _isLoading = true; // 데이터가 로드 중인지 여부를 나타내는 플래그
  String _errorMessage = ''; // 오류 메시지를 저장하는 변수

  /* initState() 메서드는 화면이 처음 생성될 때 호출되며 사용자 인증을 확인하고
  Firestore에서 데이터를 가져옴. Firebase 인증 객체를 가져와 사용자가 로그인 되어있는지 확인함.
  Firebase에서 사용자의 'solvedQuestions' 컬렉션에서 데이터를 가져오며 최신순으로 정렬함.
   */
  @override
  void initState() {
    super.initState();
    _fetchSolvedQuestions();
  }

  /* Firestore에서 사용자의 풀이 데이터를 비동기적으로 가져옴.
  데이터를 성공적으로 가져오면 _attempts 리스트에 저장하고 UI를 갱신함.
  오류가 발생하면 오류 메시지를 설정하고 UI를 갱신함.
   */
  Future<void> _fetchSolvedQuestions() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = "로그인이 필요합니다.";
        });
      }
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('solvedQuestions')
          .orderBy('solvedAt', descending: true) // 최신순으로 정렬
          .get();

      if (mounted) {
        final attempts = snapshot.docs
            .map((doc) => QuestionAttempt.fromFirestore(doc))
            .toList();

        setState(() {
          _attempts = attempts;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = "데이터를 불러오는 중 오류가 발생했습니다: $e";
        });
      }
    }
  }

  /* build() 메서드는 Scaffold() 를 사용하여 화면의 기본구조를 만든다.
  _buildBody 함수를 호출하여 실제 내용을 구성한다.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(title: widget.title),
      /*
      _buildBody() 함수는 데이터 로딩 상태에 따라 다른 UI를 보여준다.
      데이터가 로드되면 ListView.builder를 사용하여 각 문제를 카드 형식으로 표시한다.
      각 문제의 정보(출처 시험 ID, 질문번호, 풀이 날짜, 질문 텍스트, 사용자의 답변, 정답 여부
      및 정답)을 표시함. DateFormat을 사용하여 날짜를 보기 좋게 포맷팅함.
       */
      body: _buildBody(),
    );
  }

  /*
  이 코드는 사용자가 풀었던 문제들을 Firebase Firestore에서 가져와 화면에 표시하는 기능을
  구현함. 또한, 사용자의 로그인 상태를 확인하고, 데이터 로딩 및 오류 처리를 적절히 수행함.
   */
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage, style: const TextStyle(color: Colors.red)));
    }

    if (_attempts.isEmpty) {
      return const Center(child: Text("아직 푼 문제가 없습니다."));
    }

    // 데이터가 성공적으로 로드된 경우 ListView를 표시
    return ListView.builder(
      itemCount: _attempts.length,
      itemBuilder: (context, index) {
        final attempt = _attempts[index];
        final localSolvedAt = attempt.solvedAt.toLocal();
        final formattedDate = DateFormat('yyyy년 MM월 dd일 HH:mm').format(localSolvedAt);

        // REVISED: correctAnswer의 타입에 따라 표시할 문자열을 결정하는 로직 추가
        String displayableCorrectAnswer;
        if (attempt.correctAnswer is List) {
          // 타입이 리스트이면, 원소들을 ', '로 합쳐서 보여줍니다.
          displayableCorrectAnswer = (attempt.correctAnswer as List).join(' || ');
        } else {
          // 리스트가 아니면(문자열 등), 그대로 문자열로 변환하여 사용합니다.
          displayableCorrectAnswer = attempt.correctAnswer.toString();
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${attempt.sourceExamId} ${attempt.originalQuestionNo}번",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  attempt.questionText,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      attempt.isCorrect ? Icons.check_circle : Icons.cancel,
                      color: attempt.isCorrect ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("내 답안: ${attempt.userAnswer}", style: const TextStyle(fontSize: 14)),
                          Text("실제 정답: $displayableCorrectAnswer", style: const TextStyle(fontSize: 14, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}