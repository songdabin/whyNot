import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '아니 이거 왜 안돼',
      home: Scaffold(
        appBar: AppBar(
          title: Text('로그인'),
          backgroundColor: Color(0xFF3A70AF),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('로그인'),
                decoration: BoxDecoration(
                  color: Color(0xFF3A70AF),
                ),
              ),
            ],
          ),
        ),
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _idText(),
                Container(height: 16.0),
                Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.perm_identity),
                    ),
                  ),
                ),
                Container(height: 25.0),
                _passwordText(),
                Container(height: 16.0),
                Container(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                ),
                Container(height: 40.0),
                _loginButton(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _idText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 65.0),
        Text(
          '아이디',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _passwordText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 65.0),
        Text(
          '비밀번호',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 240.0),
        SizedBox(
          width: 120,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              //기능 추가
            },
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF3A70AF)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
