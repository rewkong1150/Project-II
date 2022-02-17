import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final String jsonplaceholder = "http://jsonplaceholder.typicode.com/users/";
Future<Covid> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces'));
  final jsonresponse = json.decode(response.body);
  // print(jsonDecode(response.body[0]));

  return Covid.fromJson(jsonresponse[18]);
}

class Check extends StatefulWidget {
  @override
  _CheckcState createState() => _CheckcState();
}

class _CheckcState extends State<Check> {
  static Future<Covid> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchData();
    print(futureAlbum);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid Report'),
        ),
        body: Center(
          child: FutureBuilder<Covid>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("วันที่: ${snapshot.data.txn_date.toString()}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("จังหวัด: ${snapshot.data.province.toString()}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("ผู้ป่วยใหม่: ${snapshot.data.new_case.toString()}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("ผู้ป่วยสะสม ${snapshot.data.total_case.toString()}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(
                        "เสียชีวิตล่าสุด ${snapshot.data.new_death.toString()}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(
                        "เสียชีวิตสะสม ${snapshot.data.total_death.toString()}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
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
