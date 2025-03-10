import 'package:flutter/material.dart';
import 'package:flutter_lab/ch2/test.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativePluginWidget(),
    );
  }
}

class ScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: Text('ScannerPage'),//앱바 타이틀 (html타이틀 태그 비슷하게 작용)
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu)
              )
          ),
          body: Container(
            color: Colors.grey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ScannerPage',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),// 컨테이너, 디테일 스크린 텍스트 삽입
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/two');
                    },
                    child: Text('HomePage'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/five');
                    },
                    child: Text('ScannerPage'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/three');
                    },
                    child: Text('SignInPage'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class NativePluginWidget extends StatefulWidget {
  @override
  NativePluginWidgetState createState() => NativePluginWidgetState();
}

class NativePluginWidgetState extends State<NativePluginWidget> {
  XFile? _image;

  Future getGalleryImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future getCameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Picker")),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              ElevatedButton(
                child: Text('gallery'),
                onPressed: getGalleryImage
              ),
              Center(
                child: _image == null
                  ?Text(
                    'No image selected.',
                    style: TextStyle(color: Colors.white),
                  )
                  : CircleAvatar(
                    backgroundImage: FileImage(File(_image!.path)),
                    radius: 100,
                  ),
              ),
              ElevatedButton(
                  onPressed: getCameraImage,
                  child: Text('camera')
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

