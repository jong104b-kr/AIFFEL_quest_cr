import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "";
  TextEditingController urlController =
  TextEditingController(); // URL을 입력 받는 컨트롤러

  Future<void> fetchData() async {
    try {
      final enteredUrl = urlController.text; // 입력된 URL 가져오기
      final response = await http.get(
        Uri.parse(enteredUrl + "sample"), // 입력된 URL 사용
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result =
          "predicted_label: ${data['predicted_label']}\nprediction_score: ${data['prediction_score']}";
          print(result);
        });
      } else {
        setState(() {
          result = "Failed to fetch data. Status Code: ${response.statusCode}";
          print(result);
        });
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Jellyfish Classfier"),
          centerTitle: true,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.alarm))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: ResizeImage(AssetImage('images/quest05_3.png'),
                  width: 300, height: 300),
            ),
            TextField(
              controller: urlController, // URL 입력을 위한 TextField
              decoration: InputDecoration(labelText: "URL 입력"), // 입력 필드의 라벨
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: fetchData,
                  child: Text("예측 결과"),
                ),
                ElevatedButton(
                  onPressed: fetchData,
                  child: Text("예측 확률"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
