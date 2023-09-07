
// import ไฟล์นี้เข้าไป แล้วสรา้ง wedget Stateful
// เรียกใช้ฟังชั้น getfilter() ใน initState() ใน wedget ที่จะใช้
// เรียกใช้ dropdown ได้เลยตามคลาส
// ******* แต่ง dropdwon ในคลาสไฟล์นี่ได้เลย *********

import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as Path;
import 'package:scholarship/config.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scholarship/filterresult.dart';
import 'package:scholarship/searchresult.dart';
late Map mapResponse;
List? listdata;

late final token;
List<String> countryList = ["ทั้งหมด"];
List<String> stypeList = ["ทั้งหมด"];
List<String> facultyList = ["ทั้งหมด"];
List<String> branchList = ["ทั้งหมด"];
List<String> universityList = ["ทั้งหมด"];
List<String> classList = ["ทั้งหมด"];
List<String> gpaList = ["ทั้งหมด", "2.00", "2.25", "2.50", "2.75", "3.00", "3.25", "3.50", "3.75", "4.00"];

String? typetun;
String? countrytun;
String? facultytun;
String? branchtun;
String? universitytun;
String? classtun;
String? gpatun;

// ฟังก์ชั้นสร้าง List ของข้อมูลแต่ละฟิลเตอร์ แล้วเอาไปทำ dropdown
void getfilter() async{
  if(facultyList.length == 1){
    final path = baseUrl + "getfilteroption";
    final resp = await http.get(Uri.parse(path));

    if(resp.statusCode == 200){
        mapResponse = json.decode(resp.body);

        for(var i in mapResponse['stype']){
          stypeList.add(i);
        }
        for(var i in mapResponse['country']){
          countryList.add(i);
        }
        for(var i in mapResponse['sfaculty']){
          facultyList.add(i);
        }
        for(var i in mapResponse['sbranch']){
          branchList.add(i);
        }
        for(var i in mapResponse['university']){
          universityList.add(i);
        }
        for(var i in mapResponse['sclass']){
          classList.add(i);
        }
    }else{
      print('Connection error ...');
    }
  }else{
    print('data is exiting ...');
  }
}


// sentfilter() async {
//   print(typetun);
//   print(countrytun);
//   print(gpatun);
//   print(facultytun);
//   print(branchtun);
//   print(universitytun);
//   print(classtun);

//   if(typetun == null){
//     typetun = 'all';
//   }else{
//     print('-------');
//   }
//   if(countrytun == null){
//     countrytun = 'all';
//   }else{
//     print('-------');
//   }
//   if(facultytun == null){
//     facultytun = 'all';
//   }else{
//     print('-------');
//   }
//   if(branchtun == null){
//     branchtun = 'all';
//   }else{
//     print('-------');
//   }
//   if(universitytun == null){
//     universitytun = 'all';
//   }else{
//     print('-------');
//   }
//   if(classtun == null){
//     classtun = 'all';
//   }else{
//     print('-------');
//   }
//   if(gpatun == null){
//     gpatun = 'all';
//   }else{
//     print('-------');
//   }


//   final pathurl = baseUrl+"filter";
//   var resp = await http.post(Uri.parse(pathurl),
//     headers:  {'Content_Type':'application/json; charset=UTF-8'},
//     body: {
//       'type': typetun,
//       'country': countrytun,
//       'gpa': gpatun,
//       'faculty': facultytun,
//       'branch': branchtun,
//       'university': universitytun,
//       'class': classtun
//     }
//   );

//   if(resp.statusCode == 200){
//     mapResponse = json.decode(resp.body);
//     listdata = mapResponse['scholarship'];}
// }


// dropdown ประเภททุน
class stypeSelect extends StatefulWidget {
  const stypeSelect({super.key});

  @override
  State<stypeSelect> createState() => _stypeSelectState();
}

class _stypeSelectState extends State<stypeSelect> {
  List<String> stypeFilter = stypeList;
  String? stypeSelector = stypeList[0];


  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 60,
      child: DropdownButton<String>(
        isExpanded: true,
        value: stypeSelector,
        items: stypeFilter.map<DropdownMenuItem<String>>(
          (String value){
            return DropdownMenuItem<String>(
              child: Text(value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              value: value,
              );
          }
        ).toList(),
        onChanged: (String? newValue){
          setState(() {
            stypeSelector = newValue;
            typetun = newValue;
          });
        },
      ),
    );
  }
}



// dropdown ประเทศ
class countrySelect extends StatefulWidget {
  const countrySelect({super.key});

  @override
  State<countrySelect> createState() => _countrySelectState();
}

