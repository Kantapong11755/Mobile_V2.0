import 'dart:async';
import 'package:scholarship/config.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scholarship/profile.dart';
import 'package:scholarship/userpage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scholarship/filterlib.dart';
import 'package:scholarship/searchbar.dart';
import 'package:scholarship/viewtundata.dart';
// ตัวแปล
late Map mapResponse;
List? listdata;
// List? alltext;


class RecPage extends StatefulWidget {
  final token;
  const RecPage({
    @required this.token,
    Key? key,
    }) : super(key: key);
  @override
  State<RecPage> createState() => _RecPageState();
}

class _RecPageState extends State<RecPage> {
  late String email;
  
  // List<Map<String,dynamic>> ourname = [];


  void getrec() async{
    print(email);
    final path = baseUrl + "rectun";
    final resp = await http.post(Uri.parse(path),
    headers: {'Content_Type': 'application/json; charset=UTF-8'},
      body: {
        "email": email
      }
    );

    if(resp.statusCode == 200){
      setState(() {
        // responseData  = resp.body;
        mapResponse = json.decode(resp.body);
        listdata = mapResponse['scholarship'];
        // alltext = mapResponse['sname'];
      });
    }
  }


  static pinTun(id, email) async{
    var pinResp;
    final pinpath = baseUrl + "pin";
    print(id);
    pinResp = await http.post(Uri.parse(pinpath),
      headers: {'Content_Type':'application/json; charset=UTF-8'},
      body: {
        "id" : id,
        "email" : email
      }
    );
  }


  @override
  void initState(){
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['uemail'];
    getrec();
    super.initState();
    getfilter(); // <<<<< เรียกฟังก์ชั้นฟิลเตอร์
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.fromLTRB(8, 0, 8, 1),
       child:Container(
              width: 400,
              height: 690,
               child: ListView.builder(
                itemBuilder: (context, index){
                  return Container(
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        itemTun(listdata![index]['sname'].toString(),
                        listdata![index]['sclass'].toString(),
                        listdata![index]['sfaculty'].toString(),
                        listdata![index]['sbranch'].toString(),
                        listdata![index]['country'].toString(),
                        listdata![index]['pinnedcount'].toString(),
                        listdata![index]['_id'].toString(),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: listdata == null? 0: listdata!.length,
                ),
             ),
     );
   }

    // itemTun(String sname, String sclass, String sfaculty, String sbranch, String country, String university){
  itemTun(String sname, String sclass, String sfaculty, String sbranch,
      String country, String pinnedcount, String id) {
    return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTunData(token: widget.token,idTun: id,)));
    print("click");
    },
  child:Center(
    child : Card(
      margin: EdgeInsets.all(1),
      elevation: 0,
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 5),
                  color: Color.fromARGB(255, 95, 111, 255).withOpacity(.2),
                  spreadRadius: 5,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(220, 255, 255, 255),
                Color.fromARGB(220, 255, 255, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sname,
                      style: TextStyle(
                        fontFamily: 'NatoBold',
                        fontSize: 22,
                        color: Color.fromARGB(255, 95, 111, 255),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "ระดับ : " + sclass,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "คณะ : " + sfaculty,
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "สาขาวิชา : " + sbranch,
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "ประเทศ : " + country,
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "ปักหมุดแล้ว : " + pinnedcount,
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 90,
                right: 7,
                child: IconButton(
                  onPressed: (){
                    pinTun(id, email);
                    print("pinned");
                }, 
                icon: Icon(Icons.bookmark_add))
              ),
            ],
          ),
        ),
      ),
    ),
  )); 
  }
}

MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
  final getColor = (Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return colorPressed;
    } else {
      return color;
    }
  };
  return MaterialStateProperty.resolveWith(getColor);
}

MaterialStateProperty<BorderSide> getBorder(Color color, Color colorPressed) {
  final getBorder = (Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return BorderSide(color: colorPressed, width: 3);
    } else {
      return BorderSide(color: color, width: 3);
    }
  };
  return MaterialStateProperty.resolveWith(getBorder);
}


//filter
void openFilter(BuildContext context) => showModalBottomSheet(
  context: context,
  builder: (BuildContext context){
    return SizedBox(height: 600,
    child: Column(
      children: [
        SizedBox(height: 2),
        Text('ตัวคัดกรองการค้นหา',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        Container(
          height: 500,
          width: 350,
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
                    SizedBox(height: 2),

                    Text('ต้นหาจากประเทศ'),
                    SizedBox(
                      height: 32,
                      width: 300,
                    child: countrySelect()),
                    SizedBox(height: 2),
          
                    Text('ต้นหาจากระดับการศึกษา'),
                    SizedBox(
                      height: 32,
                      width: 300,
                    child: classSelect()),
                    SizedBox(height: 2),

                    Text('ต้นหาจากคณะ'),
                    SizedBox(
                      height: 32,
                      width: 300,
                    child: facultySelect()),
                    SizedBox(height: 2),

                    Text('ต้นหาจากสาขา'),
                    SizedBox(
                      height: 32,
                      width: 300,
                    child: branchSelect()),
                    SizedBox(height: 2),

                    Text('ต้นหาจากผลการเรียน'),
                    SizedBox(
                      height: 32,
                      width: 300,
                    child: GPAfilter()),
                    SizedBox(height: 2),

                    Text('ค้นหาจากมหาวิทยาลัย'),
                    SizedBox(
                      height: 32,
                      width: 300,
                    child: universitySelect()),
                    SizedBox(height: 2),

                    // ปุ่มค้นหา 
                    BtnSendDataFilter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),);
  });



