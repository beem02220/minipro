import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/screen/edit.dart';
import 'package:firebasedemo/screen/page1.dart';
import 'package:firebasedemo/screen/signin.dart';
import 'package:flutter/material.dart';
import 'addpage.dart';
// import 'signin.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String user;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "               ข้อมูลสินค้า",
          style: TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                //signOut(context)
              }),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
              onPressed: () {
                signOut(context);
              }),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/image/3.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Addpage(),
                );
                Navigator.push(context, route);
              },
              child: Text(
                "เพิ่มข้อมูล",
                style: TextStyle(fontSize: 20),
              ),
            ),
            realTimeFood(),
          ],
        ),
      ),
    );
  }

  Widget realTimeFood() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("telephone").snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          default:
            return Column(
              children: makeListWidget(snapshot),
            );
        }
      },
    );
  }

  List<Widget> makeListWidget(AsyncSnapshot snapshot) {
    return snapshot.data.docs.map<Widget>((document) {
      return Card(
        child: ListTile(
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
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
                                "ต้องการลบข้อมูลหรือไม่",
                                style: TextStyle(fontSize: 25),
                              ))
                            ],
                          ),
                          actions: [
                            FlatButton(
                                child: Text(
                                  "ลบ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  deleteCosmetic(
                                      document.id); //-------ใส่ document id
                                  Navigator.of(context).pop();
                                }),
                            FlatButton(
                                child: Text(
                                  "ยกเลิก",
                                  style: TextStyle(fontSize: 20),
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ],
                        );
                      });
                }),
            leading: Container(
                //
                width: 90,
                child: Image.network(
                  document['img'],
                  fit: BoxFit.cover, //ใส่รูป
                )),
            title: Text(document['generation']),
            subtitle: Text(document['price'].toString()),
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => EditPage(docid: document.id),
              );
              Navigator.push(context, route);
            }),
      );
    }).toList();
  }

  // Future<void> deleteFood(id) async {
  //   await FirebaseFirestore.instance.collection('telephone').doc(id).delete();
  // }

  Future<void> deleteCosmetic(id) async {
    await FirebaseFirestore.instance.collection('telephone').doc(id).delete();
  }


  Future<void> signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      googleSignIn.signOut();
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        ModalRoute.withName('/'));
  }
}
