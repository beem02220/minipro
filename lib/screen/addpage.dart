import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class Addpage extends StatefulWidget {
  @override
  AddpageState createState() => AddpageState();
}

class AddpageState extends State<Addpage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  // ignore: unused_field
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    // var _bakerynamecontroller;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เพิ่มข้อมูล',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        chooseImage();
                      },
                      child: Text(
                        'เลือกรูป',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              child: _image == null
                  ? Text(
                      'ไม่ได้อัพโหลดรูปภาพ',
                      style: TextStyle(fontSize: 17),
                    )
                  : Image.file(_image),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "ชื่อ"),
                  controller: _controller1,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "ราคา"),
                  controller: _controller2,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "ยี่ห้อ"),
                  controller: _controller3,
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                addpage();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "ต้องการบันทึกข้อมูลหรือไม่",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          FlatButton(
                              child: Text(
                                'ยกเลิก',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          FlatButton(
                              child: Text(
                                'ตกลง',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => Homepage(),
                                );
                                Addpage();
                                Navigator.push(context, route);
                              })
                        ],
                      );
                    });
              },
              //ปุ่ม button บันทึกการแก้ไขข้อมูล
              child: Text(
                'เพิ่มข้อมูล',
                style: TextStyle(fontSize: 20),
              ),
              //color: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addpage(
      //  String bn,
      //  String bt,
      //  int p,
      //  String i,
      ) async {
    String fileName = Path.basename(_image.path);
    StorageReference reference =
        FirebaseStorage.instance.ref().child('$fileName');
    StorageUploadTask storageUploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((value) async {
      await FirebaseFirestore.instance.collection("telephone").add({
        'generation': _controller1.text,
        'price': int.parse(_controller2.text),
        'tel_type': _controller3.text,
        'img': value,
      });
    });
  }

  Future<void> chooseImage() async {
    // ignore: non_constant_identifier_names
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('ยังไม่ได้อัพโหลดรูปภาพ');
      }
    });
  }
}
