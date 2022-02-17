import 'package:GoogleMaps/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../login.dart';

class RegisterProfile extends StatefulWidget {
  @override
  _RegisterProfileState createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _profile =
      FirebaseFirestore.instance.collection("profile");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สร้างบัญชีผู้ใช้"),
        backgroundColor: Colors.teal[800],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ชื่อ", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: RequiredValidator(errorText: "กรุณากรอกข้อมูล"),
                    keyboardType: TextInputType.name,
                    onSaved: (String name) {
                      profile.name = name;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("นามสกุล", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: RequiredValidator(errorText: "กรุณากรอกข้อมูล"),
                    keyboardType: TextInputType.name,
                    onSaved: (String sername) {
                      profile.sername = sername;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("เบอร์โทรศัพท์", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: RequiredValidator(errorText: "กรุณากรอกข้อมูล"),
                    onSaved: (String number) {
                      profile.number = number;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("ประวัติแพ้ยา", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: RequiredValidator(errorText: "กรุณากรอกข้อมูล"),
                    onSaved: (String beallergic) {
                      profile.beallergic = beallergic;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        "บันทึกข้อมูล",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          await _profile.add({
                            "ชื่อ": profile.name,
                            "นามสกุล": profile.sername,
                            "เบอร์มือถือ": profile.number,
                            "ยาที่แพ้": profile.beallergic,
                          });
                          formKey.currentState.reset();
                        }
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Longin();
                        }));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
