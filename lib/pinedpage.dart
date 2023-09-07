import 'package:scholarship/config.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scholarship/profile.dart';
import 'package:scholarship/userpage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scholarship/viewtundata.dart';
import 'package:scholarship/firstpage.dart';

late Map mapResponse;
List? listdata;

class PinPage extends StatefulWidget {
  final token;
  const PinPage({
    @required this.token,
    Key? key,
    }) : super(key: key);
  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  late String email;

  void getpinpage() async{
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['uemail'];
    const path = baseUrl + "pinpage";
    final resp = await http.post(Uri.parse(path),
      headers:{'Content_Type':'application/json; charset=UTF-8'},
      body: {
        "email" : email
      },
    );

    if(resp.statusCode == 200){
      setState(() {
        // responseData  = resp.body;
        mapResponse = json.decode(resp.body);
        listdata = mapResponse['scholarship'];
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
    getpinpage();
    super.initState();

    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['uemail'];
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
       child: ListView.builder(
        itemBuilder: (context, index){
          return Container(
            child: Column(
              children: [
                itemTun(listdata![index]['sname'].toString(),
                listdata![index]['sclass'] .toString(),
                listdata![index]['sfaculty'][0]+" และอื่นๆ".toString(),
                listdata![index]['sbranch'][0] +" และอื่นๆ".toString(),
                listdata![index]['country'].toString(),
                listdata![index]['pinnedcount'].toString(),
                listdata![index]['_id'].toString(),
                ),
                SizedBox(height: 15,),
              ],
            ),
          );
        },
        itemCount: listdata == null? 0: listdata!.length,
        ),
     );
   }

    // itemTun(String sname, String sclass, String sfaculty, String sbranch, String country, String university){
    itemTun(String sname, String sclass, String sfaculty, String sbranch, String country, String pinnedcount, String id){
return Center(
      child: GestureDetector(
        onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTunData(token: widget.token,idTun: id,)));
        },
        child: Card(
          margin: EdgeInsets.all(1),
          elevation: 0,
          color: Colors.transparent,
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
                      print("un pin");
                  }, 
                  icon: Icon(Icons.bookmark_remove))
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
