import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebasedemo/screen/signin.dart';
import 'homepage.dart';

class Login extends StatefulWidget {
  final String title;

  const Login({Key key, this.title}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "                  Log In",
      //     style: TextStyle(fontSize: 30),
      //   ),
      // ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/image/1.png"),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(
                  "ยินดีต้อนรับ",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                
                Text(""),
                Image.asset(
                  "assets/image/5.png",
                  height: 150,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Text(""),
                Text(""),
                Text(
                  "ล็อกอินเพื่อเข้าใช้งานระบบ",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blueGrey[200],
                  ),
                ),
                Text(""),
                Text(""),
                GoogleSignInButton(
                    onPressed: () => signInwithGoogle().then((value) {
                          if (value != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Homepage(),
                                ),
                                (route) => false);
                          }
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
