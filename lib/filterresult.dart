import 'dart:async';
import 'dart:convert';
import 'package:scholarship/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scholarship/profile.dart';
import 'package:scholarship/searchbar.dart';
import 'package:scholarship/userpage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scholarship/filterlib.dart';


// ******** ตัวแปล ********
List? alltext;
late Map mapResponse;
List? listdata;
int? countItem;

class Resultfilter extends StatefulWidget {
  final token;
  final typetun;
  final countrytun;
  final facultytun;
  final branchtun;
  final universitytun;
  final classtun;
  final gpatun;
  final email;
  // final query;
  const Resultfilter({
    // **** arr *****
    @required 
    this.email,
    this.token,
    this.facultytun,
    this.branchtun,
    this.classtun,
    this.countrytun,
    this.gpatun,
    this.typetun,
    this.universitytun,
    Key? key,
    }) : super(key: key);
  @override
  State<Resultfilter> createState() => _ResultfilterState();
}


class _ResultfilterState extends State<Resultfilter> {
  late String email;
  
void sentfilter(typetun, countrytun, gpatun, facultytun, branchtun, universitytun, classtun) async {
  print(typetun);
  print(countrytun);
  print(gpatun);
  print(facultytun);
  print(branchtun);
  print(universitytun);
  print(classtun);

  if(typetun == null){
    typetun = 'all';
  }else{
    print('-------');
  }
  if(countrytun == null){
    countrytun = 'all';
  }else{
    print('-------');
  }
  if(facultytun == null){
    facultytun = 'all';
  }else{
    print('-------');
  }
  if(branchtun == null){
    branchtun = 'all';
  }else{
    print('-------');
  }
  if(universitytun == null){
    universitytun = 'all';
  }else{
    print('-------');
  }
  if(classtun == null){
    classtun = 'all';
  }else{
    print('-------');
  }
  if(gpatun == null){
    gpatun = 'all';
  }else{
    print('-------');
  }

  final pathurl = baseUrl+"filter";
  var resp = await http.post(Uri.parse(pathurl),
    headers:  {'Content_Type':'application/json; charset=UTF-8'},
    body: {
      'type': typetun,
      'country': countrytun,
      'gpa': gpatun,
      'faculty': facultytun,
      'branch': branchtun,
      'university': universitytun,
      'class': classtun
    }
  );

  if(resp.statusCode == 200){
    mapResponse = json.decode(resp.body);
    listdata = mapResponse['scholarship'];}
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
    getfilter();
    sentfilter(widget.typetun, widget.countrytun, widget.gpatun, widget.facultytun, widget.branchtun, widget.universitytun, widget.classtun);// <<<<< เรียกฟังก์ชั้นฟิลเตอร์
    super.initState();
    // Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    // email = jwtDecodedToken['uemail'];
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scholarship list',style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
          color: Colors.green,
          ),
          onPressed: () => Navigator.of(context).pop(),
          ),
        actions: [
          SearchBar(token: widget.token,),
            // filter
            IconButton(
              onPressed: () {
                openFilter(context);
              },
              icon: Icon(Icons.menu),
              color: Colors.black,
              )
        ],
      ),
       body: Column(
         children: [
            SizedBox(
              child: Text('พบ '+countItem.toString()+' ทุน'),
            ),
           Container(
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
         ],
       ),
     );
   }

    itemTun(String sname, String sclass, String sfaculty, String sbranch, String country, String pinnedcount, String id){
    return Container(
      width: 350,
      height: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,5),
                  color: Colors.deepOrange.withOpacity(.2),
                  spreadRadius: 5,
                  blurRadius: 10
                )
              ]
            ),
            child: Card(
              borderOnForeground: false,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // sname
                  Text(sname,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2,),
                  Text("ระดับ : "+sclass,
                  style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 2,),
                  Text("คณะ : "+sfaculty+"  สาขาวิชา : "+sbranch,
                  style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 2,),
                  Text("ประเทศ : " +country,
                  style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 2,),
                  Text("ปักหมุแล้ว : " +pinnedcount,
                  style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 2,),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blueAccent,
                    ),
                    onPressed: () {
                      pinTun(id, email);
                    },
                    child: Text('ปักหมุด'),
                  )
                ],
              ),
            ),
          );
  }
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
          height: 385,
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


