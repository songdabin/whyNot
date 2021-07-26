import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<List<String>> tableData = [
    ["교시", "월", "화", "수", "목", "금"],
    ["1", " ", " ", " ", " ", "실전프로젝트"],
    ["2", " ", "실전프로젝트", " ", " ", "실전프로젝트"],
    ["3", "컴퓨터 구조", "웹 서비스 개발", " ", "컴퓨터 구조", "이산수학"],
    ["4", " ", " ", " ", " ", " "],
    ["5", " ", "이산수학", "채플", " ", "이산수학"],
    ["6", "환경과 인간", " ", "팀모임", "환경과 인간", " "],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("홈"),
          centerTitle: true,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _text1(),
                Container(height: 10.0),
                Container(
                    width: 500.0,
                    height: 500.0,
                    child: Column(
                        children: this
                            .tableData
                            .map<Widget>((List<String> l) => Expanded(
                                  child: Row(
                                      children: l
                                          .map<Widget>((String i) => Expanded(
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color:
                                                                Colors.black)),
                                                    alignment: Alignment.center,
                                                    child: Text(i.toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black))),
                                              ))
                                          .toList()),
                                ))
                            .toList())),
              ],
            )));
  }

  Widget _text1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 20.0),
        Text(
          '시간표',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
