import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:GoogleMaps/models/profile.dart';
import 'package:flutter_svg/svg.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Position userLocation;
  GoogleMapController mapController;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _create() async {
    try {
      await firestore.collection(auth.currentUser.email).doc(profile.name).set({
        'latitude': userLocation.latitude,
        'longtitude': userLocation.longitude,
        'Time(Date)': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('MENU', style: textStyle(18, FontWeight.w600, Colors.white)),
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
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(userLocation.latitude, userLocation.longitude),
                  zoom: 15),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _create();
          mapController.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(userLocation.latitude, userLocation.longitude), 18));
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'Your location has been send !\nlat: ${userLocation.latitude} long: ${userLocation.longitude}(${now.day}/${now.month}/${now.year}Time:${now.hour}:${now.minute}) '),
              );
            },
          );
        },
        label: Text("Send Location"),
        icon: Icon(Icons.near_me),
      ),
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
              "assets/doctor.png",
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 150,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Symptoms \nChecker',
                  style: textStyle(24, FontWeight.w800, Colors.black)),
              SizedBox(height: 16),
              Text('Based on common \symptoms',
                  style: textStyle(16, FontWeight.w800, Colors.grey[600]))
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
