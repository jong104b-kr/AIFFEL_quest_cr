import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'question.dart'; // main함수 덮어쓸 경우 상대경로 /models/question.dart 반영 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuestionListScreen(),
    );
  }
}

class QuestionListScreen extends StatefulWidget {
  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  late Future<List<Question>> futureQuestions;

  @override
  void initState() {
    super.initState();
    Dio dio = Dio();
    futureQuestions = dio.get('http://localhost:5000/api/questions').then((response) {
      // Response.data는 JSON 형식의 스트링이므로 이를 리스트로 변환
      final List<dynamic> jsonData = response.data as List<dynamic>;
      // 리스트의 각 항목을 Question 객체로 변환
      return jsonData.map<Question>((e) => Question.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('시험 문제 목록')),
      body: FutureBuilder<List<Question>>(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final questions = snapshot.data!;
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(questions[index].text),
                  subtitle: Text(questions[index].choices.join(', ')),
                );
              },
            );
          }
        },
      ),
    );
  }
}