import 'package:GoogleMaps/login.dart';
import 'package:GoogleMaps/models/profile.dart';
import 'package:GoogleMaps/screen/regisprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
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
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        "ลงทะเบียน",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: profile.email,
                                    password: profile.password)
                                .then((value) {
                              formKey.currentState.reset();
                              Fluttertoast.showToast(
                                  msg: "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                  gravity: ToastGravity.TOP);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterProfile();
                              }));
                            });
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            String message;
                            if (e.code == 'email-already-in-use') {
                              message = "มีอีเมลนี้ในระบบแล้ว โปรดใช้อีเมลอื่น";
                            } else if (e.code == 'weak-password') {
                              message = "มีอีเมลนี้ในระบบแล้ว โปรดใช้อีเมลอื่น";
                            } else {
                              message = e.message;
                            }
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