class _countrySelectState extends State<countrySelect> {
  List<String> countryFilter = countryList;
  String? countrySelector = countryList[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 60,
      child: DropdownButton<String>(
        isExpanded: true,
        value: countrySelector,
        items: countryFilter.map<DropdownMenuItem<String>>(
          (String value){
            return DropdownMenuItem<String>(
              child: Text(value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              value: value,
              );
          }
        ).toList(),
        onChanged: (String? newValue){
          setState(() {
            countrySelector = newValue;
            countrytun = newValue;
          });
        },
      ),
    );
  }
}



// dropdown ระดับการศึกษา
class classSelect extends StatefulWidget {
  const classSelect({super.key});

  @override
  State<classSelect> createState() => _classSelectState();
}

class _classSelectState extends State<classSelect> {
  List<String> classFilter = classList;
  String? classSelector = classList[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 60,
      child: DropdownButton<String>(
        isExpanded: true,
        value: classSelector,
        items: classFilter.map<DropdownMenuItem<String>>(
          (String value){
            return DropdownMenuItem<String>(
              child: Text(value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              value: value,
              );
          }
        ).toList(),
        onChanged: (String? newValue){
          setState(() {
            classSelector = newValue;
            classtun = newValue;
          });
        },
      ),
    );
  }
}



// dropdown คณะ
class facultySelect extends StatefulWidget {
  const facultySelect({super.key});

  @override
  State<facultySelect> createState() => _facultySelectState();
}

class _facultySelectState extends State<facultySelect> {
  List<String> facultyFilter = facultyList;
  String? facultySelector = facultyList[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: DropdownButton<String>(
        isExpanded: true,
        value: facultySelector,
        items: facultyFilter.map<DropdownMenuItem<String>>(
          (String value){
            return DropdownMenuItem<String>(
              child: Text(value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              value: value,
              );
          }
        ).toList(),
        onChanged: (String? newValue){
          setState(() {
            facultySelector = newValue;
            facultytun = newValue;
          });
        },
      ),
    );
  }
}



// dropdown สาชา
class branchSelect extends StatefulWidget {
  const branchSelect({super.key});

  @override
  State<branchSelect> createState() => _branchSelectState();
}

class _branchSelectState extends State<branchSelect> {
  List<String> branchFilter = branchList;
  String? branchSelector = branchList[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: DropdownButton<String>(
        isExpanded: true,
        value: branchSelector,
        items: branchFilter.map<DropdownMenuItem<String>>(
          (String value){
            return DropdownMenuItem<String>(
              child: Text(value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              value: value,
              );
          }
        ).toList(),
        onChanged: (String? newValue){
          setState(() {
            branchSelector = newValue;
            branchtun = newValue;
          });
        },
      ),
    );
  }
}



//  dropdown ระบุเกรด
class GPAfilter extends StatefulWidget {
  const GPAfilter({super.key});

  @override
  State<GPAfilter> createState() => _GPAfilterState();
}

class _GPAfilterState extends State<GPAfilter> {
  List<String> gpaFilter = gpaList;
  String? gpaSelector = gpaList[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 60,
      child: DropdownButton<String>(
        isExpanded: true,
        value: gpaSelector,
        items: gpaFilter.map<DropdownMenuItem<String>>(
          (String value){
            return DropdownMenuItem<String>(
              child: Text(value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              value: value,
              );
          }
        ).toList(),
        onChanged: (String? newValue){
          setState(() {
            gpaSelector = newValue;
            gpatun = newValue;
          });
        },
      ),
    );
  }
}



// dropdown สาชา
class universitySelect extends StatefulWidget {
  const universitySelect({super.key});

  @override
  State<universitySelect> createState() => _universitySelectState();
}

class _universitySelectState extends State<universitySelect> {
  List<String> universityFilter = universityList;
  String? universitySelector = universityList[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 60,
      child: DropdownButton<String>(
        isExpanded: true,
        value: universitySelector,
        items: universityFilter.map<DropdownMenuItem<String>>(
          (String value){
            return DropdownMenuItem<String>(
              child: Text(value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              value: value,
              );
          }
        ).toList(),
        onChanged: (String? newValue){
          setState(() {
            universitySelector = newValue;
            universitytun = newValue;
          });
        },
      ),
    );
  }
}



// btn ฟิลเตอร์
class BtnSendDataFilter extends StatefulWidget {
  final email;
  const BtnSendDataFilter({@required this.email, super.key});

  @override
  State<BtnSendDataFilter> createState() => _BtnSendDataFilterState();
}

class _BtnSendDataFilterState extends State<BtnSendDataFilter> {
  @override
  Widget build(BuildContext context) {
    return
      IconButton(
        onPressed: () {
          // sentfilter();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Resultfilter( email: widget.email,countrytun: countrytun, typetun: typetun, facultytun: facultytun, branchtun: branchtun, classtun: classtun, gpatun: gpatun, universitytun: universitytun,)), (Route<dynamic> route) => false);
          },
        icon: Icon(Icons.send));
  }
}