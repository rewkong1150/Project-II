import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit.dart';

class Checkprofile extends StatefulWidget {
  final auth = FirebaseAuth.instance;

  @override
  _CheckprofileState createState() => _CheckprofileState();
}

class _CheckprofileState extends State<Checkprofile> {
  double a;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติของคุณ'),
        backgroundColor: Colors.teal[800],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("profile").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map<Widget>((document) {
              return Card(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "ชื่อ",
                            style: TextStyle(fontSize: 35),
                          ),
                        )),
                    Text(
                      document["ชื่อ"].toString(),
                      style: TextStyle(fontSize: 30),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "สกุล",
                            style: TextStyle(fontSize: 35),
                          ),
                        )),
                    Text(document["สกุล"].toString(),
                        style: TextStyle(fontSize: 30)),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "ยาที่แพ้",
                            style: TextStyle(fontSize: 35),
                          ),
                        )),
                    Text(document["ยาที่แพ้"].toString(),
                        style: TextStyle(fontSize: 30)),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "เบอร์มือถือ",
                            style: TextStyle(fontSize: 35),
                          ),
                        )),
                    Text(document["เบอร์มือถือ"].toString(),
                        style: TextStyle(fontSize: 30))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditProfile();
          }));
        },
        child: new Icon(Icons.settings),
      ),
    );
  }
}
