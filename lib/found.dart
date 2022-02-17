import 'package:GoogleMaps/Report/Atak.dart';
import 'package:GoogleMaps/Report/Chachoengsao.dart';
import 'package:GoogleMaps/Report/Chai%20Nat.dart';
import 'package:GoogleMaps/Report/Chonburi.dart';
import 'package:GoogleMaps/Report/KhonKaen.dart';
import 'package:GoogleMaps/Report/Krabe.dart';
import 'package:GoogleMaps/Report/krungtep.dart';
import 'package:GoogleMaps/Report/kumpheng.dart';
import 'package:GoogleMaps/check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Report/Chanthaburi.dart';
import 'Report/Kalasin.dart';
import 'Report/Kanchanaburi.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "กระบี่", "age": "ใต้"},
    {"id": 2, "name": "กรุงเทพมหานคร", "age": "กลาง"},
    {"id": 3, "name": "กาญจนบุรี", "age": "ตะวันตก"},
    {"id": 4, "name": "กาฬสินธุ์", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 5, "name": "กำแพงเพชร", "age": "กลาง"},
    {"id": 6, "name": "ขอนแก่น", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 7, "name": "จันทบุรี", "age": "ตะวันออก"},
    {"id": 8, "name": "ฉะเชิงเทรา", "age": "ตะวันออก"},
    {"id": 9, "name": "ชลบุรี", "age": "ตะวันออก"},
    {"id": 10, "name": "ชัยนาท", "age": "กลาง"},
    {"id": 11, "name": "ชัยภูมิ", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 12, "name": "ชุมพร", "age": "ใต้"},
    {"id": 13, "name": "ตรัง", "age": "ใต้"},
    {"id": 14, "name": "ตราด", "age": "ตะวันออก"},
    {"id": 15, "name": "ตาก", "age": "ตะวันตก"},
    {"id": 16, "name": "นครนายก", "age": "กลาง"},
    {"id": 17, "name": "นครปฐม", "age": "กลาง"},
    {"id": 18, "name": "นครพนม", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 19, "name": "นครราชสีมา", "age": "ใต้"},
    {"id": 20, "name": "นครศรีธรรมราช", "age": "ใต้"},
    {"id": 21, "name": "นครสวรรค์", "age": "กลาง"},
    {"id": 22, "name": "นนทบุรี", "age": "ใต้"},
    {"id": 23, "name": "นราธิวาส", "age": "ใต้"},
    {"id": 24, "name": "น่าน", "age": "เหนือ"},
    {"id": 25, "name": "บึงกาฬ", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 26, "name": "บุรีรัมย์", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 27, "name": "ปทุมธานี", "age": "กลาง"},
    {"id": 28, "name": "ประจวบคีรีขันธ์", "age": "ตะวันตก"},
    {"id": 29, "name": "ปราจีนบุรี", "age": "ตะวันออก"},
    {"id": 30, "name": "ปัตตานี", "age": "ใต้"},
    {"id": 31, "name": "พระนครศรีอยุธยา", "age": "กลาง"},
    {"id": 32, "name": "พะเยา", "age": "เหนือ"},
    {"id": 33, "name": "พังงา", "age": "ใต้"},
    {"id": 34, "name": "พัทลุง", "age": "ใต้"},
    {"id": 35, "name": "พิจิตร", "age": "กลาง"},
    {"id": 36, "name": "พิษณุโลก", "age": "กลาง"},
    {"id": 37, "name": "ภูเก็ต", "age": "ใต้"},
    {"id": 38, "name": "มหาสารคาม", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 39, "name": "มุกดาหาร", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 40, "name": "ยะลา", "age": "ใต้"},
    {"id": 41, "name": "ยโสธร", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 42, "name": "ร้อยเอ็ด", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 43, "name": "ระนอง", "age": "ใต้"},
    {"id": 44, "name": "ระยอง", "age": "ตะวันออก"},
    {"id": 45, "name": "ราชบุรี", "age": "ตะวันตก"},
    {"id": 46, "name": "ลพบุรี", "age": "ใต้"},
    {"id": 47, "name": "ลำปาง", "age": "เหนือ"},
    {"id": 48, "name": "ลำพูน", "age": "เหนือ"},
    {"id": 49, "name": "ศรีสะเกษ", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 50, "name": "สกลนคร", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 51, "name": "สงขลา", "age": "ใต้"},
    {"id": 52, "name": "สตูล", "age": "ใต้"},
    {"id": 53, "name": "สมุทรปราการ", "age": "ใต้"},
    {"id": 54, "name": "สมุทรสงคราม", "age": "ใต้"},
    {"id": 55, "name": "สมุทรสาคร", "age": "ใต้"},
    {"id": 56, "name": "สระบุรี", "age": "กลาง"},
    {"id": 57, "name": "สระแก้ว", "age": "ตะวันออก"},
    {"id": 58, "name": "สิงห์บุรี", "age": "กลาง"},
    {"id": 59, "name": "สุพรรณบุรี", "age": "กลาง"},
    {"id": 60, "name": "สุราษฎร์ธานี", "age": "ใต้"},
    {"id": 61, "name": "สุรินทร์", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 62, "name": "สุโขทัย", "age": "กลาง"},
    {"id": 63, "name": "หนองคาย", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 64, "name": "หนองบัวลำภู", "age": "ใต้"},
    {"id": 65, "name": "อ่างทอง", "age": "กลาง"},
    {"id": 66, "name": "อำนาจเจริญ", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 67, "name": "อุดรธานี", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 68, "name": "อุตรดิตถ์", "age": "เหนือ"},
    {"id": 69, "name": "อุทัยธานี", "age": "กลาง"},
    {"id": 70, "name": "อุบลราชธานี", "age": "ใต้"},
    {"id": 71, "name": "เชียงราย", "age": "เหนือ"},
    {"id": 72, "name": "เชียงใหม่", "age": "เหนือ"},
    {"id": 73, "name": "เพชรบุรี", "age": "ตะวันตก"},
    {"id": 74, "name": "เพชรบูรณ์", "age": "กลาง"},
    {"id": 75, "name": "เลย", "age": "ตะวันออกเฉียงเหนือ"},
    {"id": 76, "name": "แพร่", "age": "เหนือ"},
    {"id": 77, "name": "แม่ฮ่องสอน", "age": "เหนือ"},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายชื่อจังหวัด'),
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["id"]),
                        color: Colors.teal[200],
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              switch (_foundUsers[index]["id"].toString()) {
                                case "1":
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Check10();
                                  }));
                                  break;
                                case "2":
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Check11();
                                  }));
                                  break;
                                case "3":
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Check8();
                                  }));
                                  break;
                                case "4":
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Check7();
                                  }));
                                  break;
                                case "5":
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Check12();
                                  }));
                                  break;
                                case "6":
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Check9();
                                  }));
                                  break;
                                case "7":
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Check14();
                                  }));
                                  break;
                                case "8":
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Check3();
                                  }));
                                  break;
                                default:
                              }
                            });
                          },
                          leading: Text(
                            _foundUsers[index]["id"].toString(),
                            style: const TextStyle(
                                fontSize: 24, color: Colors.black87),
                          ),
                          title: Text(_foundUsers[index]['name']),
                          subtitle: Text(
                              'ภาค:${_foundUsers[index]["age"].toString()} '),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
