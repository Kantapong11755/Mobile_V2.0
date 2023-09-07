// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scholarship/pinedpage.dart';
import 'package:scholarship/profile.dart';
import 'package:scholarship/reccom.dart';
import 'package:scholarship/scholarships.dart';
import 'package:scholarship/config.dart';
import 'package:scholarship/searchbar.dart';
import 'package:scholarship/filterlib.dart';


class firstpage extends StatefulWidget {
  final token;
  const firstpage({
    @required this.token,
    Key? key,
  }) : super(key: key);
  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  // send parameter
  //  vars
  late String email;
  var userData;
  var data;
  var spac = "  ";
  List<String> idpinned = [];

  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['uemail'];
  }

  // api
  Future getUserdata(email) async {
    final pathurl = baseUrl + "dataUser";
    final resp = await http.post(Uri.parse(pathurl),
        headers: {'Content_Type': 'application/json; charset=UTF-8'},
        body: {"uemail": email});
    if (resp.statusCode == 200) {
      userData = await jsonDecode(resp.body);
      data = userData['userData'];
      for (var x in data['pinned']) {
        idpinned.add(x);
      }
      print(idpinned);
    } else {
      print('.....');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              // centerTitle: true,
              backgroundColor: Colors.white,
              title: Text("Scholarships",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 95, 111, 255))),
              actions: [
                SearchBar(token: widget.token),
                // IconButton(
                //     onPressed: () {
                //     },
                //     color: Color.fromARGB(255, 95, 111, 255),
                //     iconSize: 35,
                //     icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => buildSheet()),
                    color: Color.fromARGB(255, 95, 111, 255),
                    iconSize: 35,
                    icon: Icon(Icons.filter_alt_rounded))
              ],
              bottom: TabBar(
                unselectedLabelColor: Color.fromARGB(255, 95, 111, 255),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 95, 111, 255),
                    Color.fromARGB(255, 137, 124, 255)
                  ]),
                  borderRadius: BorderRadius.circular(40),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                // labelStyle: TextStyle(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w500),
                tabs: [
                  Tab(
                    text: "แนะนำ",
                  ),
                  Tab(
                    text: "ทุนการศึกษา",
                  ),
                  Tab(
                    text: "ปักหมุด",
                  ),
                  Tab(
                    text: "บัญชีผู้ใช้",
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              // หน้า 1 (แนะนำ)
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: RecPage(token: widget.token)
              ),

              // หน้า 2 (ทุนการศึกษา)
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: ScholarShips(token: widget.token),
              ),

              // หน้า 3 (ปักหมุด)
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: PinPage(token: widget.token),
              ),
              // หน้า 4 (บัญชีผู้ใช้)
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: profile(token: widget.token),
              )
            ])));
  }
}


  Widget buildSheet() => ListView(
    children:  [
          SizedBox(height: 5),
          Text('ตัวคัดกรองการค้นหา',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Container(
            height: 385,
            // width: 350,
            child: ListView(
              children: [
                SizedBox(
                  child: Column(
                    children: const [
                      Text('ค้นจากประเภททุน'),
                      SizedBox(
                        height: 32,
                        width: 300,
                      child: stypeSelect()), //เรียก class dropdown มาใช้
                      SizedBox(height:5),
      
                      Text('ต้นหาจากประเทศ'),
                      SizedBox(
                        height: 32,
                        width: 300,
                      child: countrySelect()),
                      SizedBox(height: 5),
            
                      Text('ต้นหาจากระดับการศึกษา'),
                      SizedBox(
                        height: 32,
                        width: 300,
                      child: classSelect()),
                      SizedBox(height: 5),
      
                      Text('ต้นหาจากคณะ'),
                      SizedBox(
                        height: 32,
                        width: 300,
                      child: facultySelect()),
                      SizedBox(height: 5),
      
                      Text('ต้นหาจากสาขา'),
                      SizedBox(
                        height: 32,
                        width: 300,
                      child: branchSelect()),
                      SizedBox(height: 5),
      
                      Text('ต้นหาจากผลการเรียน'),
                      SizedBox(
                        height: 32,
                        width: 300,
                      child: GPAfilter()),
                      SizedBox(height: 5),

                      Text('ค้นหาจากมหาวิทยาลัย'),
                      SizedBox(
                        height: 32,
                        width: 300,
                      child: universitySelect()),
                      SizedBox(height: 15),
                      // ปุ่มค้นหา 
                      BtnSendDataFilter(),
                    ],
                  ),
                ),
              ],
            ),
          ),
    ],
  );