import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class User extends StatelessWidget{
final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("ข้อมูลผู้ใช้"),),
      body: ListView.builder(itemBuilder: (BuildContext context,int index){
        return Card(
          child: ListTile(
            title: Text(auth.currentUser.email,style:TextStyle(fontSize: 15),),
          ),
        );
        })
        );
     }
   }