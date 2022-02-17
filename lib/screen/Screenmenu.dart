import 'package:GoogleMaps/User/Datauser.dart';
import 'package:flutter/material.dart';
import '../check.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //static Future<Covid> futureAlbum;

  @override
  void initState() {
    super.initState();
    // futureAlbum = fetchData();
    // print(futureAlbum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 1),
            Text(
              'Select opion',
              style: TextStyle(fontSize: 40, color: Colors.purple),
            ),
            Spacer(flex: 1),
            Container(
              width: 360.0,
              height: 120.0,
              child: RaisedButton(
                child: Text(
                  "เช็คอาการ",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Text("Screen 2");
                  }));
                },
              ),
            ),
            Spacer(flex: 1),
            Container(
              width: 360.0,
              height: 120.0,
              child: RaisedButton(
                child: Text(
                  "เช็คlocationที่คุณเคยไป",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return;
                  }));
                },
              ),
            ),
            Spacer(flex: 1),
            Container(
              width: 360.0,
              height: 120.0,
              child: RaisedButton(
                child: Text(
                  "เช็คยอดผู้ติดเชื้อ",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return;
                  }));
                },
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MapsPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.near_me),
      ),*/
    );
  }
}
