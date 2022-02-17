import 'package:GoogleMaps/screen/Screen.dart';
import 'package:GoogleMaps/screen/Screenmenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'main.dart';
import 'models/profile.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เข้าสู่ระบบ"),
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
                  Text("อีเมล", style: TextStyle(fontSize: 20)),
                  TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                        EmailValidator(errorText: "กรุณากรอกอีเมลให้ถูกต้อง")
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String email) {
                        profile.email = email;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator:
                        RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                    obscureText: true,
                    onSaved: (String password) {
                      profile.password = password;
                    },
                  ),
                  SizedBox(
                    child: const ColoredBox(color: Colors.amber),
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        "ลงชื่อเข้าใช้",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: profile.email,
                                    password: profile.password)
                                .then((value) {
                              formKey.currentState.reset();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Home();
                              }));
                            });
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            Fluttertoast.showToast(
                                msg: e.message, gravity: ToastGravity.CENTER);
                          }
                        }
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
