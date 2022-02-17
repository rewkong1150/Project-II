import 'package:GoogleMaps/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:provider/provider.dart';

final String jsonplaceholder = "http://jsonplaceholder.typicode.com/users/";
Future<Covid> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces'));
  final jsonresponse = json.decode(response.body);
  // print(response.body);
  return Covid.fromJson(jsonresponse);
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return TransactionProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'Covid Report',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Covid Report'),
            ),
            body: Consumer(
              builder: (context, TransactionProvider provider, Widget child) {
                return ListView.builder(
                    itemCount: provider.CoviddataList.length,
                    itemBuilder: (context, int index) {
                      Covid data = provider.CoviddataList[index];
                      return Card(
                        elevation: 30,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: FutureBuilder<Covid>(
                          future: futureAlbum,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      "วันที่: ${snapshot.data.txn_date.toString()}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "จังหวัด: ${snapshot.data.province.toString()}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "ผู้ป่วยใหม่: ${snapshot.data.new_case.toString()}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "ผู้ป่วยสะสม ${snapshot.data.total_case.toString()}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "เสียชีวิตล่าสุด ${snapshot.data.new_death.toString()}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "เสียชีวิตสะสม ${snapshot.data.total_death.toString()}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                          },
                        ),
                      );
                    });
              },
            )),
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

  List<Covid> CovidDataList = [];

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

  factory Covid.fromJson(List<dynamic> json) {
    if (json == null) {
      return null;
    } else {
      //print(json);
      Covid covidData = Covid();
      List<Covid> CovidList = [];

      json.forEach((element) => CovidList.add(Covid(
            txn_date: element["txn_date"] == null ? null : element["txn_date"],
            province: element["province"] == null ? null : element["province"],
            new_case: element["new_case"] == null ? null : element["new_case"],
            total_case:
                element["total_case"] == null ? null : element["total_case"],
            new_case_excludeabroad: element[" new_case_excludeabroad"] == null
                ? null
                : element[" new_case_excludeabroad"],
            total_case_excludeabroad:
                element["total_case_excludeabroad"] == null
                    ? null
                    : element["total_case_excludeabroad"],
            new_death:
                element["new_death"] == null ? null : element["new_death"],
            total_death:
                element["total_death"] == null ? null : element["total_death"],
            update_date:
                element["update_date"] == null ? null : element["update_date"],
          )));

      covidData.CovidDataList = CovidList;

      return covidData;
    }
  }
}
