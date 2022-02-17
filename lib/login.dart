import 'package:GoogleMaps/log.dart';
import 'package:GoogleMaps/register.dart';
import 'package:flutter/material.dart';

class Longin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/Welcome.png",
                height: 90,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/พื้นหลัง.png"))),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          }));
                        },
                        icon: Icon(Icons.add),
                        label: Text(
                          "สร้างบัญชีผู้ใช้",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  SizedBox(
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        icon: Icon(Icons.login),
                        label: Text(
                          "เข้าสู่ระบบ",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
