// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:scholarship/config.dart';

late Map mapResponse;
List? listdata;
List listFaculty = [];

class ViewTunData extends StatefulWidget {
  final token;
  final idTun;
  const ViewTunData({
    @required this.token,
    this.idTun,
    Key? key,
  }) : super(key: key);

  @override
  State<ViewTunData> createState() => _ViewTunDataState();
}

class _ViewTunDataState extends State<ViewTunData> {
  late String email;

  Future querydata(String idtun) async {
    print(idtun);
    final path = baseUrl + "thistun";
    var resp = await http.post(Uri.parse(path),
        headers: {'Content_Type': 'application/json; charset=UTF-8'},
        body: {"id": idtun});

    if (resp.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(resp.body);
        listdata = mapResponse['scholarship'];
        // for(var x in listdata![0]['sfaculty']){
        //   listFaculty.add(x);
        // }
      });
    } else {
      print('--------------------');
    }
  }

  @override
  void initState() {
    querydata(widget.idTun);
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['uemail'];
  }
  //  64f0795076f29317e4453a1b

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Color.fromARGB(255, 95, 111, 255),
          leadingWidth: 40,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios)),
          title: Text("Scholarships",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w800,
              )),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Text(""),
              title: Text("ชื่อทุน : "  +listdata.toString()),
              trailing: Text(""),
            ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("วันที่เปิดรับ : "  +listdata![0]['opendate'].toString()),
            //   trailing: Text(""),
            // ),
            //  ListTile(
            //   leading: Text(""),
            //   title: Text("วันที่ปิดรับ : "  +listdata![0]['closedate'].toString()),
            //   trailing: Text(""),
            // ),
            //  ListTile(
            //   leading: Text(""),
            //   title: Text("คณะ : "  +listdata![0]['sfaculty'].toString()),
            //   trailing: Text(""),
            // ),
            //  ListTile(
            //   leading: Text(""),
            //   title: Text("สาขา : "  +listdata![0]['sbranch'].toString()),
            //   trailing: Text(""),
            // ),
            //  ListTile(
            //   leading: Text(""),
            //   title: Text("ระดับการศึกษา : "  +listdata![0]['sclass'].toString()),
            //   trailing: Text(""),
            // ),
            //  ListTile(
            //   leading: Text(""),
            //   title: Text("เกรดเฉลี่ย : "  +listdata![0]['sgpa'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("มหาวิทยาลัย : "  +listdata![0]['university'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("ค่าใช้จ่าย : "  +listdata![0]['costoflive'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("ค่าเล่าเรียน : "  +listdata![0]['costoflean'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("ค่าที่พัก : "  +listdata![0]['costofabode'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("TOEIC : "  +listdata![0]['stoeic'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("TOEFL : "  +listdata![0]['stoefl'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("IELTS : "  +listdata![0]['sielts'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("ผู้ให้ทุน : "  +listdata![0]['sgiver'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("URL : "  +listdata![0]['url'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("จำนวนการปักหมุด : "  +listdata![0]['pinnedcount'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("วันที่ขูดข้อมูล : "  +listdata![0]['scrapdate'].toString()),
            //   trailing: Text(""),
            // ),
            // ListTile(
            //   leading: Text(""),
            //   title: Text("จำนวนการเข้าชม : "  +listdata![0]['watchcount'].toString()),
            //   trailing: Text(""),
            // ),

          ],
        

        // child: Text(' ชื่อทุน : ' +listdata![0]['sname'].toString()),
        
      ),
                      //   children: [
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: 30),
                      //     child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(""),
                      //           Text(' ชื่อทุน : ' +listdata![0]['sname'].toString()),
                      //               SizedBox(height: 8),
                      //           Text(' วันเปิดรับ : ' +listdata![0]['opendate'].toString()

                      // ),
                      //   ]),
                      //         ),
                              
                          

                          //       child: Column(
                          //         // mainAxisAlignment: MainAxisAlignment.end,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           SizedBox(
                          //             height: 10,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' ชื่อทุน : ' + listdata![0]['sname'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child:
                          //                 Text(' วันเปิดรับ: ' + listdata![0]['opendate'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child:
                          //                 Text(' วันปิดรับ: ' + listdata![0]['closedate'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             //รอทำแบบ array
                          //             child: Text(' คณะ: ' + listdata![0]['sfaculty'][0].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             //รอทำแบบ array
                          //             child: Text(' สาขา: ' + listdata![0]['sbranch'][0].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             //รอทำแบบ array
                          //             child:
                          //                 Text(' ระดับการศึกษา: ' + listdata![0]['sclass'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' ประเทศ: ' + listdata![0]['country'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' เกรด: ' + listdata![0]['sgpa'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(
                          //                 ' มหาวิทยาลัย: ' + listdata![0]['university'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' ค่ากิน: ' + listdata![0]['cosoflive'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' ค่าเรียน: ' + listdata![0]['cosoflean'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child:
                          //                 Text(' ค่าที่พัก: ' + listdata![0]['cosofabode'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' โทอิก: ' + listdata![0]['stoeic'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' โทเฟล: ' + listdata![0]['sielts'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' ผู้ให้ทุน: ' + listdata![0]['sgiver'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' URL: ' + listdata![0]['url'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(' จำนวนการปักหมุด: ' +
                          //                 listdata![0]['pinnedcount'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(
                          //                 ' วันที่ขูดข้อมูล: ' + listdata![0]['scrapdate'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           SizedBox(
                          //             child: Text(
                          //                 ' จำนวนการเข้าดู: ' + listdata![0]['watchcount'].toString()),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                  
        );
  }
}
