import 'package:GoogleMaps/models/profile.dart';
import 'package:GoogleMaps/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../found.dart';
import '../map.dart';
import 'check location.dart';
import 'info_screen.dart';
import 'news.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

final String jsonplaceholder = "http://jsonplaceholder.typicode.com/users/";
Future<Covid> fetchData() async {
  final response = await http.get(
      Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all'));
  final jsonresponse = json.decode(response.body);
  print(jsonDecode(response.body));

  return Covid.fromJson(jsonresponse[0]);
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static Future<Covid> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchData();
    print(futureAlbum);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  String location = 'Null, Press Button';
  String Address = "secher";
  DateTime now = DateTime.now();
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _create() async {
    try {
      await firestore
          .collection(auth.currentUser.email)
          .doc(profile.place)
          .set({'Place': Address, 'Time(Date)': DateTime.now().toString()});
    } catch (e) {
      print(e);
    }
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    print(now);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality} ${place.subAdministrativeArea},${place.administrativeArea},${place.country}, ${place.postalCode}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Covid-19',
                style: textStyle(18, FontWeight.w600, Colors.white)),
          ],
        ),
        leading: IconButton(
          icon: Image.asset('assets/menu.png', width: 25),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/bell.png', width: 25),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.teal[800],
      ),
      body: ListView(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/covid-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment(1.5, 0),
                          padding: EdgeInsets.only(right: 60),
                          child: FutureBuilder<Covid>(
                            future: futureAlbum,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Total\n${snapshot.data.total_case.toString()}",
                                        style: textStyle(
                                            40, FontWeight.w800, Colors.white)),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              // By default, show a loading spinner.
                              return CircularProgressIndicator();
                            },
                          ),
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    mainCard(context),
                    SizedBox(height: 40),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Checklocation();
                                }));
                              },
                              child: regularCard('assets/map.svg', 'Map'),
                            ),
                          ),
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));
                              },
                              child: regularCard(
                                  'assets/virus.svg', 'Risk of\n infection'),
                            ),
                          ),
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Checkprofile();
                                }));
                              },
                              child: regularCard(
                                  'assets/upload.svg', 'Upload Data'),
                            ),
                          ),
                          // regularCard('assets/map.svg', 'Map'),
                          // regularCard(
                          //     'assets/virus.svg', 'Risk of\n infection'),
                          // regularCard('assets/upload.svg', 'Upload Data'),
                        ]),
                    SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Text("data4");
                                }));
                              },
                              child:
                                  regularCard('assets/trend.svg', 'Statistics'),
                            ),
                          ),
                          Container(
                            child: FlatButton(
                                padding: EdgeInsets.all(0.0),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return InfoScreen();
                                  }));
                                },
                                child: regularCard(
                                    'assets/facemask.svg', 'Protection')),
                          ),
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Text("data6");
                                }));
                              },
                              child:
                                  regularCard('assets/phone.svg', 'Contacts'),
                            ),
                          ),
                          /*regularCard('assets/trend.svg', 'Statistics'),
                            regularCard('assets/facemask.svg', 'Protection'),
                            regularCard('assets/phone.svg', 'Contacts'),*/
                        ])
                  ]),
                ),
              ],
            )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            _create();
            Position position = await _getGeoLocationPosition();
            location =
                'Lat: ${position.latitude} , Long: ${position.longitude}';
            GetAddressFromLatLong(position);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                      'Your location has been send !\n ${Address},\nDay:${now.day.toString()}\nTime${now.hour.toString()}:${now.minute.toString()}'),
                );
              },
            );
          },
          label: Text("Send Location"),
          icon: Icon(Icons.near_me),
          backgroundColor: Colors.teal[300]),
    );
  }

  SizedBox regularCard(String iconName, String cardLabel) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300], offset: Offset.zero, blurRadius: 20)
            ],
          ),
          child: SvgPicture.asset(iconName, width: 50),
        ),
        SizedBox(height: 5),
        Text(cardLabel,
            textAlign: TextAlign.center,
            style: textStyle(16, FontWeight.w600, Colors.black))
      ]),
    );
  }

  Container mainCard(context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset.zero, blurRadius: 20)
          ],
        ),
        child: Row(children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 140,
            child: Image.asset(
              "assets/rew.png",
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 150,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('ปฐมพร \n แก่นจันทร์',
                  style: textStyle(24, FontWeight.w800, Colors.black)),
              SizedBox(height: 16),
              Text('อายุ \23',
                  style: textStyle(20, FontWeight.w800, Colors.grey[600]))
            ]),
          ),
        ]));
  }

  TextStyle textStyle(double size, FontWeight fontWeight, Color colorName) =>
      TextStyle(
        fontFamily: 'QuickSand',
        color: colorName,
        fontSize: size,
        fontWeight: fontWeight,
      );
}

class Covid {
  final String txn_date;
  final String province;
  final int new_case;
  final int total_case;
  final int new_case_excludeabroad;
  final int total_case_excludeabroad;
  final int new_death;
  final int total_death;
  final String update_date;

  Covid(
      {this.txn_date,
      this.province,
      this.new_case,
      this.total_case,
      this.new_case_excludeabroad,
      this.total_case_excludeabroad,
      this.new_death,
      this.total_death,
      this.update_date});

  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
      txn_date: json["txn_date"] == null ? null : json["txn_date"],
      province: json["province"] == null ? null : json["province"],
      new_case: json["new_case"] == null ? null : json["new_case"],
      total_case: json["total_case"] == null ? null : json["total_case"],
      new_case_excludeabroad: json["new_case_excludeabroad"] == null
          ? null
          : json["new_case_excludeabroad"],
      total_case_excludeabroad: json["total_case_excludeabroad"] == null
          ? null
          : json["total_case_excludeabroad"],
      new_death: json["new_death"] == null ? null : json["new_death"],
      total_death: json["total_death"] == null ? null : json["total_death"],
      update_date: json["update_date"] == null ? null : json["update_date"],
    );
  }
}
