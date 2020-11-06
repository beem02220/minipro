import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String docid;

  const EditPage({Key key, this.docid}) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แก้ไขข้อมูล',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "ชื่อ",
                ),
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
                  border: OutlineInputBorder(),
                  labelText: "ยี่ห้อ",
                ),
                controller: _controller3,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              updateroom();
            },
            child: Text(
              'บันทึก',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getInfo() async {
    print(widget.docid);
    await FirebaseFirestore.instance
        .collection("telephone")
        .doc(widget.docid)
        .get()
        .then((value) {
      setState(() {
        _controller1 = TextEditingController(
          text: value.data()['generation'],
        );
        _controller2 =
            TextEditingController(text: value.data()['price'].toString());
        _controller3 = TextEditingController(
          text: value.data()['tel_type'],
        );
      });
    });
  }

  Future<void> updateroom() async {
    await FirebaseFirestore.instance
        .collection("telephone")
        .doc(widget.docid)
        .update({
      'generation': _controller1.text,
      'price': int.parse(_controller2.text),
      'tel_type': _controller3.text,
    }).whenComplete(() => Navigator.pop(context));
  }
}
