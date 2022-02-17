import 'dart:async';
import 'package:GoogleMaps/models/profile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Checklocation extends StatefulWidget {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  @override
  _ChecklocationState createState() => _ChecklocationState();
}

class _ChecklocationState extends State<Checklocation> {
  double a;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตำแหน่งที่คุณเคยไป'),
        backgroundColor: Colors.teal[800],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("rewkong@gmail.com")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map<Widget>((document) {
              return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(document["Place"].toString()),
                    subtitle: Text(document["Time(Date)"].toString()),
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
