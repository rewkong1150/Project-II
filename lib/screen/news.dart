import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final String jsonplaceholder = "http://jsonplaceholder.typicode.com/users/";
Future<Covid> fetchData() async {
  final response = await http.get(
      Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all'));
  final jsonresponse = json.decode(response.body);
  // print(response.body);
  return Covid.fromJson(jsonresponse);
}

class News extends StatefulWidget {
  const News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  String location = 'Null, Press Button';
  String Address = 'search';
  static Future<Covid> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchData();
    print(futureAlbum);
  }

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

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(7.892313, 98.367999);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality} ${place.subAdministrativeArea},${place.administrativeArea},${place.country}, ${place.postalCode}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Coordinates Points',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              location,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'ADDRESS',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('${Address}'),
            ElevatedButton(
                onPressed: () async {
                  Position position = await _getGeoLocationPosition();
                  location =
                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                  GetAddressFromLatLong(position);
                },
                child: Text('Get Location'))
          ],
        ),
      ),
    );
  }
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
