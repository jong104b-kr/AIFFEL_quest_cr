import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'GalleryPage.dart';
import 'CameraPage.dart';

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
      initialRoute: '/three',
      routes: {
        '/one': (context) => GalleryPage(),
        '/two': (context) => CameraPage(),
        '/three': (context) => MyApp()
      },
    );
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
    Navigator.of(context).pushNamed("/one");
  }

  Future getCameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    // Navigator.of(context).pushNamed("/two");
  }

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
                  onPressed: getGalleryImage,
                  child: Text('gallery')
              ),
              Center(
                child: _image == null
                ? Text('No image selected',style: TextStyle(color: Colors.white),
                )
                    : CircleAvatar(
                  backgroundImage: FileImage(File(_image!.path)), radius: 100,
                ),
              ),
              ElevatedButton(
                  onPressed: getCameraImage,
                  child: Text('camera')
              ),
            ]),
          ),
        )
      ),
    );
  }
}