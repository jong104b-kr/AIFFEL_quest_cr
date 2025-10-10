import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'exam.dart';
import 'user.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메인 화면')),
      body: StreamBuilder<List<Exam>>(
        stream: Exam.getExams(),
        builder: (context,snapshot) {
          if(!snapshot.hasData) return CircularProgressIndicator();
          final exams = snapshot.data!;
          return ListView.builder(
            itemCount: exams.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(exams[index].subject),
                subtitle: Text('날짜:${exams[index].date}'),
                trailing: Text('${exams[index].score}점'),
              );
            },
          );
        },
      ),
    );
  }
}