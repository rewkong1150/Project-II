import 'dart:convert';

import 'package:GoogleMaps/check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// String jsonplaceholder = "http://jsonplaceholder.typicode.com/users/";
// Future<Covid> fetchData() async {
//   var http;
//   final response = await http.get(Uri.parse(
//       'https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces'));
//   final jsonresponse = json.decode(response.body);
//   // print(response.body);
//   return Covid.fromJson(jsonresponse);
// }

class TransactionProvider with ChangeNotifier {
  List<Covid> CoviddataList = [
    Covid(province: 'ตรัง'),
    Covid(province: 'กระบี่')
  ];
  // List<Covid> CoviddataList = [];
  List<Covid> getTransaction() {
    return CoviddataList;
  }
}
