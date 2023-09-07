import 'dart:async';
import 'dart:convert';
import 'package:scholarship/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scholarship/firstpage.dart';
import 'package:scholarship/profile.dart';
import 'package:scholarship/searchbar.dart';
import 'package:scholarship/userpage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scholarship/filterlib.dart';
import 'package:scholarship/viewtundata.dart';


// ******** ตัวแปล ********
List? alltext;
late Map mapResponse;
List? listdata;
int? countItem;

class SearchResult extends StatefulWidget {
  final token;
  final query;
  const SearchResult({
    // **** arr *****
    @required 
    this.token,
    this.query,
    Key? key,
    }) : super(key: key);
  @override
  State<SearchResult> createState() => _SearchResultState();
}


class _SearchResultState extends State<SearchResult> {
  late String email;
  // late String formSearch;
  //  **** ค้นหาทุนจากช่องค้นหา *****
  Future getTun(String formSearch) async {
    print(formSearch);
    const path = baseUrl + "search";
    var searchResp = await http.post(Uri.parse(path),
      headers: {'Content_Type':'application/json; charset=UTF-8'},
      body: {
        "keysearch" : formSearch
      },
    );
    if(searchResp.statusCode == 200){
      setState(() {
        mapResponse = json.decode(searchResp.body.toString());
        listdata = mapResponse['scholarship'];
        countItem = listdata!.length;
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
    print(widget.query);
    getTun(widget.query);
    super.initState();
    // sentfilter();// <<<<< เรียกฟังก์ชั้นฟิลเตอร์
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['uemail'];
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
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => firstpage(token: widget.token)), (Route<dynamic> route) => false);
          },
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
              child: Text('ผลการค้นหาสำหรับ " '+widget.query+' " พบ '+countItem.toString()+' ทุน'),
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

    // itemTun(String sname, String sclass, String sfaculty, String sbranch, String country, String university){
    itemTun(String sname, String sclass, String sfaculty, String sbranch, String country, String pinnedcount, String id){
return Center(
      child: GestureDetector(
        onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTunData(token: widget.token,idTun: id,)));
        },
        child: Card(
          margin: EdgeInsets.all(10),
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



