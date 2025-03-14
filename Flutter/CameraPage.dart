import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  List<String> photos = ['1','2','3','4','5'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: GridView.builder(
          itemCount: photos.length,
          itemBuilder: (context, index){
            return Card(
              child: Column(
                children: [Text(photos[index]), Image.asset('images/sample.jpeg')],
              ),
            );
          },
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        ),
      ),
    );
  }
}