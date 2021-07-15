import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

import 'home.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;

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
          return Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _idText(),
                  Container(height: 16.0),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.perm_identity),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(height: 25.0),
                  _passwordText(),
                  Container(height: 16.0),

                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(height: 40.0),
                  _loginButton(),
                ],
              ),
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
        Container(width: 65.0),
        SizedBox(
          width: 120,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _RegisterEmailSection(),
                ),
              );
              //기능 추가
            },
            child: Text(
              'Sign Up',
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
        Container(width: 20.0),
        SizedBox(
          width: 120,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              _signInWithEmailAndPassword();
              if (_success == true){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()
                  ),
                );
              }
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

  void _signInWithEmailAndPassword() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }
}


class _RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => _RegisterEmailSectionState();
}

class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  bool _passwordlength;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          backgroundColor: Color(0xFF3A70AF),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return ListView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 150.0),
                          _idText(),
                          Container(height: 16.0),
                          Container(
                            width: 300,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.perm_identity),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(height: 25.0),
                          _passwordText(),
                          Container(height: 16.0),

                          Container(
                            width: 300,
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.vpn_key),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                else if(value.length <= 6){
                                  return 'Password should be at least 6 characters';
                                }
                                else{
                                  return null;
                                }

                              },
                            ),
                          ),
                          Container(height: 40.0),
                          _loginButton(),


                        ],
                      ),
                    ),
                  )
                ]);
          }
        ));
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
        Container(width: 230.0),
        SizedBox(
          width: 120,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              if (_passwordController.text.length < 6){
                _passwordlength = false;
                print("Password should be at least 6 characters");
                return 'Password should be at least 6 characters';
              }
              _register();
              Navigator.pop(context);
              //기능 추가
            },
            child: Text(
              'Sign Up',
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

  void _signInWithEmailAndPassword() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  void _register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}


// class _EmailPasswordForm extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _EmailPasswordFormState();
// }
//
// class _EmailPasswordFormState extends State<_EmailPasswordForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _success;
//   String _userEmail;
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream:
//         FirebaseFirestore.instance.collection('Personal_File').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   child: const Text('ID'),
//                   //padding: const EdgeInsets.all(16),
//                   alignment: Alignment.bottomLeft,
//                 ),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(labelText: 'Email'),
//                   validator: (String value) {
//                     if (value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   child: const Text('PW'),
//                   //padding: const EdgeInsets.all(16),
//                   alignment: Alignment.bottomLeft,
//                 ),
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: const InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   validator: (String value) {
//                     if (value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       alignment: Alignment.center,
//                       child: RaisedButton(
//                         onPressed: () async {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => _RegisterEmailSection(),
//                             ),
//                           );
//                         },
//                         child: const Text('Sign Up'),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 80,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       alignment: Alignment.center,
//                       child: RaisedButton(
//                         onPressed: () async {
//                           if (_formKey.currentState.validate()) {
//                             _signInWithEmailAndPassword();
//                             snapshot.data.docs.map((document) {
//                               if (document['userId'].toString() ==
//                                   FirebaseAuth.instance.currentUser.uid
//                                       .toString()) {
//                                 if (document['position'] == 'Staff') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => StaffHomePage(),
//                                     ),
//                                   );
//                                 } else if (document['position'] == 'HM') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => HMHomePage(document1: document),
//                                     ),
//                                   );
//                                 } else if (document['position'] == 'HR') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => HRHomePage(),
//                                     ),
//                                   );
//                                 }
//                               }
//                             }).toList();
//                           }
//                         },
//                         child: const Text('Submit'),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     _success == null
//                         ? ''
//                         : (_success
//                         ? 'Successfully signed in ' + _userEmail
//                         : 'Sign in failed'),
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _signInWithEmailAndPassword() async {
//     final User user = (await _auth.signInWithEmailAndPassword(
//       email: _emailController.text,
//       password: _passwordController.text,
//     ))
//         .user;
//
//     if (user != null) {
//       setState(() {
//         _success = true;
//         _userEmail = user.email;
//       });
//     } else {
//       setState(() {
//         _success = false;
//       });
//     }
//   }
// }